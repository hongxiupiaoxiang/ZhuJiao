//
//  QHLoginViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHLoginViewController.h"
#import "QHLoginView.h"
#import "QHLanguageSettingViewCtrl.h"
#import "QHNewUserRegistViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "QHForgotpassViewController.h"
#import "QHMainTabBarViewController.h"
#import "QHLoginModel.h"
#import "QHRealmLoginModel.h"
#import "QHPersonalInfo.h"
#import "QHPerfectInfoViewController.h"

#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface QHLoginViewController()<TencentSessionDelegate>

@property (nonatomic, strong) QHLoginView *loginView;

@end

@implementation QHLoginViewController {
    TencentOAuth *_tencentOAuth;
    NSMutableArray *_permissionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setupUI];
    
    [self loginWithToken];
    
    // 语言修改
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUI) name:LANGUAGE_CHAGE_NOTI object:nil];
    
    // 微信授权登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginWithWeixin:) name:WEIXIN_LOGIN object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_loginView.userNameTextField resignFirstResponder];
    [_loginView.userPassTextField resignFirstResponder];
}

#pragma mark 第三方授权登录
// 微信
- (void)authorityWithWeixin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        [WXApi sendReq:req];
    }
    else {
        [self setupAlertController];
    }
}
    
- (void)loginWithWeixin: (NSNotification *)noti {
    NSString *code = [noti.object objectForKey:@"code"];
    [self loginWithCode:code type:LoginType_Weixin];
}

- (void)setupAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"温馨提示", nil) message:QHLocalizedString(@"请先安装微信客户端!", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:QHLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}

// QQ
- (void)loginWithQQ {
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APPID andDelegate:self];
    
    _permissionArray = [NSMutableArray arrayWithObjects:kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    [_tencentOAuth authorize:_permissionArray inSafari:NO];
}

- (void)tencentDidLogin {
    [self loginWithCode:_tencentOAuth.openId type:LoginType_QQ];
}

- (void)loginWithCode: (NSString *)code type: (LoginType)type {
    if (!code.length) {
        [self showHUDOnlyTitle:QHLocalizedString(@"获取授权信息失败!", nil)];
    } else {
        [QHLoginModel authorityWithCode:code type:type successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[QHPersonalInfo sharedInstance] modelSetWithJSON:responseObject[@"data"]]) {
                [self configRealmData];
                [QHPersonalInfo sharedInstance].appLoginToken = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"localToken"]];
                if ([QHPersonalInfo sharedInstance].userInfo.phone.length) {
                    [self transitionToMainView];
                } else {
                    // 手机认证
                    QHPerfectInfoViewController *perfectInfoVC = [[QHPerfectInfoViewController alloc] init];
                    [self.navigationController pushViewController:perfectInfoVC animated:YES];
                }
            }
        } failureBlock:nil];
    }
}

#pragma mark 配置数据库
- (void)configRealmData {
    // 保证登录上次账号,清楚数据库缓存
    WeakSelf
    RLMResults *lastModels = [QHRealmLoginModel allObjectsInRealm:[QHRealmDatabaseManager defaultRealm]];
    [[QHRealmDatabaseManager defaultRealm] transactionWithBlock:^{
        [[QHRealmDatabaseManager defaultRealm] deleteObjects:lastModels];
    }];
    QHRealmLoginModel *model = [[QHRealmLoginModel alloc] init];
    [[QHRealmDatabaseManager defaultRealm] transactionWithBlock:^{
        model.userID = [QHPersonalInfo sharedInstance].userInfo.userID;
        model.ipArea = [QHPersonalInfo sharedInstance].ipArea;
        model.userName = [QHPersonalInfo sharedInstance].userInfo.username;
        model.loginPassword = [QHPersonalInfo sharedInstance].userInfo.loginPassword;
        model.appLoginToken = [QHPersonalInfo sharedInstance].appLoginToken;
        [[QHRealmDatabaseManager defaultRealm] addOrUpdateObject:model];
    }];
    
    if (socketIsConnected && [QHPersonalInfo sharedInstance].userInfo.phone.length) {
        [self sendManage];
    } else {
        [[QHSocketManager manager] connectServerWithUrlStr:IM_BASEURL connect:^{
            [[QHSocketManager manager] configVersion:@"1"];
            [weakSelf sendManage];
        } failure:^(NSError *error) {
            [[QHSocketManager manager] reconnect];
        }];
    }
}

