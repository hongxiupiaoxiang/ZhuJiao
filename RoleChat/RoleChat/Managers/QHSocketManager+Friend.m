//
//  QHSocketManager+Friend.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Friend.h"

@implementation QHSocketManager (Friend)

- (void)queryUserWithUsername: (NSString *)username completion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"queryUser",
                                      @"params" : @[@{@"username" : username}],
                                      @"msg" : @"method"
                                      } completion:completion];
}

- (void)requestAddFriend: (NSString *)username completion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"addUser",
                                      @"params" : @[@{@"username" : [QHPersonalInfo sharedInstance].userInfo.nickname}, @{@"username" : username}]
                                      } completion:completion];
}

@end
