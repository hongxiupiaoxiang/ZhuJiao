//
//  QHSocketManager+Auth.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Auth.h"

@implementation QHSocketManager (Auth)

- (void)authLoginWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"msg" : @"method",
                                      @"method" : @"login",
                                      @"params" : @[@{@"serviceName" : @"qhsoft",
                                                      @"accessToken" : [QHPersonalInfo sharedInstance].appLoginToken.length ? [QHPersonalInfo sharedInstance].appLoginToken : @"",
                                                      @"nickname" : [QHPersonalInfo sharedInstance].userInfo.nickname,
                                                      @"username" : [QHPersonalInfo sharedInstance].userInfo.username,
                                                      @"id" : [QHPersonalInfo sharedInstance].userInfo.userID,
                                                      @"imgurl" : ([QHPersonalInfo sharedInstance].userInfo.imgurl.length ? [QHPersonalInfo sharedInstance].userInfo.imgurl : @""),
                                                      @"gender" : [QHPersonalInfo sharedInstance].userInfo.gender,
                                                      @"phoneCode" : [QHPersonalInfo sharedInstance].userInfo.phoheCode,
                                                      @"phone" : [QHPersonalInfo sharedInstance].userInfo.phone,
                                                      @"userAddress" : [QHPersonalInfo sharedInstance].userInfo.userAddress
                                                      }]
                                      } completion:completion failure:failure];
}

- (void)authLogoutWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"UserPresence:away",
                                      @"params" : @[],
                                      @"msg" : @"method"
                                      } completion:completion failure:failure];
}

- (void)initDataWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"initData",
                                      @"params" : @[],
                                      @"msg" : @"method"
                                      } completion:completion failure:failure];
}

- (void)authoIdWithId: (NSString *)authId Completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"name" : authId,
                                      @"params" : @[],
                                      @"msg" : @"sub"
                                      } completion:completion failure:failure];
}

- (void)initPublishWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"initPublish",
                                      @"params" : @[],
                                      @"msg" : @"method"
                                      } completion:completion failure:failure];
}

- (void)subscribeWithCompletion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"subscribe",
                                      @"params" : @[[NSString getNowTimeTimestamp]],
                                      @"msg" : @"method"
                                      } completion:completion failure:failure];
}

- (void)authSetNickname: (NSString *)nickname completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    [[QHSocketManager manager] send:@{
                                      @"method" : @"setNickname",
                                      @"msg" : @"method",
                                      @"params" : @[nickname]
                                      } completion:completion failure:failure];
}


@end
