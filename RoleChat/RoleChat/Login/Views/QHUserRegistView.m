//
//  QHUserRegistView.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/7.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHUserRegistView.h"
#import "QHSeePassButton.h"

#define AttributedPlaceHolder(string) [[NSAttributedString alloc] initWithString:QHLocalizedString(string, nil) attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xC8C9CC)}]
#define kBaseTag 1111
@interface QHUserRegistView () <UITextFieldDelegate> {
    NSString* _internalPhoneCode;
}

@end

@implementation QHUserRegistView
@synthesize phoneCode;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        self.enableBackgroundTap = YES;
    }
    return self;
}

-(void)initUI {
    _userNameTextField = [[UITextField alloc] init];
    _userNameTextField.font = FONT(15.0f);
    _userNameTextField.tag = kBaseTag + 1;
    _userNameTextField.delegate = self;
    _userNameTextField.attributedPlaceholder = AttributedPlaceHolder(@"用户名");
    _userNameTextField.keyboardType = UIKeyboardTypeAlphabet;
    _userNameTextField.returnKeyType = UIReturnKeyNext;
    [self addSubview:_userNameTextField];
    [_userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(25.0f);
        make.leading.mas_equalTo(self).mas_offset(15.0f);
        make.trailing.mas_equalTo(self).mas_offset(-15.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    UIView* userNameTextFieldSep = [[UIView alloc] init];
    userNameTextFieldSep.backgroundColor = UIColorFromRGB(0xE1E2E6);
    [self addSubview:userNameTextFieldSep];
    [userNameTextFieldSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameTextField.mas_bottom);
        make.leading.mas_equalTo(self).offset(15.0f);
        make.trailing.mas_equalTo(self).offset(-15.0f);
        make.height.mas_equalTo(1.0f / SCREEN_SCALE);
    }];
    
    _userPassTextField = (UITextField*)CopyView(_userNameTextField);
    _userPassTextField.attributedPlaceholder = AttributedPlaceHolder(@"登录密码");
    _userPassTextField.secureTextEntry = YES;
    _userPassTextField.rightViewMode = UITextFieldViewModeAlways;
    _userPassTextField.returnKeyType = UIReturnKeyNext;
    _userPassTextField.tag = kBaseTag + 2;
    _userPassTextField.delegate = self;
    [self addSubview:_userPassTextField];
    [_userPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNameTextFieldSep.mas_bottom).mas_offset(20.0f);
        make.leading.and.trailing.mas_equalTo(_userNameTextField);
        make.height.mas_equalTo(_userNameTextField);
    }];
    
    UIView* userPassTextFieldSep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:userPassTextFieldSep];
    [userPassTextFieldSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userPassTextField.mas_bottom);
        make.leading.and.trailing.mas_equalTo(userNameTextFieldSep);
        make.height.mas_equalTo(userNameTextFieldSep);
    }];
    
    _userPassConfirmTextField = (UITextField*)CopyView(_userPassTextField);
    _userPassConfirmTextField.attributedPlaceholder = AttributedPlaceHolder(@"确认登录密码");
    _userPassConfirmTextField.rightView = [QHSeePassButton newInstanceWithAccessoryTextField:_userPassConfirmTextField];
    _userPassConfirmTextField.delegate = self;
    _userPassConfirmTextField.tag = kBaseTag + 3;
    _userPassConfirmTextField.returnKeyType = UIReturnKeyNext;
    _userPassConfirmTextField.rightViewMode = UITextFieldViewModeAlways;
    [self addSubview:_userPassConfirmTextField];
    [_userPassConfirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPassTextFieldSep.mas_bottom).mas_offset(20.0f);
        make.leading.and.trailing.mas_equalTo(_userPassTextField);
        make.height.mas_equalTo(_userPassTextField);
    }];
    
    UIView* userPassConfirmTextFieldSep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:userPassConfirmTextFieldSep];
    [userPassConfirmTextFieldSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userPassConfirmTextField.mas_bottom);
        make.leading.and.trailing.mas_equalTo(userNameTextFieldSep);
        make.height.mas_equalTo(userNameTextFieldSep);
    }];
    
    _userPayPassTextField = (UITextField*)CopyView(_userPassConfirmTextField);
    _userPayPassTextField.attributedPlaceholder = AttributedPlaceHolder(@"支付密码");
