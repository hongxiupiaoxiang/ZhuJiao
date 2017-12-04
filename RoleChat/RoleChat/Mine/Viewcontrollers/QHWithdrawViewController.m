//
//  QHWithdrawViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWithdrawViewController.h"
#import "QHWalletAccountViewController.h"
#import "QHBankModel.h"
#import "QHDrawOrderModel.h"
#import "QHWithdrawDetailsViewController.h"

@interface QHWithdrawViewController ()<UITextFieldDelegate>

@end

@implementation QHWithdrawViewController {
    UITextField *_amountTF;
    UIImageView *_bankView;
    UILabel *_bankLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"提现", nil);
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCard:) name:SELECTBANKCARD_NOTI object:nil];
    // Do any additional setup after loading the view.
}

- (void)changeCard: (NSNotification *)noti {
    QHBankModel *model = (QHBankModel *)noti.userInfo[@"model"];
    self.model = model;
    [_bankView setImageWithBankName:model.bankName];
    _bankLabel.text = [NSString stringWithFormat:@"%@(%@)",model.bankName,[model.accountNumber substringWithRange:NSMakeRange(model.accountNumber.length-4, 4)]];
}

- (void)setupUI {
    UILabel *title = [UILabel defalutLabel];
    [self.view addSubview:title];
    title.text = QHLocalizedString(@"提现金额", nil);
    
    _amountTF = [[UITextField alloc] init];
    _amountTF.font = FONT(20);
    _amountTF.placeholder = QHLocalizedString(@"请输入提现金额", nil);
    [self.view addSubview:_amountTF];
    _amountTF.keyboardType = UIKeyboardTypeDecimalPad;
    _amountTF.delegate = self;
    
    __weak typeof(_amountTF)weakTF = _amountTF;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakTF resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
    
    UILabel *balanceAmount = [UILabel labelWithFont:12 color:RGB939EAE];
    [self.view addSubview:balanceAmount];
    balanceAmount.text = [NSString stringWithFormat:QHLocalizedString(@"可提现金额: $%@", nil),self.usdBalance];
//    if ([[QHLocalizable currentLocaleString] isEqualToString:@"en"]) {
//        balanceAmount.text = [NSString stringWithFormat:QHLocalizedString(@"可提现金额: $%@", nil),self.usdBalance];
//    } else {
//        balanceAmount.text = [NSString stringWithFormat:QHLocalizedString(@"可提现金额: ¥%@", nil),self.cnyBalance];
//    }
    
    UILabel *account = [UILabel  defalutLabel];
    [self.view addSubview:account];
    account.text = QHLocalizedString(@"提现到以下账户", nil);
    
    UIView *line1 = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    UIView *line2 = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    UIView *line3 = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    
    UIButton *bgBtn = [[UIButton alloc] init];
    [bgBtn addTarget:self action:@selector(chooseBank) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bgBtn];
    
    _bankView = [[UIImageView alloc] init];
    [_bankView setImageWithBankName:self.model.bankName];
    [bgBtn addSubview:_bankView];
    
    _bankLabel = [UILabel defalutLabel];
    [bgBtn addSubview:_bankLabel];
    _bankLabel.text = [NSString stringWithFormat:@"%@(%@)",self.model.bankName,[self.model.accountNumber substringWithRange:NSMakeRange(self.model.accountNumber.length-4, 4)]];
    
    UIImageView *rightView = [[UIImageView alloc] init];
    rightView.image = IMAGENAMED(@"common_arrow");
    [bgBtn addSubview:rightView];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    [confirmBtn setTitle:QHLocalizedString(@"确定", nil) forState:(UIControlStateNormal)];
    confirmBtn.backgroundColor = MainColor;
    confirmBtn.layer.cornerRadius = 3.0f;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(withdraw) forControlEvents:(UIControlEventTouchUpInside)];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(30);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [_amountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).mas_offset(10);
        make.left.equalTo(self.view).mas_offset(15);
        make.height.mas_equalTo(60);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).mas_offset(71);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [balanceAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).mas_offset(15);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceAmount.mas_bottom).mas_offset(60);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(account.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).mas_offset(70);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(line2.mas_bottom);
        make.bottom.equalTo(line3.mas_top);
    }];
    
    [_bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(bgBtn);
        make.left.equalTo(bgBtn).mas_offset(15);
    }];
    
    [_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgBtn);
        make.left.equalTo(_bankView.mas_right).mas_offset(15);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgBtn);
        make.right.equalTo(bgBtn).mas_offset(-15);
    }];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).mas_offset(110);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)chooseBank {
    QHWalletAccountViewController *walletAccountVC = [[QHWalletAccountViewController alloc] init];
    walletAccountVC.type = WalletType_Choose;
    [self.navigationController pushViewController:walletAccountVC animated:YES];
}

- (void)withdraw {
    if (!_amountTF.text.length) {
        [self showHUDOnlyTitle:QHLocalizedString(@"请输入提现金额", nil)];
        return;
    }
    if (!self.model) {
        [self showHUDOnlyTitle:QHLocalizedString(@"获取账户银行失败", nil)];
        return;
    }
    [QHDrawOrderModel createDrawOrderWithAmount:_amountTF.text currency:@"USD" bankAmountId:self.model.bankId successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        QHWithdrawDetailsViewController *detailsVC = [[QHWithdrawDetailsViewController alloc] init];
        QHDrawOrderModel *model = [QHDrawOrderModel modelWithJSON:responseObject[@"data"]];
        model.bankAccount = self.model;
        detailsVC.orderModel = model;
        [self.navigationController pushViewController:detailsVC animated:YES];
    } failueBlock:nil];
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
