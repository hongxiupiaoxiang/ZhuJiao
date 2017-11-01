//
//  QHUserRegistView.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/7.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseView.h"
#import "QHGetCodeButton.h"
#import "QHError.h"

@interface QHUserRegistView : QHBaseView

@property(nonatomic, strong) UITextField* userNameTextField;
@property(nonatomic, strong) UITextField* userPassTextField;
@property(nonatomic, strong) UITextField* userPassConfirmTextField;
@property(nonatomic, strong) UITextField* userPayPassTextField;
@property(nonatomic, strong) UITextField* userPayConfirmTextField;
@property(nonatomic, strong) UIButton* userZoneNoBtn;
@property(nonatomic, strong) UITextField* userTelNoTextField;
@property(nonatomic, strong) UITextField* verifyCodeTextField;
@property(nonatomic, strong) UIButton* userRegistConfirmBtn;
@property(nonatomic, strong) QHGetCodeButton* getCodeBtn;
@property(nonatomic, copy) QHNoParamCallback userNameCheckBlock;
@property(nonatomic, copy) NSString* phoneCode;

-(USER_REGIST_ERROR)checkValid;
-(NSDictionary*)getRequestParams;

@end
