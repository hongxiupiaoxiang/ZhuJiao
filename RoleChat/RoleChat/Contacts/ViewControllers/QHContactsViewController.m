//
//  QHContactsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/25.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHContactsViewController.h"
#import "QHContactCell.h"
#import "BMChineseSort.h"
#import "QHInvitionListViewController.h"
#import "QHRealmFriendMessageModel.h"
#import "QHRealmContactModel.h"
#import "QHChatViewController.h"

@interface QHContactsViewController ()<UITableViewDelegate, UITableViewDataSource>

// 新的邀请数据库表通知
@property (nonatomic, strong) RLMNotificationToken *inviteToken;
// 添加好友数据库通知
@property (nonatomic, strong) RLMNotificationToken *newfriendToken;

@end

@implementation QHContactsViewController {
    UITableView *_mainView;
    NSMutableArray *_friendList;
    NSMutableArray *_alphaList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [super setupUI];
    
    [self configData];
    
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [_mainView registerClass:[QHContactCell class] forCellReuseIdentifier:[QHContactCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainView.backgroundColor = WhiteColor;
    
    [self configRealmToken];
}

- (void)configData {
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    RLMResults *result = [QHRealmContactModel allObjectsInRealm:[QHRealmDatabaseManager currentRealm]];
    for (QHRealmContactModel *model in result) {
        [arrM addObject:model];
    }
    _friendList = [BMChineseSort sortObjectArray:arrM.copy Key:@"nickname" secondKey:@"username"];
    _alphaList = [BMChineseSort IndexWithArray:arrM.copy Key:@"nickname" secondKey:@"username"];
}

- (void)configRealmToken {
    __weak typeof(_mainView)weakView = _mainView;
    WeakSelf
    self.inviteToken = [[QHRealmFriendMessageModel allObjectsInRealm:[QHRealmDatabaseManager currentRealm]] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed tp open Realm!");
            return ;
        }
        if (change) {
            [weakView reloadData];
        }
    }];
    
    self.newfriendToken = [[QHRealmContactModel allObjectsInRealm:[QHRealmDatabaseManager currentRealm]] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed tp open Realm!");
            return ;
        }
        if (change) {
            [weakSelf configData];
            [weakView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1+_alphaList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : [[_friendList objectAtIndex:section-1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHContactCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.headView.image = IMAGENAMED(@"Chat_invite");
            cell.nameLabel.text = QHLocalizedString(@"新的邀请", nil);
            cell.contentType = ContentType_Invite;
        } else {
            cell.headView.image = IMAGENAMED(@"Chat_group");
            cell.nameLabel.text = QHLocalizedString(@"群聊", nil);
        }
    } else {
        cell.contactModel = _friendList[indexPath.section-1][indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1f : 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QHInvitionListViewController *inviteVC = [[QHInvitionListViewController alloc] init];
            inviteVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:inviteVC animated:YES];
        }
    } else {
        QHChatViewController *chatVC = [[QHChatViewController alloc] init];
        chatVC.contactModel = _friendList[indexPath.section-1][indexPath.row];
        chatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView;
    if (section == 0) {
        bgView = [UIView new];
    } else {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        bgView.backgroundColor = RGBF5F6FA;
        
        UILabel *alpha = [UILabel labelWithFont:15 color:UIColorFromRGB(0xc5c6d1)];
        alpha.text = _alphaList[section-1];
        [bgView addSubview:alpha];
        [alpha mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(15);
        }];
    }
    return bgView;
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