//    _userPayPassTextField.rightView = [QHSeePassButton newInstanceWithAccessoryTextField:_userPayPassTextField];
//    _userPayPassTextField.rightViewMode = UITextFieldViewModeAlways;
    _userPayPassTextField.returnKeyType = UIReturnKeyNext;
    _userPayPassTextField.tag = kBaseTag + 4;
    _userPayPassTextField.delegate = self;
    [self addSubview:_userPayPassTextField];
    [_userPayPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPassConfirmTextFieldSep).mas_offset(20.0f);
        make.leading.and.trailing.mas_equalTo(_userPassConfirmTextField);
        make.height.mas_equalTo(_userPassConfirmTextField);
    }];
    
    UIView* userPayPassTextFieldSep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:userPayPassTextFieldSep];
    [userPayPassTextFieldSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userPayPassTextField.mas_bottom);
        make.leading.and.trailing.mas_equalTo(userNameTextFieldSep);
        make.height.mas_equalTo(userNameTextFieldSep);
    }];
    
    _userPayConfirmTextField = (UITextField*)CopyView(_userPayPassTextField);
    _userPayConfirmTextField.attributedPlaceholder = AttributedPlaceHolder(@"确认支付密码");
    _userPayConfirmTextField.rightView = [QHSeePassButton newInstanceWithAccessoryTextField:_userPayConfirmTextField];
    _userPayConfirmTextField.rightViewMode = UITextFieldViewModeAlways;
    _userPayConfirmTextField.returnKeyType = UIReturnKeyNext;
    _userPayConfirmTextField.tag = kBaseTag + 5;
    _userPayConfirmTextField.delegate = self;
    [self addSubview:_userPayConfirmTextField];
    [_userPayConfirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPayPassTextFieldSep.mas_bottom).mas_offset(20.0f);
        make.leading.and.trailing.mas_equalTo(_userPassConfirmTextField);
        make.height.mas_equalTo(_userNameTextField.mas_height);
    }];
    
    UIView* userPayConfirmTextFieldSep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:userPayConfirmTextFieldSep];
    [userPayConfirmTextFieldSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userPayConfirmTextField.mas_bottom);
        make.leading.and.trailing.mas_equalTo(userNameTextFieldSep);
        make.height.mas_equalTo(userNameTextFieldSep);
    }];
    
    _userZoneNoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userZoneNoBtn.titleLabel.font = FONT(15.0f);
    [_userZoneNoBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_userZoneNoBtn setTitle:QHLocalizedString(@"+86", nil) forState:UIControlStateNormal];
    [_userZoneNoBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self addSubview:_userZoneNoBtn];
    [_userZoneNoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPayConfirmTextFieldSep.mas_bottom).mas_offset(20.0f);
        make.leading.mas_equalTo(self).mas_offset(15.0f);
        make.width.mas_equalTo(50.0f);
        make.height.mas_equalTo(_userNameTextField.mas_height);
    }];
    
    UIView* userZoneSep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:userZoneSep];
    [userZoneSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userZoneNoBtn.mas_bottom);
        make.leading.mas_equalTo(userNameTextFieldSep);
        make.height.mas_equalTo(userNameTextFieldSep);
        make.width.mas_equalTo(_userZoneNoBtn.mas_width);
    }];
    
    _userTelNoTextField = (UITextField*)CopyView(_userNameTextField);
    _userTelNoTextField.attributedPlaceholder = AttributedPlaceHolder(@"手机号码");
    _userTelNoTextField.returnKeyType = UIReturnKeyNext;
    _userTelNoTextField.tag = kBaseTag + 6;
    _userTelNoTextField.delegate = self;
    _userTelNoTextField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_userTelNoTextField];
    [_userTelNoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userZoneNoBtn.mas_top);
        make.leading.mas_equalTo(_userZoneNoBtn.mas_trailing).mas_offset(15.0f);
        make.trailing.mas_equalTo(self).mas_offset(-15.0f);
        make.height.mas_equalTo(_userNameTextField.mas_height);
    }];
    
    UIView* userTelSep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:userTelSep];
    [userTelSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userTelNoTextField.mas_bottom);
        make.leading.mas_equalTo(_userTelNoTextField.mas_leading);
        make.trailing.mas_equalTo(self).mas_offset(-15.0f);
        make.height.mas_equalTo(userNameTextFieldSep);
    }];
    
    _verifyCodeTextField = (UITextField*)CopyView(_userTelNoTextField);
    _verifyCodeTextField.returnKeyType = UIReturnKeyDone;
    _verifyCodeTextField.attributedPlaceholder = AttributedPlaceHolder(@"验证码");
    _verifyCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    _verifyCodeTextField.tag = kBaseTag + 7;
    _verifyCodeTextField.delegate = self;
    _verifyCodeTextField.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:_verifyCodeTextField];
    [_verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userTelSep.mas_bottom).mas_offset(20.0f);
        make.leading.and.trailing.mas_equalTo(_userNameTextField);
        make.height.mas_equalTo(_userNameTextField.mas_height);
    }];
    
    _getCodeBtn = [[QHGetCodeButton alloc] init];
    _verifyCodeTextField.rightView = _getCodeBtn;
    
    UIView* verifySep = (UIView*)CopyView(userNameTextFieldSep);
    [self addSubview:verifySep];
    [verifySep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_verifyCodeTextField.mas_bottom);
        make.leading.and.trailing.mas_equalTo(_verifyCodeTextField);
        make.height.mas_equalTo(userNameTextFieldSep);
    }];
    
    _userRegistConfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userRegistConfirmBtn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
    [_userRegistConfirmBtn setBackgroundImage:[UIImage imageWithColor:RGB646466] forState:UIControlStateHighlighted];
    [_userRegistConfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _userRegistConfirmBtn.layer.cornerRadius = 2.0f;
    _userRegistConfirmBtn.layer.borderColor = UIColorFromRGB(0x008de7).CGColor;
    _userRegistConfirmBtn.layer.borderWidth = 1.0f;
    _userRegistConfirmBtn.clipsToBounds = YES;
    _userRegistConfirmBtn.titleLabel.layer.shadowColor = UIColorFromRGB(0x006db3).CGColor;
    _userRegistConfirmBtn.titleLabel.layer.shadowRadius = 1.0f;
    [_userRegistConfirmBtn setTitle:QHLocalizedString(@"确认注册", nil) forState:UIControlStateNormal];
    [self addSubview:_userRegistConfirmBtn];
    [_userRegistConfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-15.0f);
        make.leading.and.trailing.mas_equalTo(_userNameTextField);
        make.height.mas_equalTo(50.0f);
    }];
    
    return ;
}

