//
//  QHMineViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/25.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHMineViewController.h"
#import "QHBaseViewCell.h"
#import "QHPeosoninfoCell.h"
#import "QHPersonalInfoViewController.h"
#import "QHSettingViewController.h"

@interface QHMineViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation QHMineViewController {
    UITableView *_mainView;
    NSArray *_titleArr;
    NSArray *_picArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = @[QHLocalizedString(@"财务管理", nil),QHLocalizedString(@"聊天记录管理", nil),QHLocalizedString(@"设置", nil),QHLocalizedString(@"检查升级", nil)];
    _picArr = @[@"affair_manage", @"message_manage", @"setting", @"update"];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [super setupUI];
    
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.backgroundColor = WhiteColor;
    
    [_mainView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
    [_mainView registerClass:[QHPeosoninfoCell class] forCellReuseIdentifier:[QHPeosoninfoCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHBaseViewController *targetVC;
    if (indexPath.row == 0) {
        targetVC = [[QHPersonalInfoViewController alloc] init];
    } else if (indexPath.row == 3) {
        targetVC = [[QHSettingViewController alloc] init];
    }
    targetVC.hidesBottomBarWhenPushed = YES;
    if (targetVC) {
        [self.navigationController pushViewController:targetVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 160 : 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHPeosoninfoCell reuseIdentifier]];
        ((QHPeosoninfoCell *)cell).headView.image = IMAGENAMED(@"RN_Icon");
        ((QHPeosoninfoCell *)cell).nameLabel.text = [QHPersonalInfo sharedInstance].userInfo.nickname;
        ((QHPeosoninfoCell *)cell).phoneLabel.text = [NSString stringWithFormat:@"+%@ %@",[QHPersonalInfo sharedInstance].userInfo.phoheCode,[QHPersonalInfo sharedInstance].userInfo.phone];
        ((QHPeosoninfoCell *)cell).qrView.image = IMAGENAMED(@"qrcode");
        ((QHPeosoninfoCell *)cell).addressLabel.text = [QHPersonalInfo sharedInstance].userInfo.userAddress;
        WeakSelf
        ((QHPeosoninfoCell *)cell).pasteBlock = ^{
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = [QHPersonalInfo sharedInstance].appLoginToken;
            [weakSelf showHUDOnlyTitle:QHLocalizedString(@"复制成功", nil)];
        };
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
        ((QHBaseViewCell *)cell).leftView.image = IMAGENAMED(_picArr[indexPath.row-1]);
        ((QHBaseViewCell *)cell).titleLabel.text = _titleArr[indexPath.row-1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
