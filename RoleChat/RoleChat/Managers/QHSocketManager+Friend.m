//
//  QHSocketManager+Friend.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Friend.h"

@implementation QHSocketManager (Friend)

// 15107716547
// 13651431256

// 查询好友
- (void)queryUserWithUsername: (NSString *)username completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"findFriend",
                                      @"params" : @[username],
                                      @"msg" : @"method"
                                      } completion:completion failure:failure];
}

// 好友请求
- (void)requestAddFriendWithRefId: (NSString *)refId nickname: (NSString *)nickname message: (NSString *)message completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"addFriendRequest",
                                      @"params" : @[@{@"refId" : refId, @"nickname" : nickname, @"message" : message}]
                                      } completion:completion failure:failure];
}

// 添加好友
- (void)acceptFriendRequestWithMessageId: (NSString *)messageId fromNickname: (NSString *)fromNickname flag: (NSString *)flag formId: (NSString *)fromId to: (NSString *)to completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"acceptFriendRequest",
                                      @"params" : @[
                                              @{
                                                  @"_id" : messageId,
                                                  @"fromNickname" : fromNickname,
                                                  @"flag" : flag,
                                                  @"fromId" : fromId,
                                                  @"to" : to
                                                  }
                                              ]
                                      } completion:completion failure:failure];
}

// 获取好友列表
- (void)getFriendListCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"getFriendList",
                                      @"params" : @[]
                                      } completion:completion failure:failure];
}

// 删除好友
- (void)deleteFriendsWithUserId: (NSString *)userId completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"deleteFriends",
                                      @"params" : @[userId]
                                      } completion:completion failure:failure];
}

@end
