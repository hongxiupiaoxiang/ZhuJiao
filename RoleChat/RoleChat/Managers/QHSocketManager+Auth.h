//
//  QHSocketManager+Auth.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Auth)

/**
 登录

 @param completion 登录回调
 */
- (void)authLoginWithCompletion: (MessageCompletion)completion;

/**
 登出

 @param completion 登出回调
 */
- (void)authLogoutWithCompletion: (MessageCompletion)completion;

/**
 设置用户名

 @param username 用户名
 @param completion 回调
 */
- (void)authSetUsername: (NSString *)username completion: (MessageCompletion)completion;

@end
