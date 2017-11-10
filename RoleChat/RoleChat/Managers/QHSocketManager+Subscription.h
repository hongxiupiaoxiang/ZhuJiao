//
//  QHSocketManager+Subscription.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Subscription)

/**
 订阅频道

 @param completion completion
 */
- (void)subscriptionFriendRequestWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)subscriptionUsersWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

- (void)unsubSciptionsWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure;

@end
