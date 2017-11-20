//
//  QHPaymentVerificationViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/19.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPaymentVerificationViewController.h"
#import "QHGetCodeButton.h"
#import "QHLoginModel.h"

@interface QHPaymentVerificationViewController ()

@end

@implementation QHPaymentVerificationViewController {
    UILabel *_tipLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"支付验证", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    _tipLabel = [UILabel defalutLabel];
    _tipLabel.text = QHLocalizedString(@"短信验证码已发送,请确认", nil);
    [self.view addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(40);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.font = FONT(15);
    [self.view addSubview:tf];
    tf.placeholder = QHLocalizedString(@"请输入验证码", nil);
    WeakSelf
    QHGetCodeButton *codeBtn = [[QHGetCodeButton alloc] initWithTimeInterval:60 withAction:^BOOL{
        [QHLoginModel sendSmsCodeWithCodeJson:[@{@"type" : @"code"} mj_JSONString] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf showHUDOnlyTitle:QHLocalizedString(@"验证码已发送", nil)];
        } failureBlock:^(NSURLSessionDataTask *task, id responseObject) {
            [[QHTools toolsDefault] showFailureMsgWithResponseObject:responseObject];
        }];
        return YES;
    }];
    tf.rightView = codeBtn;
    tf.rightViewMode = UITextFieldViewModeAlways;
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(self.view).mas_offset(10);
    }];
    
    [[QHTools toolsDefault] addLineView:self.view :CGRectMake(15, 117, SCREEN_WIDTH-30, 1)];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 217, SCREEN_WIDTH-30, 50)];
    sureBtn.layer.cornerRadius = 3;
    [sureBtn setTitle:QHLocalizedString(@"确定", nil) forState:(UIControlStateNormal)];
    sureBtn.backgroundColor = MainColor;
    [self.view addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)btnClick {
    
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
