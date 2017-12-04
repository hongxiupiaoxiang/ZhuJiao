//
//  QHShopCarViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHShopCarViewController.h"
#import "QHPepperShopCell.h"
#import "QHAmountCell.h"
#import "QHSettleOrderViewController.h"
#import "QHOrderModel.h"

@interface QHShopCarViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *totalsum;
@property (nonatomic, strong) NSMutableArray<QHBuycarModel *> *modelArrM;

@end

@implementation QHShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"购物车", nil);
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:IMAGENAMED(@"Shop_trash") forState:(UIControlStateNormal)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self addRightItem:rightItem complete:nil];
    [rightBtn addTarget:self action:@selector(shopTrash:) forControlEvents:(UIControlEventTouchUpInside)];

    [self.tableView registerClass:[QHPepperShopCell class] forCellReuseIdentifier:[QHPepperShopCell reuseIdentifier]];
    [self.tableView registerClass:[QHAmountCell class] forCellReuseIdentifier:[QHAmountCell reuseIdentifier]];
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
    self.tableView.backgroundColor = WhiteColor;
    
    self.totalsum = @"0";
    self.modelArrM = [[NSMutableArray alloc] init];
    
    [self startRefresh];
    
    UIButton *commitOrderBtn = [[UIButton alloc] init];
    [commitOrderBtn addTarget:self action:@selector(commitOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    [commitOrderBtn setTitle:QHLocalizedString(@"提交订单", nil) forState:(UIControlStateNormal)];
    commitOrderBtn.titleLabel.font = FONT(16);
    [self.view addSubview:commitOrderBtn];
    commitOrderBtn.backgroundColor = MainColor;
    [commitOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRefresh) name:CHANGESHOPORDERSTATE_NOTI object:nil];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    WeakSelf
    [QHProductModel queryBuyCarWithPageIndex:self.pageIndex pageSize:kDefaultPagesize successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf stopRefresh];
        weakSelf.totalsum = responseObject[@"data"][@"totalsum"];
        if (weakSelf.pageIndex == 1) {
            [weakSelf.modelArrM removeAllObjects];
        }
        NSArray *modelArr = [NSArray modelArrayWithClass:[QHBuycarModel class] json:responseObject[@"data"][@"buyCars"]];
        if (!modelArr.count) {
            weakSelf.pageIndex--;
        } else {
            [weakSelf.modelArrM addObjectsFromArray:modelArr];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, id responseObject) {
        weakSelf.pageIndex--;
        [weakSelf stopRefresh];
    }];
}

- (void)commitOrder: (UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"提交订单", nil) message:QHLocalizedString(@"是否提交订单?", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"取消", nil) style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [QHOrderModel createOrderWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
            QHOrderModel *model = [QHOrderModel modelWithJSON:responseObject[@"data"]];
            QHSettleOrderViewController *settleVC = [[QHSettleOrderViewController alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            settleVC.orderModel = model;
            [self.navigationController pushViewController:settleVC animated:YES];
        } failureBlock:nil];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)shopTrash: (UIButton *)sender {
    WeakSelf
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:QHLocalizedString(@"清空购物车", nil) message:QHLocalizedString(@"是否删除所有商品?", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"取消", nil) style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *emptyAction = [UIAlertAction actionWithTitle:QHLocalizedString(@"清空", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [QHProductModel clearBuyCarWithSuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
            if ([weakSelf.delegate respondsToSelector:@selector(deleteCarShop)]) {
                [weakSelf.delegate deleteCarShop];
            }
            weakSelf.totalsum = @"0";
            [weakSelf.modelArrM removeAllObjects];
            [weakSelf.tableView reloadData];
        } failureBlock:nil];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:emptyAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    bgView.backgroundColor = RGBF5F6FA;
    return bgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.modelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 60 : 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHAmountCell reuseIdentifier]];
        ((QHAmountCell *)cell).amount = weakSelf.totalsum;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHPepperShopCell reuseIdentifier]];
        QHProductModel *productModel = self.modelArrM[indexPath.row].product;
        productModel.isbuy = @"1";
        productModel.isadd = @"2";
        ((QHPepperShopCell *)cell).model = productModel;
        ((QHPepperShopCell *)cell).callback = ^(id prama) {
            [QHProductModel deleteBuyCarWithProductid:productModel.productId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
                if ([weakSelf.delegate respondsToSelector:@selector(deleteProduct:)]) {
                    [weakSelf.delegate deleteProduct:productModel];
                }
                [weakSelf.modelArrM removeObjectAtIndex:indexPath.row];
                weakSelf.totalsum = [NSString stringWithFormat:@"%ld",[weakSelf.totalsum integerValue]-[productModel.total integerValue]];
                [weakSelf.tableView reloadData];
            } failureBlock:nil];
        };
    }
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
