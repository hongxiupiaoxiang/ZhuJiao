//
//  QHLoginView.m
//  GoldWorld
//
//  Created by zfQiu on 2017/3/7.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHLocalizable.h"
#import "Masonry.h"
#import "UIImage+YYAdd.h"
#import "QHLoginView.h"

@interface QHLoginView () <UITextFieldDelegate>

@end

@implementation QHLoginView {
    UIView *_usernameSep;
    UIView *_passwordSep;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        self.enableBackgroundTap = YES;
    }
    return self;
}

-(void)backgroundTapped {
    [_userNameTextField resignFirstResponder];
    [_userPassTextField resignFirstResponder];
    return ;
}

-(void)setupUI {
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.image = IMAGENAMED(@"Pepper");
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(70);
        make.left.equalTo(self).mas_offset(15);
        make.width.mas_equalTo(163);
        make.height.mas_equalTo(62);
    }];
    
    UIImageView *circleView = [[UIImageView alloc] init];
    circleView.image = IMAGENAMED(@"Login circle");
    [self addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(116);
    }];
    
    _switchLanguageBtn = [[UIButton alloc] init];
    [_switchLanguageBtn setTitle:@"Language" forState:(UIControlStateNormal)];
    _switchLanguageBtn.titleLabel.font = FONT(15);
    [_switchLanguageBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [self addSubview:_switchLanguageBtn];
    [_switchLanguageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(35);
        make.right.equalTo(self).mas_offset(-15);
    }];
    
    _userNameTextField = [[UITextField alloc] init];
    _userNameTextField.font = FONT(15.0f);
    _userNameTextField.textColor = UIColorFromRGB(0x52672c);
    _userNameTextField.returnKeyType = UIReturnKeyNext;
    _userNameTextField.keyboardType = UIKeyboardTypeAlphabet;
    _userNameTextField.delegate = self;
    _userNameTextField.placeholder = QHLocalizedString(@"请输入账号", nil);
    [self addSubview:_userNameTextField];
    
    CGFloat usernameTfMargin = SCREEN_WIDTH <= 320 ? 160 : 202;
    
    [_userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(usernameTfMargin);
        make.leading.mas_equalTo(self).offset(15.0f);
        make.trailing.mas_equalTo(self).offset(-15.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    _usernameSep = [[UIView alloc] init];
    _usernameSep.backgroundColor = UIColorFromRGB(0xE1E2E6);
    [self addSubview:_usernameSep];
    
    [_usernameSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameTextField.mas_bottom);
        make.leading.mas_equalTo(self).offset(15.0f);
        make.trailing.mas_equalTo(self).offset(-15.0f);
        make.height.mas_equalTo(1.0f / SCREEN_SCALE);
    }];
    
    _userPassTextField = [[UITextField alloc] init];
    _userPassTextField.font = FONT(14.0f);
    _userPassTextField.textColor = _userNameTextField.textColor;
    _userPassTextField.secureTextEntry = YES;
    _userPassTextField.delegate = self;
    _userPassTextField.placeholder = QHLocalizedString(@"请输入密码", nil);
    _userPassTextField.rightViewMode = UITextFieldViewModeAlways;
    _userPassTextField.returnKeyType = UIReturnKeyDone;
    [self addSubview:_userPassTextField];
    [_userPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_usernameSep).offset(30.0f);
        make.leading.mas_equalTo(self).offset(15.0f);
        make.trailing.mas_equalTo(self).offset(-15.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    _passwordSep = (UIView*)CopyView(_usernameSep);
    [self addSubview:_passwordSep];
    [_passwordSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userPassTextField.mas_bottom);
        make.leading.mas_equalTo(self).offset(15.0f);
        make.trailing.mas_equalTo(self).offset(-15.0f);
        make.height.mas_equalTo(1.0f / SCREEN_SCALE);
    }];
    
    _forgotPasswordBtn = [[UIButton alloc] init];
    [_forgotPasswordBtn setTitle:QHLocalizedString(@"找回密码", nil) forState:(UIControlStateNormal)];
    _forgotPasswordBtn.titleLabel.font = FONT(15);
    [_forgotPasswordBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    [self addSubview:_forgotPasswordBtn];
    [_forgotPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userPassTextField.mas_bottom).mas_offset(15);
        make.right.equalTo(self).mas_offset(-15);
    }];
    
    _confirmBtn = [[UIButton alloc] init];
    [_confirmBtn setTitle:QHLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:MainColor];
    _confirmBtn.titleLabel.font = FONT(16.0f);
    _confirmBtn.layer.cornerRadius = 2.0f;
    _confirmBtn.layer.borderColor = UIColorFromRGB(0xff2727).CGColor;
    _confirmBtn.layer.borderWidth = 1.0f;
    _confirmBtn.clipsToBounds = YES;
    [self addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordSep.mas_bottom).mas_offset(60);
        make.left.equalTo(self).mas_offset(15);
        make.right.equalTo(self).mas_offset(-15);
        make.height.mas_equalTo(50);
    }];

    _registBtn = [[UIButton alloc] init];
    _registBtn.titleLabel.font = FONT(15.0f);
    [_registBtn setTitle:QHLocalizedString(@"注册账号", nil) forState:UIControlStateNormal];
    [_registBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self addSubview:_registBtn];
    
    CGFloat registBtnMargin = iPhone5sEarly ? 20 : 30;
    
    [_registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmBtn.mas_bottom).mas_offset(registBtnMargin);
        make.centerX.equalTo(_confirmBtn);
    }];
    
    UILabel *thirdLoginLabel = [[UILabel alloc] init];
    [thirdLoginLabel setText:QHLocalizedString(@"使用第三方登录", nil)];
    [thirdLoginLabel setTextColor:UIColorFromRGB(0xc5c6d1)];
    [thirdLoginLabel setFont:FONT(14)];
    [self addSubview:thirdLoginLabel];
    
    CGFloat thirdLoginLabelMargin = iPhone5sEarly ? 30 : 40;
    
    [thirdLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_registBtn.mas_bottom).mas_offset(thirdLoginLabelMargin);
        make.centerX.equalTo(_registBtn);
    }];
    
    _weixinBtn = [[UIButton alloc] init];
    [_weixinBtn setImage:IMAGENAMED(@"Wechat") forState:(UIControlStateNormal)];
    [self addSubview:_weixinBtn];
    
    CGFloat weixinBtnMargin = iPhone5sEarly ? 20 : 30;
    
    [_weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLoginLabel.mas_bottom).mas_offset(weixinBtnMargin);
        make.centerX.equalTo(thirdLoginLabel);
        make.width.height.mas_equalTo(44);
    }];
    
    _qqBtn = [[UIButton alloc] init];
    [_qqBtn setImage:IMAGENAMED(@"QQ") forState:(UIControlStateNormal)];
    [self addSubview:_qqBtn];
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_weixinBtn);
        make.right.equalTo(_weixinBtn.mas_left).mas_offset(-30);
        make.width.height.mas_equalTo(44);
    }];
    
    _facebookBtn = [[UIButton alloc] init];
    [_facebookBtn setImage:IMAGENAMED(@"facebook") forState:(UIControlStateNormal)];
    [self addSubview:_facebookBtn];
    [_facebookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_weixinBtn);
        make.left.equalTo(_weixinBtn.mas_right).mas_offset(30);
        make.width.height.mas_equalTo(44);
    }];
    
    [_userPassTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [_userNameTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if([textField isEqual:_userNameTextField])
        [_userPassTextField becomeFirstResponder];
    
    return NO;
}

- (void)addLayerWithLine: (UIView *)sepLine {
    CAGradientLayer *sepLayer = [CAGradientLayer layer];
    sepLayer.colors = @[(__bridge id)UIColorFromRGB(0xff4f95).CGColor, (__bridge id)UIColorFromRGB(0x18d0f0).CGColor];
    sepLayer.startPoint = CGPointMake(0, 0.5);
    sepLayer.endPoint = CGPointMake(1, 0.5);
    sepLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 1.0f / SCREEN_SCALE);
    [sepLine.layer addSublayer:sepLayer];
}

- (void)textFieldChange: (UITextField *)textField {
    if ([textField isEqual:_userNameTextField]) {
        if (_userNameTextField.text.length) {
            if (!_usernameSep.layer.sublayers.count) {
                [self addLayerWithLine:_usernameSep];
            }
        } else {
            [_usernameSep.layer removeAllSublayers];
        }
    } else {
        if (_userPassTextField.text.length) {
            if (!_passwordSep.layer.sublayers.count) {
                [self addLayerWithLine:_passwordSep];
            }
        } else {
            [_passwordSep.layer removeAllSublayers];
        }
    }
}

@end
