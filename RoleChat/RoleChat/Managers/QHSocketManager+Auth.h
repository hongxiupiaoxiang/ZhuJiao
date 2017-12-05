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
- (void)authLoginWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

/**
 登出

 @param completion 登出回调
 */
- (void)authLogoutWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

/**
 设置用户名

 @param nickname 用户名
 @param completion 回调
 */
- (void)authSetNickname: (NSString *)nickname completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)initPublishWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)subscribeWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)authoIdWithId: (NSString *)authId Completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

@end
