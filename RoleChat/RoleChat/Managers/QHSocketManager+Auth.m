//
//  QHSocketManager+Auth.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Auth.h"

@implementation QHSocketManager (Auth)

- (void)authLoginWithCompletion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"login",
                                      @"params" : @[@{@"serviceName" : @"qhsoft",
                                                      @"accessToken" : [QHPersonalInfo sharedInstance].appLoginToken,
                                                      @"nickname" : [QHPersonalInfo sharedInstance].userInfo.nickname,
                                                      @"username" : [QHPersonalInfo sharedInstance].userInfo.username,
                                                      @"id" : [QHPersonalInfo sharedInstance].userInfo.userID
                                                      }]
                                      } completion:completion];
}

- (void)authLogoutWithCompletion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"UserPresence:away",
                                      @"params" : @[],
                                      @"msg" : @"method"
                                      } completion:completion];
}

- (void)authSetUsername: (NSString *)username completion: (MessageCompletion)completion {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"setUsername",
                                      @"msg" : @"method",
                                      @"params" : @[username]
                                      } completion:completion];
}

@end
