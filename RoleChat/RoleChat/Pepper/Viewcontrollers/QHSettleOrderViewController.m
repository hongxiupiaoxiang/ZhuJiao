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

@interface QHSettleOrderViewController ()

@property (nonatomic, assign) NSInteger paymentIndex;

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
    
    _picArr = @[@"Shop_agr", @"Shop_zfb", @"Shop_wechat"];
    _titleArr = @[@"农业银行(2973)", @"支付宝", @"微信支付"];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 3 : 1;
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
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[QHBaseChooseCell reuseIdentifier]];
        ((QHBaseChooseCell *)cell).leftView.image = IMAGENAMED(_picArr[indexPath.row]);
        ((QHBaseChooseCell *)cell).titleLabel.text = _titleArr[indexPath.row];
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
            for (QHBaseViewController *subVC in self.navigationController.viewControllers) {
                if ([subVC isKindOfClass:[QHPayOrderViewController class]] || [subVC isKindOfClass:[QHPepperShopViewController class]]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGESHOPORDERSTATE_NOTI object:nil];
                    [self showHUDOnlyTitle:QHLocalizedString(@"支付成功", nil)];
                    PerformOnMainThreadDelay(1.5, [self.navigationController popToViewController:subVC animated:YES];);
                }
            }
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
