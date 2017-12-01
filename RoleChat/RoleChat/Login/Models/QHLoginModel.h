//
//  QHLoginModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/26.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

typedef NS_ENUM(NSInteger, LoginType) {
    LoginType_Normal = 1,
    LoginType_Weixin,
    LoginType_QQ,
    LoginType_Facebook
};

@interface QHLoginModel : QHBaseModel

// 发送验证码
+ (void)sendSmsCodeWithCodeJson: (NSString *)json successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 注册
+ (void)registerWithUserJson: (NSString *)json successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 第三方登录
+ (void)authorityWithCode: (NSString *)code type: (LoginType)type successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)authorityWithOpenid: (NSString *)openid accesstoken: (NSString *)accesstoken type: (LoginType)type successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 登录
+ (void)apploginWithUsername: (NSString *)username password: (NSString *)password token: (NSString *)token successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 获取用户信息
+ (void)getUserBalanceWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

// 绑定手机号
+ (void)bandPhoneWithPhone: (NSString *)phone phoneCode: (NSString *)phoneCode tradePwd: (NSString *)tradePwd verifyCode: (NSString *)verifyCode successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
