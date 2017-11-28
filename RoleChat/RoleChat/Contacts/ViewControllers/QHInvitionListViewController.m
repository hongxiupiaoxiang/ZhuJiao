//
//  QHInvitionListViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHInvitionListViewController.h"
#import "QHInviteListCell.h"
#import "QHFriendInfoViewController.h"

@interface QHInvitionListViewController ()

@property (nonatomic, strong) RLMResults *inviteModels;

@end

@implementation QHInvitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"新朋友", nil);
    
    [self.tableView registerClass:[QHInviteListCell class] forCellReuseIdentifier:[QHInviteListCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WhiteColor;
    
    self.inviteModels = [QHRealmFriendMessageModel allObjectsInRealm:[QHRealmDatabaseManager currentRealm]];
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inviteModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf
    QHInviteListCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHInviteListCell reuseIdentifier]];
    QHRealmFriendMessageModel *model = self.inviteModels[indexPath.row];
    cell.messageModel = model;
    cell.agreeCallback = ^(QHRealmFriendMessageModel *params) {
        [weakSelf showHUD];
        [[QHSocketManager manager] acceptFriendRequestWithMessageId:model.messageId fromNickname:model.fromNickname flag:@"1" formId:model.fromId to:model.to completion:^(id response) {
            [weakSelf hideHUD];
            [weakSelf showHUDOnlyTitle:QHLocalizedString(@"添加成功", nil)];
            PerformOnMainThreadDelay(1.5, [weakSelf.navigationController popViewControllerAnimated:YES];);
            RLMResults *result = [QHRealmFriendMessageModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"messageId = %@",model.messageId];
            QHRealmFriendMessageModel *updateModel = result[0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[QHRealmDatabaseManager currentRealm] transactionWithBlock:^{
                    updateModel.read = YES;
                    updateModel.dealStatus = @"1";
                }];
            });
        } failure:^(id response) {
            [weakSelf hideHUD];
            [weakSelf showHUDOnlyTitle:QHLocalizedString(@"请求服务器失败", nil)];
        }];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHFriendInfoViewController *friendInfoVC = [[QHFriendInfoViewController alloc] init];
    [self.navigationController pushViewController:friendInfoVC animated:YES];
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
