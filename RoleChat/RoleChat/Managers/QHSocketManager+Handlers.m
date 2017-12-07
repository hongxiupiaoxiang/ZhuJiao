//
//  QHSocketManager+Handlers.m
//  ChatDemo
//
//  Created by zfqiu on 2017/11/2.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "QHSocketManager+Handlers.h"
#import "QHRealmFriendMessageModel.h"
#import "QHRealmContactModel.h"
#import "QHRealmMessageModel.h"
#import "QHRealmMListModel.h"

@implementation QHSocketManager (Handlers)

- (void)handleMessage: (id)response socket: (SRWebSocket *)socket {
    NSDictionary *dict = [response mj_JSONObject];
    NSString *msg = [NSString stringWithFormat:@"%@",dict[@"msg"]];
    if ([msg isEqualToString:@"ping"]) {
        [[QHSocketManager manager] send:@{@"msg" : @"pong"}];
        return  ;
    }
    // dict[@"id"] && [dict[@"result"] isKindOfClass:[NSString class]] && [dict[@"result"] isEqualToString:@"error"]
    // 处理一对一消息(id)
    [self configMessageWithIdDict:dict];
    
    // 全局添加好友 信息回调
    [self configAddFriendMessageWithDict:dict];
    
    // 处理订阅房间号消息
    [self configRoomsChangeMessageWithDict:dict];
    
    // 获取消息回调
    [self configRecieveMessageWithDict:dict];
    
    // 订阅用户回调
    [self configSubMessage:dict];
}

- (void)configMessageWithIdDict: (NSDictionary *)dict {
    if (dict[@"error"]) {
        MessageCompletion completion = [[QHSocketManager manager].failureQueue objectForKey:dict[@"id"]];
        if (completion) {
            completion(dict);
            [[QHSocketManager manager].queue removeObjectForKey:dict[@"id"]];
            [[QHSocketManager manager].failureQueue removeObjectForKey:dict[@"id"]];
        }
    } else if (dict[@"id"] && [dict[@"msg"] isEqualToString:@"result"]) {
        // 请求回调
        MessageCompletion completion = [[QHSocketManager manager].queue objectForKey:dict[@"id"]];
        if (completion) {
            completion(dict);
            [[QHSocketManager manager].queue removeObjectForKey:dict[@"id"]];
            [[QHSocketManager manager].failureQueue removeObjectForKey:dict[@"id"]];
        }
    }
}

- (void)configAddFriendMessageWithDict: (NSDictionary *)dict {
    if ([dict[@"collection"] isEqualToString:@"friendMessage"] && dict[@"error"] == nil && ![dict[@"fields"][@"message"] isEqualToString:@"请求成功"] && [dict[@"msg"] isEqualToString:@"added"]) {
        QHRealmFriendMessageModel *model = [QHRealmFriendMessageModel modelWithJSON:dict[@"fields"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [QHRealmDatabaseManager updateRecord:model];
        });
    } else if ([dict[@"collection"] isEqualToString:@"accetUser"] && dict[@"error"] == nil && [dict[@"msg"] isEqualToString:@"added"]) {

        QHRealmContactModel *model = [QHRealmContactModel modelWithJSON:dict[@"fields"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [QHRealmDatabaseManager updateRecord:model];
        });
    }
}

- (void)configRoomsChangeMessageWithDict: (NSDictionary *)dict {
    if ([dict[@"collection"] isEqualToString:@"stream-notify-user"] && dict[@"error"] == nil && [dict[@"msg"] isEqualToString:@"changed"]) {
        NSString *roomId;
        if (dict[@"fields"] && dict[@"fields"][@"args"]) {
            NSArray *args = dict[@"fields"][@"args"];
            NSDictionary *dictId = args[1];
             roomId = dictId[@"_id"];
        }
        [[QHSocketManager manager] streamRoomMessagesWithRoomId:roomId completion:^(id response) {
            if (![[QHSocketManager manager].rooms containsObject:roomId]) {
                [[QHSocketManager manager].rooms addObject:roomId];
            }
        } failure:nil];
    }
}

- (void)configRecieveMessageWithDict: (NSDictionary *)dict {
    if ([dict[@"collection"] isEqualToString:@"stream-room-messages"] && dict[@"error"] == nil && [dict[@"msg"] isEqualToString:@"changed"]) {
        QHRealmMessageModel *model = [QHRealmMessageModel modelWithJSON:dict[@"fields"][@"args"][0]];
        QHRealmMListModel *mmodel = [QHRealmMListModel modelWithJSON:dict[@"fields"][@"args"][0]];
        QHRealmMListModel *oldModel = [QHRealmMListModel objectInRealm:[QHRealmDatabaseManager currentRealm] forPrimaryKey:mmodel.rid];
        if (![mmodel.u.username isEqualToString:[QHPersonalInfo sharedInstance].userInfo.username]) {
            mmodel.unreadcount = oldModel.unreadcount+1;
        }
        model.read = false;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [QHRealmDatabaseManager updateRecord:model];
            [QHRealmDatabaseManager updateRecord:mmodel];
        });
    }
}

- (void)configSubMessage: (NSDictionary *)dict {
    if (dict[@"subs"] && dict[@"error"] == nil) {
        MessageCompletion completion = [[QHSocketManager manager].queue objectForKey:dict[@"subs"][0]];
        if (completion) {
            completion(dict);
            [[QHSocketManager manager].queue removeObjectForKey:dict[@"subs"][0]];
        }
    }
}

@end
