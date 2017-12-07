//
//  QHConversationViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/25.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHConversationViewController.h"
#import "QHConversationCell.h"
#import "QHChatViewController.h"
#import "QHRealmMListModel.h"

@interface QHConversationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RLMNotificationToken *messageToken;
@property (nonatomic, strong) NSMutableArray<QHRealmMListModel *> *conversationLists;

@end

@implementation QHConversationViewController {
    UITableView *_mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [super setupUI];
    
    _mainView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _mainView.backgroundColor = WhiteColor;
    [self.view addSubview:_mainView];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    [_mainView registerClass:[QHConversationCell class] forCellReuseIdentifier:[QHConversationCell reuseIdentifier]];
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self configData];
    
    [self configMessage];
}

- (void)configData {
    self.conversationLists = [[NSMutableArray alloc] init];
    if (self.conversationLists.count) {
        [self.conversationLists removeAllObjects];
    }
    RLMResults *result = [[QHRealmMListModel allObjectsInRealm:[QHRealmDatabaseManager currentRealm]] sortedResultsUsingKeyPath:@"ts.$date" ascending:NO];
    for (QHRealmMListModel *model in result) {
        [self.conversationLists addObject:model];
    }
}

- (void)configMessage {
    WeakSelf
    __weak typeof(_mainView)weakView = _mainView;
    self.messageToken = [[QHRealmMListModel allObjectsInRealm:[QHRealmDatabaseManager currentRealm]] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            DLog(@"Filed tp open Realm!");
            return ;
        }
        if (change) {
            [weakSelf configData];
            [weakView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversationLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHConversationCell reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.conversationLists[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHChatViewController *chatVC = [[QHChatViewController alloc] init];
//    chatVC.contactModel = [QHRealmContactModel objectInRealm:[QHRealmDatabaseManager currentRealm] forPrimaryKey:self.conversationLists[indexPath.row].u.username];
    RLMResults *results = [QHRealmContactModel objectsInRealm:[QHRealmDatabaseManager currentRealm] where:@"rid=%@",self.conversationLists[indexPath.row].rid];
    chatVC.contactModel = results[0];
    chatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
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
