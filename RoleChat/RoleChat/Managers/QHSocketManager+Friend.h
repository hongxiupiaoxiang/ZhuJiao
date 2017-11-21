//
//  QHSocketManager+Friend.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Friend)

- (void)queryUserWithUsername: (NSString *)username completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)requestAddFriendWithRefId: (NSString *)refId nickname: (NSString *)nickname message: (NSString *)message completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)acceptFriendRequest: (NSString *)userId completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

@end
