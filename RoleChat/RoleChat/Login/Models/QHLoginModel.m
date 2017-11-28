//
//  QHLoginModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/26.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHLoginModel.h"

@implementation QHLoginModel

// 发送验证码
+ (void)sendSmsCodeWithCodeJson: (NSString *)json successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHLoginModel sendPOSTRequestNoHudWithAPI:@"user/sendSmsCode" baseURL:nil params:@{@"json" : json} beforeRequest:nil successBlock:success failedBlock:failure];
}

// 注册
+ (void)registerWithUserJson: (NSString *)json successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHLoginModel sendRequestWithAPI:@"user/register" baseURL:nil params:@{@"json" : json} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 登录
+ (void)apploginWithUsername: (NSString *)username password: (NSString *)password token: (NSString *)token successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHLoginModel sendRequestWithAPI:@"user/applogin" baseURL:nil params:@{@"username" : username, @"password" : password, @"token" : token} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 第三方授权登录
+ (void)authorityWithCode: (NSString *)code type: (LoginType)type successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHLoginModel sendRequestWithAPI:@"user/authority" baseURL:nil params:@{@"deviceType" : @"1", @"code" : code, @"type" : @(type)} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}


// 获取用户信息
+ (void)getUserBalanceWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHLoginModel sendRequestWithAPI:@"user/balance" baseURL:nil params:NULL hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 绑定手机号
+ (void)bandPhoneWithPhone: (NSString *)phone phoneCode: (NSString *)phoneCode tradePwd: (NSString *)tradePwd verifyCode: (NSString *)verifyCode successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHLoginModel sendRequestWithAPI:@"security/bandPhone" baseURL:nil params:@{@"phone" : phone, @"phoneCode" : phoneCode, @"verifyCode" : verifyCode, @"tradePwd" : tradePwd} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