-(USER_REGIST_ERROR)checkValid {
    NSArray* controls = @[_userNameTextField, _userPassTextField,
                          _userPayPassTextField, _userTelNoTextField,
                          _userPayConfirmTextField, _userPassConfirmTextField,
                          ];
    
    for (UIView* view in controls) {
        borderForView(view, [UIColor clearColor]);
    }
    
    if(_userNameTextField.text.length == 0) {
        borderForView(_userNameTextField, MainColor);
        return USER_REGIST_ERROR_USERNAME_EMPTY;
    }
    
    if([kUserNameFormatPattern matchesInString:_userNameTextField.text options:0 range:NSMakeRange(0, _userNameTextField.text.length)].count == 0) {
        borderForView(_userNameTextField, MainColor);
        return USER_REGIST_ERROR_USERNAME_INVALID;
    }
    
    if(_userPassTextField.text.length == 0) {
        borderForView(_userPassTextField, MainColor);
        return USER_REGIST_ERROR_PASSWORD_EMPTY;
    }
    
    if([_userPassTextField.text isEqualToString:_userPassConfirmTextField.text] == NO) {
        borderForView(_userPassTextField, MainColor);
        borderForView(_userPassConfirmTextField, MainColor);
        return USER_REGIST_ERROR_PASSWORD_DIFFER;
    }
    
    if(_userPassTextField.text.length < kMinimumPasswordLength || _userPassTextField.text.length > kMaximumPasswordLength) {
        borderForView(_userPassTextField, MainColor);
        return USER_REGIST_ERROR_PASSWORD_INVALID;
    }
    
    if([kPasswordFormatPattern matchesInString:_userPassTextField.text options:0 range:NSMakeRange(0, _userPassTextField.text.length)].count == 0) {
        borderForView(_userPassTextField, MainColor);
        return USER_REGIST_ERROR_PASSWORD_INVALID;
    }
    
    if(_userPayPassTextField.text.length == 0) {
        borderForView(_userPayPassTextField, MainColor);
        return USER_REGIST_ERROR_PAY_PASSWORD_EMPTY;
    }
    
    if(_userPayConfirmTextField.text.length == 0) {
        borderForView(_userPayConfirmTextField, MainColor);
        return USER_REGIST_ERROR_PAY_PASSWORD_EMPTY;
    }
    
    if([_userPayConfirmTextField.text isEqualToString:_userPayPassTextField.text] == 0) {
        borderForView(_userPayPassTextField, MainColor);
        borderForView(_userPayConfirmTextField, MainColor);
        return USER_REGIST_ERROR_PASSWORD_DIFFER;
    }
    
    if([_userPayPassTextField.text isEqualToString:_userPassTextField.text]) {
        borderForView(_userPayPassTextField, MainColor);
        return USER_REGIST_ERROR_PAYPASS_SAME_WITH_LOGINPASS;
    }
    
    if(_userPayPassTextField.text.length < kMinimumPasswordLength || _userPayPassTextField.text.length > kMaximumPasswordLength) {
        borderForView(_userPayPassTextField, MainColor);
        return USER_REGIST_ERROR_PASSWORD_INVALID;
    }
    
    if([kPasswordFormatPattern matchesInString:_userPayPassTextField.text options:0 range:NSMakeRange(0, _userPayPassTextField.text.length)].count == 0) {
        borderForView(_userPayPassTextField, MainColor);
        return USER_REGIST_ERROR_PAY_PASSWORD_INVALID;
    }
    
    if(_userTelNoTextField.text.length == 0) {
        borderForView(_userTelNoTextField, MainColor);
        return USER_REGIST_ERROR_PHONENUMBER_EMPTY;
    }
    
//    if([kPhoneNumberFormatPattern matchesInString:_userTelNoTextField.text options:0 range:NSMakeRange(0, _userTelNoTextField.text.length)].count == 0) {
//        borderForView(_userTelNoTextField, MainColor);
//        return USER_REGIST_ERROR_PHONENUMBER_INVALID;
//    }
    
    if(_verifyCodeTextField.text.length == 0) {
        borderForView(_verifyCodeTextField, MainColor);
        return USER_REGIST_ERROR_VERIFYCODE_EMPTY;
    }
    
    return USER_REGIST_ERROR_NONE;
}

