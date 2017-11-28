//
//  QHSocketManager+Friend.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Friend)

// 查找用户
- (void)queryUserWithUsername: (NSString *)username completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

// 好友请求
- (void)requestAddFriendWithRefId: (NSString *)refId nickname: (NSString *)nickname message: (NSString *)message completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

// 好友请求处理
- (void)acceptFriendRequestWithMessageId: (NSString *)messageId fromNickname: (NSString *)fromNickname flag: (NSString *)flag formId: (NSString *)fromId to: (NSString *)to completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

// 获取用户好友
- (void)getFriendListCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

// 删除好友
- (void)deleteFriendsWithUserId: (NSString *)userId completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

@end
