//
//  QHSocketManager+Subscription.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Subscription.h"

@implementation QHSocketManager (Subscription)

- (void)subsciptionWithCompletion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"subscriptions/get",
                                      @"params" : @[],
                                      @"msg" : @"method"
                                      } completion:completion];
}

- (void)unsubSciptionsWithCompletion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"unsub"
                                      } completion:completion];
}

@end
