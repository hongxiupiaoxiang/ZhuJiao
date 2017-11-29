//
//  QHSocketManager+Handlers.m
//  ChatDemo
//
//  Created by zfqiu on 2017/11/2.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "QHSocketManager+Handlers.h"
#import "QHRealmFriendMessageModel.h"

@implementation QHSocketManager (Handlers)

- (void)handleMessage: (id)response socket: (SRWebSocket *)socket {
    NSDictionary *dict = [response mj_JSONObject];
    NSString *msg = [NSString stringWithFormat:@"%@",dict[@"msg"]];
    if ([msg isEqualToString:@"ping"]) {
        [[QHSocketManager manager] send:@{@"msg" : @"pong"}];
        return  ;
    }
    // dict[@"id"] && [dict[@"result"] isKindOfClass:[NSString class]] && [dict[@"result"] isEqualToString:@"error"]
    if (dict[@"error"]) {
        MessageCompletion completion = [[QHSocketManager manager].failureQueue objectForKey:dict[@"id"]];
        if (completion) {
            completion(dict);
            [[QHSocketManager manager].failureQueue removeObjectForKey:dict[@"id"]];
        }
    } else if (dict[@"id"] && [dict[@"msg"] isEqualToString:@"result"]) {
        // 请求回调
        MessageCompletion completion = [[QHSocketManager manager].queue objectForKey:dict[@"id"]];
        if (completion) {
            completion(dict);
            [[QHSocketManager manager].queue removeObjectForKey:dict[@"id"]];
        }
    }
    
    // 全局添加好友回调
    if ([dict[@"collection"] isEqualToString:@"friendMessage"] && dict[@"error"] == nil && [dict[@"msg"] isEqualToString:@"added"]) {
        QHRealmFriendMessageModel *model = [QHRealmFriendMessageModel modelWithJSON:dict[@"fields"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [QHRealmDatabaseManager updateRecord:model];
        });
    }
}

@end
