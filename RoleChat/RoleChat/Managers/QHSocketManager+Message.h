//
//  QHSocketManager+Message.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Message)

// 创建房间
- (void)createDirectMessageWithUsername: (NSString *)username completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

// 发送消息
- (void)sendMessageWithRid: (NSString *)rid msg: (NSString *)msg completion: (MessageCompletion)completion failure: (MessageCompletion)failure;

@end
