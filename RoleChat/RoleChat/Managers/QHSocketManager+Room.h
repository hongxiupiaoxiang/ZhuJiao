//
//  QHSocketManager+Room.h
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Room)

// 获取房间订阅号
- (void)getRoomsChangeWithUserId: (NSString *)userId Completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

// 订阅房间
- (void)streamRoomMessagesWithRoomId: (NSString *)roomId completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

@end
