//
//  QHSocketManager+Subscription.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Subscription.h"

@implementation QHSocketManager (Subscription)

- (void)subscriptionFriendRequestWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"name" : @"friendMessage",
                                      @"params" : @[],
                                      @"msg" : @"sub"
                                      } completion:completion failure:failure];
}

- (void)subscriptionUsersWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"name" : @"users",
                                      @"params" : @[],
                                      @"msg" : @"sub"
                                      } completion:completion failure:failure];
}

- (void)unsubSciptionsWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"unsub"
                                      } completion:completion failure:failure];
}

@end
