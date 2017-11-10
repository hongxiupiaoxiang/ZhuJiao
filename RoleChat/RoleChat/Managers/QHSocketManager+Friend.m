//
//  QHSocketManager+Friend.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Friend.h"

@implementation QHSocketManager (Friend)

- (void)queryUserWithUsername: (NSString *)username completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"queryUser",
                                      @"params" : @[@{@"username" : username}],
                                      @"msg" : @"method"
                                      } completion:completion failure:failure];
}

- (void)requestAddFriend: (NSArray *)content completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"addFriendRequest",
                                      @"params" : content
                                      } completion:completion failure:failure];
}

- (void)acceptFriendRequest: (NSString *)userId completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"acceptFriendRequest",
                                      @"params" : @[userId]
                                      } completion:completion failure:failure];
}

@end
