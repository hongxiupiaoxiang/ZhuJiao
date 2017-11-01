//
//  QHPasswordModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/27.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPasswordModel.h"

@implementation QHPasswordModel

+ (void)findpasswordWithUsername: (NSString *)username code: (NSString *)code password: (NSString *)password successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHPasswordModel sendRequestWithAPI:@"security/findpassword" baseURL:nil params:@{@"username" : username, @"code" : code, @"password" : password} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)updatePasswordWithOldpassword: (NSString *)oldepassword code: (NSString *)code newpassword: (NSString *)newpassword successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHPasswordModel sendRequestWithAPI:@"security/updatePassword" baseURL:nil params:@{@"oldpassword" : oldepassword, @"code" : code, @"newpassword" : newpassword} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)updateTradePasswordWithTradePwd: (NSString *)tradePwd phoneCode: (NSString *)phoneCode newTradePwd: (NSString *)newTradePwd successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHPasswordModel sendRequestWithAPI:@"security/updateTradePassword" baseURL:nil params:@{@"tradePwd" : tradePwd, @"phoneCode" : phoneCode, @"newTradePwd" : newTradePwd} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
