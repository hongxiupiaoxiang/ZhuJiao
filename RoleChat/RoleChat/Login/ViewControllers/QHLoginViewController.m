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

@interface QHLoginViewController()

@property (nonatomic, strong) QHLoginView *loginView;

@end

@implementation QHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setupUI];
    
    [self loginWithToken];
    
    // 语言修改
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUI) name:kLanguageChangedNotification object:nil];
    // Do any additional setup after loading the view.
}

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
    [self.loginView.qqBtn addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.weixinBtn addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.facebookBtn addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)changeLanguage {
    QHLanguageSettingViewCtrl* langCtrl = [[QHLanguageSettingViewCtrl alloc] init];
    langCtrl.title = QHLocalizedString(@"语言切换", nil);
    [self.navigationController pushViewController:langCtrl animated:YES];
}

- (void)login {
    // 保证登录上次账号,清楚数据库缓存
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
    
    if (socketIsConnected) {
        [self sendManage];
    } else {
        //ws://im.sygqb.com:3000/websocket
        //ws://20.168.3.102:3000/websocket
        [[QHSocketManager manager] connectServerWithUrlStr:@"ws://20.168.3.102:3000/websocket" connect:^{
            [[QHSocketManager manager] configVersion:@"1"];
            [self sendManage];
        } failure:^(NSError *error) {
            [[QHSocketManager manager] reconnect];
        }];
    }
    
    QHMainTabBarViewController *mainTabbarVC = [[QHMainTabBarViewController alloc] init];
    [UIView transitionFromView:self.navigationController.view toView:mainTabbarVC.view duration:kDefaultAnimationIntervalKey options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        App_Delegate.window.rootViewController = mainTabbarVC;
    }];
}

- (void)loginWithPassword {
    WeakSelf
    [QHLoginModel apploginWithUsername:_loginView.userNameTextField.text password:_loginView.userPassTextField.text token:@"" successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[QHPersonalInfo sharedInstance] modelSetWithJSON:responseObject[@"data"]]) {
            [weakSelf login];
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
            [weakSelf login];
        }
    } failureBlock:nil];
}

- (void)forgetPassword {
    QHForgotpassViewController *forgotpassVC = [[QHForgotpassViewController alloc] initWithTableViewStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:forgotpassVC animated:YES];
}

- (void)registUser {
    QHNewUserRegistViewController* registController = [[QHNewUserRegistViewController alloc] initWithTableViewStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:registController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController isNavigationBarHidden] == NO)
        [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_loginView.userNameTextField resignFirstResponder];
    [_loginView.userPassTextField resignFirstResponder];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)sendManage {
    [[QHSocketManager manager] authLoginWithCompletion:^(id response) {
        [[QHSocketManager manager] authSetUsername:[QHPersonalInfo sharedInstance].userInfo.nickname completion:^(id response) {
            [[QHSocketManager manager] subsciptionWithCompletion:nil];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
