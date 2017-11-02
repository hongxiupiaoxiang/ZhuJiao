//
//  QHSocketManager.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SocketCompletion)(WebSocket*, BOOL);
typedef void(^MessageCompletion)(id response);

@class QHSocketManager;

@protocol SocketConnetionHandler <NSObject>

- (void)socketDidConnect: (QHSocketManager *)socket;
- (void)socketDidDisconnect: (QHSocketManager *)socket;

@end

@interface QHSocketManager : NSObject

@property (nonatomic, copy) NSURL *serverURL;
@property (nonatomic, strong) WebSocket *socket;
@property (nonatomic, copy) NSDictionary *queue;
@property (nonatomic, copy) NSDictionary *events;

+ (instancetype)manager;
- (void)connectWithUrl: (NSURL *)url completion: (SocketCompletion)completion;
- (void)disconnectWithCompletion: (SocketCompletion)completion;
- (void)clear;
- (void)sendObject: (NSDictionary *)object completion:(MessageCompletion)completion;

@end
