//
//  QHAddAccountViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHWalletAddAccountViewController.h"
#import "QHGetCodeButton.h"
#import "QHLoginModel.h"
#import "QHWalletAccountViewController.h"

#define BASE_TAG 666

@interface QHWalletAddAccountViewController ()<UITextFieldDelegate>

@end

@implementation QHWalletAddAccountViewController {
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    UITextField *_firstTF;
    UITextField *_secondTF;
    UIButton *_completeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"添加交易账户", nil);
    
    [self setupUI];
    if (self.step == Step_One) {
        [self configStepOne];
    } else {
        [self configStepTwo];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)resignResponder {
    [_firstTF resignFirstResponder];
    [_secondTF resignFirstResponder];
}

- (void)setupUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder)];
    [self.view addGestureRecognizer:tap];
    
    _firstLabel = [UILabel labelWithFont:15 color:RGB4A5970];
    [self.view addSubview:_firstLabel];
    _firstLabel.text = QHLocalizedString(@"持卡人姓名", nil);
    
    _secondLabel = [UILabel labelWithFont:15 color:RGB4A5970];
    [self.view addSubview:_secondLabel];
    _secondLabel.text = QHLocalizedString(@"银行卡卡号", nil);
    
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 60, SCREEN_WIDTH-30, 1)];
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 120, SCREEN_WIDTH-30, 1)];
    
    _firstTF = [[UITextField alloc] init];
    _firstTF.font = FONT(15);
    _firstTF.tag = BASE_TAG;
    _firstTF.delegate = self;
    _firstTF.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:_firstTF];
    
    _secondTF = [[UITextField alloc] init];
    _secondTF.font = FONT(15);
    _secondTF.tag = BASE_TAG+1;
    _secondTF.delegate = self;
    _secondTF.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_secondTF];
    
    _completeBtn = [[UIButton alloc] init];
    [_completeBtn setBackgroundImage:[UIImage imageWithColor:RGBFF697A] forState:(UIControlStateNormal)];
    [_completeBtn setBackgroundImage:[UIImage imageWithColor:RGBF5F6FA] forState:(UIControlStateDisabled)];
    [_completeBtn setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [_completeBtn setTitleColor:RGBC8C9CC forState:(UIControlStateDisabled)];
    [_completeBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _completeBtn.enabled = NO;
    _completeBtn.layer.cornerRadius = 3;
    [self.view addSubview:_completeBtn];
    
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(30);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top).mas_offset(90);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [_firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_firstLabel);
        make.left.equalTo(self.view).mas_offset(120);
    }];
    [_secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_secondLabel);
        make.left.equalTo(self.view).mas_offset(120);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(240);
        make.left.equalTo(self.view).mas_offset(15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
    }];
}

- (void)configStepOne {
    _firstLabel.text = QHLocalizedString(@"持卡人姓名", nil);
    _secondLabel.text = QHLocalizedString(@"银行卡卡号", nil);
    _firstTF.placeholder = QHLocalizedString(@"请输入持卡人姓名", nil);
    _secondTF.placeholder = QHLocalizedString(@"请输入银行卡号", nil);
    [_completeBtn setTitle:QHLocalizedString(@"下一步", nil) forState:(UIControlStateNormal)];
    
    self.bankModel = [[QHBankModel alloc] init];
}

- (void)configStepTwo {
    _firstLabel.text = QHLocalizedString(@"绑定手机", nil);
    _secondLabel.text = QHLocalizedString(@"验证码", nil);
    _firstTF.placeholder = QHLocalizedString(@"请输入手机号码", nil);
    _secondTF.placeholder = QHLocalizedString(@"请输入验证码", nil);
    QHGetCodeButton *getCodeBtn = [[QHGetCodeButton alloc] init];
    _secondTF.rightView = getCodeBtn;
    _secondTF.rightViewMode = UITextFieldViewModeAlways;
    
    WeakSelf
    getCodeBtn.action = ^BOOL{
        return [weakSelf getCode];
    };
    [_completeBtn setTitle:QHLocalizedString(@"确定", nil) forState:(UIControlStateNormal)];
}

- (BOOL)getCode {
    WeakSelf
    [QHLoginModel sendSmsCodeWithCodeJson:[@{@"type" : @"code"} mj_JSONString] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"验证码已发送", nil)];
    } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
    }];
    return YES;
}

- (void)textFieldChanged {
    if (_firstTF.text.length > 0 && _secondTF.text.length > 0) {
        _completeBtn.enabled = YES;
    } else {
        _completeBtn.enabled = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == BASE_TAG) {
        [textField resignFirstResponder];
        return [_secondTF becomeFirstResponder];
    } else {
        return [textField resignFirstResponder];
    }
}

- (void)btnClick: (UIButton *)sender {
    [_firstTF resignFirstResponder];
    [_secondTF resignFirstResponder];
    
    if (self.step == Step_One) {
        self.bankModel.realName = _firstTF.text;
        self.bankModel.accountNumber = _secondTF.text;
        [QHBankModel bankNameByNumber:_secondTF.text successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            self.bankModel.accountType = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankType"]];
            self.bankModel.bankName = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankName"]];
            QHWalletAddAccountViewController *stepTwoVC = [[QHWalletAddAccountViewController alloc] init];
            stepTwoVC.bankModel = self.bankModel;
            stepTwoVC.step = Step_Two;
            [self.navigationController pushViewController:stepTwoVC animated:YES];
        } failureBlock:nil];
    } else {
        self.bankModel.phoneNumber = _firstTF.text;
        self.bankModel.verifySmsCode = _secondTF.text;
        self.bankModel.phoneCode = [QHPersonalInfo sharedInstance].userInfo.phoheCode;
        [QHBankModel addBankAccountWithPhoneNumber:self.bankModel.phoneNumber phoneCode:self.bankModel.phoneCode verifySmsCode:self.bankModel.verifySmsCode accountNumber:self.bankModel.accountNumber bankName:self.bankModel.bankName realName:self.bankModel.realName accountType:self.bankModel.accountType currency:@"CNY" successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            for (QHBaseViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[QHWalletAccountViewController class]]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:ADDCARD_NOTI object:nil];
                    [self.navigationController popToViewController:vc animated:YES];
                    return ;
                }
            }
        } failure:nil];
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
