//
//  QHOpenAIViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/7.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHOpenAIViewController.h"
#import "QHRobotAIModel.h"

@interface QHOpenAIViewController ()<UITextFieldDelegate>

@end

@implementation QHOpenAIViewController {
    UITextField *_name;
    UIButton *_authBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = QHLocalizedString(@"开通AI", nil);
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UILabel *priceTitleLabel = [UILabel labelWithColor:UIColorFromRGB(0x52627c)];
    [self.view addSubview:priceTitleLabel];
    priceTitleLabel.text = QHLocalizedString(@"开通价格", nil);
    
    UILabel *priceLabel = [UILabel labelWithFont:28 color:UIColorFromRGB(0x52627c)];
    [self.view addSubview:priceLabel];
    NSString *priceStr = [NSString stringWithFormat:@"$ %.2f",2000.0];
    NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [atrStr addAttribute:NSForegroundColorAttributeName value:MainColor range:[priceStr rangeOfString:@"$"]];
    priceLabel.attributedText = atrStr;
    
    UILabel *descriptionLabel = [UILabel detailLabel];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = QHLocalizedString(@"开通后您可以获得小辣椒AI功能,您可以使用小辣椒对您的社交账户进行托管,另有更多功能您可以在开通小来叫AI后到商店中了解", nil);
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:descriptionLabel];
    
    UIView *topLine = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:self.view :CGRectZero];
    
    UILabel *nameLabel = [UILabel labelWithColor:UIColorFromRGB(0x52627c)];
    [self.view addSubview:nameLabel];
    nameLabel.text = QHLocalizedString(@"推荐人用户名", nil);
    
    _name = [[UITextField alloc] init];
    _name.font = FONT(15);
    _name.placeholder = QHLocalizedString(@"请输入推荐人用户名", nil);
    [self.view addSubview:_name];
    _name.delegate = self;
    _name.returnKeyType = UIReturnKeyDone;
    
    __weak typeof(_name)weakName = _name;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakName resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
    
    UIButton *openServiceBtn = [[UIButton alloc] init];
    [openServiceBtn setTitle:QHLocalizedString(@"立即开通", nil) forState:(UIControlStateNormal)];
    openServiceBtn.layer.cornerRadius = 3.0f;
    openServiceBtn.titleLabel.font = FONT(16);
    openServiceBtn.backgroundColor = MainColor;
    [self.view addSubview:openServiceBtn];
    [openServiceBtn addTarget:self action:@selector(openAI) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *contactBtn = [[UIButton alloc] init];
    contactBtn.backgroundColor = WhiteColor;
    [contactBtn setImage:IMAGENAMED(@"AI_contact") forState:(UIControlStateNormal)];
    [self.view addSubview:contactBtn];
    [contactBtn addTarget:self action:@selector(chooseContact:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _authBtn = [[UIButton alloc] init];
    [_authBtn setImage:IMAGENAMED(@"AI_check") forState:(UIControlStateNormal)];
    [_authBtn setImage:IMAGENAMED(@"AI_uncheck") forState:(UIControlStateSelected)];
    [_authBtn setTitle:QHLocalizedString(@"到期后自动续费", nil) forState:(UIControlStateNormal)];
    [_authBtn setTitleColor:RGB939EAE forState:(UIControlStateNormal)];
    [self.view addSubview:_authBtn];
    _authBtn.titleLabel.font = FONT(14);
    [_authBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_authBtn addTarget:self action:@selector(renewal:) forControlEvents:(UIControlEventTouchUpInside)];
    _authBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [priceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceTitleLabel.mas_bottom).mas_offset(15);
        make.centerX.equalTo(self.view);
    }];
    
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom).mas_offset(39);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.centerX.equalTo(self.view);
    }];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(descriptionLabel.mas_bottom).mas_offset(50);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topLine.mas_bottom).mas_offset(35);
        make.left.equalTo(self.view).mas_offset(15);
    }];
    
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(68);
        make.right.equalTo(self.view);
        make.centerY.equalTo(nameLabel);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(topLine.mas_bottom).mas_offset(70);
    }];
    
    [_authBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine).mas_offset(16);
        make.left.equalTo(self.view).mas_offset(15);
        make.width.mas_equalTo(200);
    }];
    
    [openServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authBtn.mas_bottom).mas_offset(80);
        make.left.equalTo(self.view).mas_offset(15);
        make.right.equalTo(self.view).mas_offset(-15);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)renewal: (UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)chooseContact: (UIButton *)sender {
    NSLog(@"haha");
}

- (void)openAI {
    WeakSelf
    [QHRobotAIModel openAiWithRef:_name.text isauth:_authBtn.isSelected ? Auth_No : Auth_Yes successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf showHUDOnlyTitle:QHLocalizedString(@"开通成功", nil)];
        PerformOnMainThreadDelay(1.5, [weakSelf.navigationController popViewControllerAnimated:YES];);
        [QHPersonalInfo sharedInstance].userInfo.isOpenAi = @"2";
    } failureBlock:nil];
}

- (void)keyboardWillShow:(NSDictionary *)keyboardFrameInfo {
    CGFloat duration = [keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboarFrame = [keyboardFrameInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat distance = _name.mj_y+_name.height+90-keyboarFrame.origin.y;
    if (distance > 0) {
        CGRect frame = self.view.frame;
        frame.origin.y -= distance;
        self.view.frame = frame;
        [UIView animateWithDuration:duration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSDictionary *)keyboardFrameInfo {
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    self.view.frame = frame;
    CGFloat duration = [keyboardFrameInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
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