#pragma mark Normal Login
- (void)loginWithPassword {
    WeakSelf
    [QHLoginModel apploginWithUsername:_loginView.userNameTextField.text password:_loginView.userPassTextField.text token:@"" successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[QHPersonalInfo sharedInstance] modelSetWithJSON:responseObject[@"data"]]) {
            [weakSelf configRealmData];
            [weakSelf transitionToMainView];
        }
    } failureBlock:nil];
}

- (void)loginWithToken {
    if (![QHRealmLoginModel allObjectsInRealm:[QHRealmDatabaseManager defaultRealm]].count) {
        return  ;
    }
    QHRealmLoginModel *model = [[QHRealmLoginModel allObjectsInRealm:[QHRealmDatabaseManager defaultRealm]] objectAtIndex:0];
    if (model && model.appLoginToken && model.appLoginToken.length) {
        _loginView.userNameTextField.text = model.userName;
        _loginView.userPassTextField.text = model.loginPassword;
    } else {
        return  ;
    }
    WeakSelf
    [QHLoginModel apploginWithUsername:model.userName password:@"" token:model.appLoginToken successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[QHPersonalInfo sharedInstance] modelSetWithJSON:responseObject[@"data"]]) {
            [QHPersonalInfo sharedInstance].appLoginToken = model.appLoginToken;
            [weakSelf configRealmData];
            [weakSelf transitionToMainView];
        }
    } failureBlock:nil];
}

#pragma mark UIButton Action
- (void)forgetPassword {
    QHForgotpassViewController *forgotpassVC = [[QHForgotpassViewController alloc] initWithTableViewStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:forgotpassVC animated:YES];
}

- (void)registUser {
    QHNewUserRegistViewController* registController = [[QHNewUserRegistViewController alloc] initWithTableViewStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:registController animated:YES];
}


- (void)changeLanguage {
    QHLanguageSettingViewCtrl* langCtrl = [[QHLanguageSettingViewCtrl alloc] init];
    langCtrl.title = QHLocalizedString(@"语言切换", nil);
    [self.navigationController pushViewController:langCtrl animated:YES];
}

#pragma mark SocketConnect
- (void)sendManage {
    [[QHSocketManager manager] authLoginWithCompletion:^(id response) {
        [[QHSocketManager manager] subscriptionUsersWithCompletion:nil failure:nil];
        [[QHSocketManager manager] subscriptionFriendRequestWithCompletion:nil failure:nil];
    } failure:nil];
}

#pragma mark 视图切换
- (void)setupUI {
    if (self.loginView != nil) {
        [self.loginView removeFromSuperview];
        self.loginView = nil;
    }
    
    self.loginView = [[QHLoginView alloc] init];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [self.loginView.switchLanguageBtn addTarget:self action:@selector(changeLanguage) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.confirmBtn addTarget:self action:@selector(loginWithPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgotPasswordBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registBtn addTarget:self action:@selector(registUser) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.qqBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.weixinBtn addTarget:self action:@selector(authorityWithWeixin) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.facebookBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)transitionToMainView {
    QHMainTabBarViewController *mainTabbarVC = [[QHMainTabBarViewController alloc] init];
    [UIView transitionFromView:self.navigationController.view toView:mainTabbarVC.view duration:kDefaultAnimationIntervalKey options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        App_Delegate.window.rootViewController = mainTabbarVC;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
