//
//  QHSocketManager+Handlers.m
//  ChatDemo
//
//  Created by zfqiu on 2017/11/2.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "QHSocketManager+Handlers.h"
#import <MJExtension/MJExtension.h>

@implementation QHSocketManager (Handlers)

- (void)handleMessage: (id)response socket: (SRWebSocket *)socket {
    NSDictionary *dict = [response mj_JSONObject];
    NSString *msg = [NSString stringWithFormat:@"%@",dict[@"msg"]];
    if ([msg isEqualToString:@"ping"]) {
        [[QHSocketManager manager] send:@{@"msg" : @"pong"}];
        return  ;
    }
    if (dict[@"id"] && [dict[@"result"] isKindOfClass:[NSString class]] && [dict[@"result"] isEqualToString:@"error"]) {
        MessageCompletion completion = [[QHSocketManager manager].failureQueue objectForKey:dict[@"id"]];
        if (completion) {
            completion(dict);
        }
    } else if (dict[@"id"]) {
        MessageCompletion completion = [[QHSocketManager manager].queue objectForKey:dict[@"id"]];
        if (completion) {
            completion(dict);
        }
    }
}

@end
