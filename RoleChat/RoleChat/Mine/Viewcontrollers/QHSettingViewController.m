//
//  QHSettingViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSettingViewController.h"
#import "QHBaseViewCell.h"
#import "QHLogoutModel.h"
#import "QHPasswordManagerViewController.h"
#import "QHLanguageSettingViewCtrl.h"
#import "QHCallStatusViewController.h"

@interface QHSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHSettingViewController {
    UITableView *_mainView;
    NSArray *_titleArr;
    NSArray *_picArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"设置", nil);
    _titleArr = @[QHLocalizedString(@"登录密码管理", nil), QHLocalizedString(@"支付密码管理", nil), QHLocalizedString(@"消息提醒", nil), QHLocalizedString(@"语言设置", nil)];
    _picArr = @[@"登录", @"支付", @"消息", @"语言"];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUI) name:LANGUAGE_CHAGE_NOTI object:nil];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [_mainView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
}

- (void)languageChanged {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? 10 : 170;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view;
    if (section == 0) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = UIColorFromRGB(0xf5f6fa);
    } else {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        view.backgroundColor = WhiteColor;
        UIButton *logoutBtn = [[UIButton alloc] init];
        [view addSubview:logoutBtn];
        [logoutBtn setTitle:QHLocalizedString(@"退出登录", nil) forState:(UIControlStateNormal)];
        [logoutBtn addTarget:self action:@selector(logout) forControlEvents:(UIControlEventTouchUpInside)];
        [logoutBtn setTitleColor:UIColorFromRGB(0xff4c79) forState:(UIControlStateNormal)];
        logoutBtn.titleLabel.font = FONT(16);
        logoutBtn.backgroundColor = WhiteColor;
        logoutBtn.layer.cornerRadius = 3;
        logoutBtn.layer.borderWidth = 1;
        logoutBtn.layer.borderColor = UIColorFromRGB(0xe6e7eb).CGColor;
        
        [logoutBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(15);
            make.right.equalTo(view).mas_offset(-15);
            make.top.equalTo(view).mas_offset(120);
            make.height.mas_equalTo(50);
        }];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHBaseViewController *targetVC;
    if (indexPath.section == 0) {
        targetVC = [[QHPasswordManagerViewController alloc] init];
        ((QHPasswordManagerViewController *)targetVC).passwordType = indexPath.row;
    } else {
        if (indexPath.row == 1) {
            targetVC = [[QHLanguageSettingViewCtrl alloc] init];
            targetVC.title = QHLocalizedString(@"语言设置", nil);
        } else {
            targetVC = [[QHCallStatusViewController alloc] init];
        }
    }
    if (targetVC) {
        [self.navigationController pushViewController:targetVC animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
    [cell.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
    }];
    UIView *bottomView = cell.contentView.subviews[2];
    [bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView).mas_offset(15);
    }];
    cell.leftView.image = IMAGENAMED(_picArr[indexPath.row+indexPath.section*2]);
    cell.titleLabel.text = _titleArr[indexPath.row+indexPath.section*2];
    return cell;
}

- (void)logout {
    [QHLogoutModel logoutWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [[QHSocketManager manager] unsubSciptionsWithCompletion:^(id response) {
            [[QHSocketManager manager] authLogoutWithCompletion:nil failure:nil];
        } failure:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN_NOTI object:nil];
    } failure:nil];
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
