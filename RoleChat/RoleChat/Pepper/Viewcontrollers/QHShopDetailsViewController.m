//
//  QHShopDetailsViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHShopDetailsViewController.h"
#import "QHCarButton.h"
#import "QHShopCarViewController.h"
#import "QHProductIntroduceCell.h"

typedef NS_ENUM(NSInteger,ShopType) {
    ShopType_None,
    ShopType_Add,
    ShopType_Buy
};

@interface QHShopDetailsViewController ()<QHShopCarDelegate>

@property (nonatomic, strong) QHProductModel *model;
@property (nonatomic, assign) ShopType shopType;

@end

@implementation QHShopDetailsViewController {
    QHCarButton *_rightBtn;
    UIButton *_bottomBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rightBtn = [[QHCarButton alloc] init];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    [_rightBtn addTarget:self action:@selector(gotoShop:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addRightItem:rightItem complete:nil];
    [_rightBtn setShopCount:[QHPersonalInfo sharedInstance].userInfo.carNum];
    // Do any additional setup after loading the view.
    
    self.title = QHLocalizedString(@"商品详情", nil);
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    self.tableView.estimatedRowHeight = 200;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[QHProductIntroduceCell class] forCellReuseIdentifier:[QHProductIntroduceCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-114, SCREEN_WIDTH, 50)];
    _bottomBtn.backgroundColor = WhiteColor;
    [_bottomBtn setTitle:QHLocalizedString(@"已购买", nil) forState:(UIControlStateNormal)];
    _bottomBtn.enabled = NO;
    [_bottomBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    _bottomBtn.titleLabel.font = FONT(16);
    [self.view addSubview:_bottomBtn];
    [_bottomBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self loadData];
}

- (void)gotoShop: (UIButton *)sender {
    QHShopCarViewController *shopCarVC = [[QHShopCarViewController alloc] init];
    shopCarVC.delegate = self;
    [self.navigationController pushViewController:shopCarVC animated:YES];
}

- (void)setShopType:(ShopType)shopType {
    _shopType = shopType;
    switch (shopType) {
        case ShopType_None:
            {
                [_bottomBtn setTitle:QHLocalizedString(@"加入购物车", nil) forState:(UIControlStateNormal)];
                [_bottomBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
                _bottomBtn.enabled = YES;
            }
            break;
        case ShopType_Add:
        {
            [_bottomBtn setTitle:QHLocalizedString(@"已加入购物车", nil) forState:(UIControlStateNormal)];
            [_bottomBtn setTitleColor:RGB939EAE forState:(UIControlStateNormal)];
            _bottomBtn.enabled = NO;
        }
            break;
        case ShopType_Buy:
        {
            [_bottomBtn setTitle:QHLocalizedString(@"已购买", nil) forState:(UIControlStateNormal)];
            [_bottomBtn setTitleColor:UIColorFromRGB(0xc5c6d1) forState:(UIControlStateNormal)];
            _bottomBtn.enabled = NO;
        }
            break;
        default:
            break;
    }
}

- (void)btnClick: (UIButton *)sender {
    if (self.model.productId.length) {
        [self showHUD];
        [QHProductModel addBuyCarWithProductid:self.model.productId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [self hideHUD];
            [self showHUDOnlyTitle:QHLocalizedString(@"添加购物车成功", nil)];
            self.shopType = ShopType_Add;
            [_rightBtn addShopCount];
            [QHPersonalInfo sharedInstance].userInfo.carNum++;
        } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    headView.backgroundColor = RGBF5F6FA;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 70)];
    bgView.backgroundColor = WhiteColor;
    [headView addSubview:bgView];
    
    UIImageView *shopView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [shopView loadImageWithUrl:self.model.imgurl placeholder:IMAGENAMED(@"Shop_audio")];
    [bgView addSubview:shopView];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:shopView cornerRedii:3];
    
    UILabel *nameLabel = [UILabel defalutLabel];
    nameLabel.text = self.model.name;
    [bgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).mas_offset(17);
        make.left.equalTo(shopView.mas_right).mas_offset(15);
    }];
    
    UILabel *amountLabel = [UILabel detailLabel];
    amountLabel.text = [NSString stringWithFormat:@"%@%.2f",[NSString getCurrencytagWithString:self.model.currency],[self.model.total floatValue]];
    [bgView addSubview:amountLabel];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(shopView);
        make.left.equalTo(nameLabel);
    }];
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    footerView.backgroundColor = RGBF5F6FA;
    
    UIImageView *shopView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 170)];
    shopView.image = IMAGENAMED(@"Rainfall");
    [footerView addSubview:shopView];
    
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHProductIntroduceCell *productCell = [tableView dequeueReusableCellWithIdentifier:[QHProductIntroduceCell reuseIdentifier]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7;
    if (self.model.content.length) {
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:self.model.content attributes:@{NSParagraphStyleAttributeName : paragraphStyle}];
        productCell.contentLabel.attributedText = attr;
    }
    return productCell;
}

- (void)loadData {
    [QHProductModel queryProductDetailWithProductid:self.shopId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        self.model = [QHProductModel modelWithJSON:responseObject[@"data"]];
        [self.tableView reloadData];
        if ([self.model.isbuy isEqualToString:@"2"]) {
            self.shopType = ShopType_Buy;
        } else if ([self.model.isadd isEqualToString:@"2"]) {
            self.shopType = ShopType_Add;
        } else {
            self.shopType = ShopType_None;
        }
    } failureBlock:nil];
}

- (void)deleteCarShop {
    [QHPersonalInfo sharedInstance].userInfo.carNum = 0;
    [_rightBtn setShopCount:0];
    self.shopType = ShopType_None;
}

- (void)deleteProduct:(QHProductModel *)model {
    [QHPersonalInfo sharedInstance].userInfo.carNum--;
    [_rightBtn decreaseCount];
    self.shopType = ShopType_None;
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
