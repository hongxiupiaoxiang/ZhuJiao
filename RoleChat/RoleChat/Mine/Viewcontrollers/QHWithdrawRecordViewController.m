//
//  QHWithdrawRecordViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWithdrawRecordViewController.h"
#import "QHOrderListCell.h"
#import "QHWithdrawDetailsViewController.h"
#import "QHDrawOrderModel.h"

@interface QHWithdrawRecordViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray<QHDrawOrderModel *> *modelArr;

@end

@implementation QHWithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"提现记录", nil);
    
    self.modelArr = [[NSMutableArray alloc] init];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn addTarget:self action:@selector(searchRecord) forControlEvents:(UIControlEventTouchUpInside)];
    [rightBtn setImage:IMAGENAMED(@"search") forState:(UIControlStateNormal)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QHOrderListCell class] forCellReuseIdentifier:[QHOrderListCell reuseIdentifier]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;
        [self loadData];
    }];
    [self startRefresh];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [QHDrawOrderModel queryDrawOrderWithPageindex:self.pageIndex pageSize:kDefaultPagesize successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self stopRefresh];
        if (self.pageIndex == 1) {
            [self.modelArr removeAllObjects];
        }
        NSArray *models = [NSArray modelArrayWithClass:[QHDrawOrderModel class] json:responseObject[@"data"]];
        if (models.count) {
            [self.modelArr addObjectsFromArray:models];
            [self.tableView reloadData];
        }
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self stopRefresh];
        self.pageIndex--;
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
}

- (void)searchRecord {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHWithdrawDetailsViewController *withdrawRecordVC = [[QHWithdrawDetailsViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    withdrawRecordVC.orderModel = self.modelArr[indexPath.row];
    [self.navigationController pushViewController:withdrawRecordVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHOrderListCell reuseIdentifier]];
    cell.orderModel = self.modelArr[indexPath.row];
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
