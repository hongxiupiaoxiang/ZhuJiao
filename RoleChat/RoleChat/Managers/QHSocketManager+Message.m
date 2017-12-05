//
//  QHSocketManager+Message.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Message.h"

@implementation QHSocketManager (Message)

- (void)createDirectMessageWithUsername: (NSString *)username completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"createDirectMessage",
                                      @"msg" : @"method",
                                      @"params" : @[username]
                                      } completion:completion failure:failure];
}

- (void)sendMessageWithRid: (NSString *)rid msg: (NSString *)msg completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"sendMessage",
                                      @"msg" : @"method",
                                      @"params" : @[@{@"rid" : rid,@"msg" : msg}]
                                      } completion:completion failure:failure];
}

@end
