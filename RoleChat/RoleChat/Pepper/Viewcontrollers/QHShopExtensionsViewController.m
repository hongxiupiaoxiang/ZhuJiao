//
//  QHShopExtensionsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHShopExtensionsViewController.h"
#import "QHPepperShopCell.h"
#import "QHShopDetailsViewController.h"

@interface QHShopExtensionsViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray<QHProductModel *> *modelArrM;

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
            if ([self.delegate respondsToSelector:@selector(setShopcount:)]) {
                [self.delegate setShopcount:[responseObject[@"data"][@"buycarnum"] integerValue]];
            }
        }
        NSArray *modelArr = [NSArray modelArrayWithClass:[QHProductModel class] json:responseObject[@"data"][@"products"]];
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
    WeakSelf
    QHPepperShopCell *cell = [tableView dequeueReusableCellWithIdentifier:[QHPepperShopCell reuseIdentifier]];
    cell.model = self.modelArrM[indexPath.row];
    cell.callback = ^(id params) {
        if ([params integerValue] == Purchase_Buy) {
            [weakSelf addProductToBuycarWithModel:weakSelf.modelArrM[indexPath.row] cellIndex:indexPath.row];
        } else {
            [weakSelf deleteProductFromBuycarWithModel:weakSelf.modelArrM[indexPath.row] cellIndex:indexPath.row];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QHShopDetailsViewController *detailsVC = [[QHShopDetailsViewController alloc] init];
    detailsVC.shopId = self.modelArrM[indexPath.row].productId;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)addProductToBuycarWithModel: (QHProductModel *)model cellIndex: (NSInteger)index {
    WeakSelf
    [QHProductModel addBuyCarWithProductid:model.productId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        model.isadd = @"2";
        [weakSelf.tableView reloadRow:index inSection:0 withRowAnimation:(UITableViewRowAnimationNone)];
        if ([weakSelf.delegate respondsToSelector:@selector(addShopmodel:)]) {
            [weakSelf.delegate addShopmodel:weakSelf.modelArrM[index]];
        }
    } failureBlock:nil];
}

- (void)deleteProductFromBuycarWithModel: (QHProductModel *)model cellIndex: (NSInteger)index {
    WeakSelf
    [QHProductModel deleteBuyCarWithProductid:model.productId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        model.isadd = @"1";
        [weakSelf.tableView reloadRow:index inSection:0 withRowAnimation:(UITableViewRowAnimationNone)];
        if ([weakSelf.delegate respondsToSelector:@selector(deleteShopmodel:)]) {
            [weakSelf.delegate deleteShopmodel:weakSelf.modelArrM[index]];
        }
    } failureBlock:nil];
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
