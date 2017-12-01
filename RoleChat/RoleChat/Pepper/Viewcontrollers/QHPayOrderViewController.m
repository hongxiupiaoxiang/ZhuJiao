//
//  QHPayOrderViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPayOrderViewController.h"
#import "QHOrderListCell.h"
#import "QHDetailOrderViewController.h"
#import "QHOrderModel.h"

@interface QHPayOrderViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray<QHOrderModel *> *modelArrM;

@end

@implementation QHPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"消费订单", nil);
    
    self.modelArrM = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[QHOrderListCell class] forCellReuseIdentifier:[QHOrderListCell reuseIdentifier]];
    
    WeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf loadData];
    }];
    
    [self startRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRefresh) name:CHANGESHOPORDERSTATE_NOTI object:nil];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [QHOrderModel queryOrdersWithPageIndex:self.pageIndex pageSize:kDefaultPagesize successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [self stopRefresh];
        if (self.pageIndex == 1) {
            [self.modelArrM removeAllObjects];
        }
        NSArray *modelArr = [NSArray modelArrayWithClass:[QHOrderModel class] json:responseObject[@"data"]];
        [self.modelArrM addObjectsFromArray:modelArr];
        if (!modelArr.count) {
            self.pageIndex --;
        } else {
            [self.tableView reloadData];
        }
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        self.pageIndex--;
        [self stopRefresh];
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHOrderListCell reuseIdentifier]];
    cell.model = self.modelArrM[indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHDetailOrderViewController *detailOrderVC = [[QHDetailOrderViewController alloc] init];
    detailOrderVC.orderModel = self.modelArrM[indexPath.row];
    [self.navigationController pushViewController:detailOrderVC animated:YES];
}

- (void)dealloc {
    NSLog(@"asdasd");
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