-(BOOL)resignFirstResponder {
    if(_userNameTextField.isFirstResponder)
        [_userNameTextField resignFirstResponder];
    if(_userPassTextField.isFirstResponder)
        [_userPassTextField resignFirstResponder];
    if(_userPassConfirmTextField.isFirstResponder)
        [_userPassConfirmTextField resignFirstResponder];
    if(_userPayPassTextField.isFirstResponder)
        [_userPayPassTextField resignFirstResponder];
    if(_userPayConfirmTextField.isFirstResponder)
        [_userPayConfirmTextField resignFirstResponder];
    if(_userTelNoTextField.isFirstResponder)
        [_userTelNoTextField resignFirstResponder];
    if(_verifyCodeTextField.isFirstResponder)
        [_verifyCodeTextField resignFirstResponder];
    
    return [super resignFirstResponder];
}

-(NSDictionary *)getRequestParams {
    NSMutableDictionary* requestParams =  [@{
                                             @"phoneCode" : self.phoneCode,
                                             @"phoneNumber" : _userTelNoTextField.text,
                                             @"username" : _userNameTextField.text,
                                             @"password" : _userPassTextField.text,
                                             @"confirmPwd" : _userPassConfirmTextField.text,
                                             @"pay_pwd" : _userPayPassTextField.text,
                                             @"confirmPayPwd" : _userPayConfirmTextField.text,
                                             } mutableCopy];
    
    if(_verifyCodeTextField.text.length != 0)
        [requestParams setValue:_verifyCodeTextField.text forKey:@"verifyCode"];
    
    return requestParams;
}

-(NSString *)phoneCode {
    return [[_userZoneNoBtn titleForState:UIControlStateNormal] substringFromIndex:1];
}

-(void)setPhoneCode:(NSString *)code {
    _internalPhoneCode = code;
    [_userZoneNoBtn setTitle:[NSString stringWithFormat:@"+%@", code] forState:UIControlStateNormal];
    return ;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(textField.returnKeyType == UIReturnKeyNext) {
        UITextField* nextTextField = (UITextField*)[self viewWithTag:textField.tag + 1];
        if(nextTextField) {
            [nextTextField becomeFirstResponder];
        }
    }
    return NO;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if([textField isEqual:_userNameTextField]) {
        if(_userNameCheckBlock != nil)
            _userNameCheckBlock();
    }
    return YES;
}

@end
