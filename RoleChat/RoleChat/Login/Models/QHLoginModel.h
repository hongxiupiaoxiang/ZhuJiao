//
//  QHLoginModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/26.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHLoginModel : QHBaseModel

// 发送验证码
+ (void)sendSmsCodeWithCodeJson: (NSString *)json successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 注册
+ (void)registerWithUserJson: (NSString *)json successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 登录
+ (void)apploginWithUsername: (NSString *)username password: (NSString *)password token: (NSString *)token successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 获取用户信息
+ (void)getUserBalanceWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

// 绑定手机号
+ (void)bandPhoneWithPhone: (NSString *)phone phoneCode: (NSString *)phoneCode verifyCode: (NSString *)verifyCode successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
