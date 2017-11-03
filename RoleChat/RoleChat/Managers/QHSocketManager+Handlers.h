//
//  QHSocketManager+Handlers.h
//  ChatDemo
//
//  Created by zfqiu on 2017/11/2.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Handlers)

- (void)handleMessage: (id)response socket: (SRWebSocket *)socket;

@end
