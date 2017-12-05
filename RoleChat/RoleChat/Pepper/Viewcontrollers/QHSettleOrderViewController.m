//
//  QHSettleOrderViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSettleOrderViewController.h"
#import "QHBaseViewCell.h"
#import "QHBaseChooseCell.h"
#import "QHTextFieldAlertView.h"
#import "QHPaymentVerificationViewController.h"
#import "QHPayOrderViewController.h"
#import "QHPepperShopViewController.h"
#import "QHBankModel.h"
#import "QHWalletAccountViewController.h"
#import "QHBankPayViewController.h"

// 微信支付
#import "WXApi.h"

@interface QHSettleOrderViewController ()

@property (nonatomic, assign) NSInteger paymentIndex;
@property (nonatomic, strong) QHBankModel *bankModel;

@end

@implementation QHSettleOrderViewController {
    NSArray *_picArr;
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"结算订单", nil);
    
    [self.tableView registerClass:[QHBaseViewCell class] forCellReuseIdentifier:[QHBaseViewCell reuseIdentifier]];
    [self.tableView registerClass:[QHBaseChooseCell class] forCellReuseIdentifier:[QHBaseChooseCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WhiteColor;
    
    UIButton *orderBtn = [[UIButton alloc] init];
    [orderBtn addTarget:self action:@selector(order:) forControlEvents:(UIControlEventTouchUpInside)];
    [orderBtn setTitle:QHLocalizedString(@"支付", nil) forState:(UIControlStateNormal)];
    orderBtn.titleLabel.font = FONT(16);
    [self.view addSubview:orderBtn];
    orderBtn.backgroundColor = MainColor;
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-50);
    }];
    
    self.bankModel = [[QHBankModel alloc] init];
    
    _picArr = @[@"Shop_zfb", @"Shop_wechat"];
    _titleArr = @[QHLocalizedString(@"支付宝", nil), QHLocalizedString(@"微信支付", nil)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGESHOPORDERSTATE_NOTI object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCard:) name:SELECTBANKCARD_NOTI object:nil];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)changeCard: (NSNotification *)noti {
    self.bankModel = noti.userInfo[@"model"];
    [self.tableView reloadData];
}

