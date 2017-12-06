//
//  QHSocketManager+Room.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager+Room.h"

@implementation QHSocketManager (Room)

- (void)getRoomsChangeWithUserId: (NSString *)userId Completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    bool bool_false = false;
    NSDictionary *dict = @{@"content" : @(bool_false)};
    [[QHSocketManager manager] send:@{
                                      @"name" : @"stream-notify-user",
                                      @"params" : @[[NSString stringWithFormat:@"%@/rooms-changed",userId],dict[@"content"]],
                                      @"msg" : @"sub"
                                      } completion:completion failure:failure];
}

- (void)streamRoomMessagesWithRoomId: (NSString *)roomId completion: (MessageCompletion)completion failure: (MessageCompletion)failure {
    if ([[QHSocketManager manager].rooms containsObject:roomId]) {
        if (completion) {
            completion(@"success");
        }
        return  ;
    }
    [[QHSocketManager manager] send:@{
                                      @"name" : @"stream-room-messages",
                                      @"params" : @[roomId],
                                      @"msg" : @"sub"
                                      } completion:completion failure:failure];
//    [[QHSocketManager manager] send:@{
//                                      @"name" : @"stream-notify-room",
//                                      @"params" : @[roomId],
//                                      @"msg" : @"sub"
//                                      } completion:completion failure:failure];
}

@end
