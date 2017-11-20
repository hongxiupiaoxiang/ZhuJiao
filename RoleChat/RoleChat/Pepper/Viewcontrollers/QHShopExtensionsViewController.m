//
//  QHShopExtensionsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHShopExtensionsViewController.h"
#import "QHPepperShopCell.h"

@interface QHShopExtensionsViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *modelArrM;

@end

@implementation QHShopExtensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modelArrM = [[NSMutableArray alloc] init];
    
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView registerClass:[QHPepperShopCell class] forCellReuseIdentifier:[QHPepperShopCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    // Do any additional setup after loading the view.
}

- (void)loadData {
    WeakSelf
    [QHProductModel queryProductWithType:self.productType pageIndex:self.pageIndex pageSize:kDefaultPagesize successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf stopRefresh];
        if (weakSelf.pageIndex == 1) {
            [weakSelf.modelArrM removeAllObjects];
        }
        NSArray *modelArr = [NSArray modelArrayWithClass:[QHProductModel class] json:responseObject[@"data"]];
        if (!modelArr.count) {
            weakSelf.pageIndex--;
        } else {
            [weakSelf.modelArrM addObjectsFromArray:modelArr];
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        weakSelf.pageIndex--;
        [weakSelf stopRefresh];
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHPepperShopCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHPepperShopCell reuseIdentifier]];
    cell.model = self.modelArrM[indexPath.row];
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