- (void)loadData {
    [QHBankModel queryBankAccountWithPageIndex:1 pageSize:1 successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *models = [NSArray modelArrayWithClass:[QHBankModel class] json:responseObject[@"data"]];
        if (models.count) {
            self.bankModel = models[0];
            [self.tableView reloadData];
        }
    } failureBlock:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? (self.bankModel.bankId.length ? 3 : 2) : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 150 : 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.paymentIndex = indexPath.row;
        [self.tableView reloadData];
    } else {
        QHWalletAccountViewController *walletAccountVC = [[QHWalletAccountViewController alloc] init];
        walletAccountVC.type = WalletType_Choose;
        [self.navigationController pushViewController:walletAccountVC animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseChooseCell reuseIdentifier]];
        if (self.bankModel.bankId.length) {
            if (indexPath.row == 0) {
                [((QHBaseChooseCell *)cell).leftView setImageWithBankName:self.bankModel.bankName];
                ((QHBaseChooseCell *)cell).titleLabel.text = [NSString stringWithFormat:@"%@(%@)",self.bankModel.bankName,[self.bankModel.accountNumber substringWithRange:NSMakeRange(self.bankModel.accountNumber.length-4, 4)]];
            } else {
                ((QHBaseChooseCell *)cell).leftView.image = IMAGENAMED(_picArr[indexPath.row-1]);
                ((QHBaseChooseCell *)cell).titleLabel.text = _titleArr[indexPath.row-1];
            }
        } else {
            ((QHBaseChooseCell *)cell).leftView.image = IMAGENAMED(_picArr[indexPath.row]);
            ((QHBaseChooseCell *)cell).titleLabel.text = _titleArr[indexPath.row];
        }
        ((QHBaseChooseCell *)cell).isChoose = indexPath.row == self.paymentIndex;
        return cell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseViewCell reuseIdentifier]];
        ((QHBaseViewCell *)cell).leftView.image = IMAGENAMED(@"Shop_other");
        ((QHBaseViewCell *)cell).titleLabel.text = QHLocalizedString(@"使用其他账户", nil);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView;
    if (section == 0) {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        [[QHTools toolsDefault] addLineView:bgView :CGRectMake(0, 100, SCREEN_WIDTH, 10)];
        
        UILabel *titleLabel = [UILabel labelWithFont:15 color:RGB52627C];
        [bgView addSubview:titleLabel];
        titleLabel.text = QHLocalizedString(@"订单总价", nil);
        
        UILabel *amountLabel = [UILabel labelWithFont:20 color:RGB52627C];
        [bgView addSubview:amountLabel];
        NSString *originStr = [NSString stringWithFormat:@"%@ %.2f",[NSString getCurrencytagWithString:self.orderModel.currency],[self.orderModel.orderAmount floatValue]];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:originStr];
        [attr addAttribute:NSForegroundColorAttributeName value:MainColor range:[originStr rangeOfString:@"$"]];
        [attr addAttribute:NSForegroundColorAttributeName value:MainColor range:[originStr rangeOfString:@"¥"]];
        amountLabel.attributedText = attr;
        
        UILabel *paymentLabel = [UILabel detailLabel];
        paymentLabel.text = QHLocalizedString(@"请选择支付方式", nil);
        [bgView addSubview:paymentLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).mas_offset(25);
            make.left.equalTo(bgView).mas_offset(15);
        }];
        
        [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
            make.left.equalTo(bgView).mas_offset(15);
        }];
        
        [paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_top).mas_offset(130);
            make.left.equalTo(bgView).mas_offset(15);
        }];
    } else {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        bgView.backgroundColor = RGBF5F6FA;
    }
    
    return bgView;
}

- (void)order: (UIButton *)sender {
    if (self.paymentIndex == 2) {
        [QHOrderModel wechatOrderWithOrderid:self.orderModel.orderId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            PayReq *request = [[PayReq alloc] init];
            if (responseObject[@"param"]) {
                request.partnerId = [NSString stringWithFormat:@"%@",responseObject[@"param"][@"partnerId"]];
                request.prepayId= [NSString stringWithFormat:@"%@",responseObject[@"param"][@"prepayId"]];
                request.package = @"Sign=WXPay";
                request.nonceStr= [NSString stringWithFormat:@"%@",responseObject[@"param"][@"nonceStr"]];
                request.timeStamp = [[[NSString stringWithFormat:@"%@",responseObject[@"param"][@"timeStamp"]] substringToIndex:10] intValue];
                request.sign = [NSString stringWithFormat:@"%@",responseObject[@"param"][@"sign"]];
            }
            [WXApi sendReq:request];
        } failureBlock:nil];
    } else if (self.paymentIndex == 0) {
        [QHOrderModel bankPayOrderWithOrderid:self.orderModel.orderId txnAmt:self.orderModel.orderAmount successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            QHBankPayViewController *bankPayVC = [[QHBankPayViewController alloc] init];
            bankPayVC.webString = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            [self.navigationController pushViewController:bankPayVC animated:YES];
        } failureBlock:nil];
    } else {
        QHTextFieldAlertView *alertView = [[QHTextFieldAlertView alloc] initWithTitle:QHLocalizedString(@"支付密码", nil) placeholder:QHLocalizedString(@"请输入支付密码", nil) content:nil sureBlock:^(id params) {
            QHPaymentVerificationViewController *paymentVC = [[QHPaymentVerificationViewController alloc] init];
            [self.navigationController pushViewController:paymentVC animated:YES];
        } failureBlock:nil];
        [alertView show];
    }
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
