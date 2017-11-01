//
//  QHPasswordModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/27.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHPasswordModel : QHBaseModel

// 找回密码
+ (void)findpasswordWithUsername: (NSString *)username code: (NSString *)code password: (NSString *)password successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

// 修改用户登录密码
+ (void)updatePasswordWithOldpassword: (NSString *)oldepassword code: (NSString *)code newpassword: (NSString *)newpassword successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

// 修改交易密码
+ (void)updateTradePasswordWithTradePwd: (NSString *)tradePwd phoneCode: (NSString *)phoneCode newTradePwd: (NSString *)newTradePwd successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
