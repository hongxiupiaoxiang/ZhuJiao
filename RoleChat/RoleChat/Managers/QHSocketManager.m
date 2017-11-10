//
//  SocketManager.m
//  ChatDemo
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "QHSocketManager.h"
#import "QHSocketManager+Handlers.h"

@interface QHSocketManager() <SRWebSocketDelegate>

/**
 SRWebSocket
 */
@property (nonatomic, strong) SRWebSocket *socket;
@property (nonatomic, copy) NSString *urlStr;

@end

@implementation QHSocketManager {
    NSInteger _reconnectCounter;
}

+ (instancetype)manager {
    static QHSocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QHSocketManager alloc] init];
        manager.overTime = 1;
        manager.reconnectCount = 3;
        manager.socketStatus = QHSocketStatus_Failed;
    });
    return manager;
}

- (void)connectServerWithUrlStr: (NSString *)urlStr connect: (SocketDidConnect)connect failure: (SocketDidFail)failure {
    [QHSocketManager manager].urlStr = urlStr;
    [QHSocketManager manager].connect = connect;
    [QHSocketManager manager].failure = failure;
    [self openInternal];
}

- (void)openInternal{
    [[QHSocketManager manager].socket close];
    [QHSocketManager manager].socket.delegate = nil;
    
    [QHSocketManager manager].socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[QHSocketManager manager].urlStr]]];
    [QHSocketManager manager].socket.delegate = self;
    [[QHSocketManager manager].socket open];
}

- (void)closeServerWithClose: (SocketDidClose)close {
    [QHSocketManager manager].close = close;
    [self closeInternal];
}

- (void)closeInternal {
    [[QHSocketManager manager].socket close];
    [QHSocketManager manager].socket = nil;
}

- (void)reconnect {
    if (_reconnectCounter < self.reconnectCount) {
        _reconnectCounter++;
        [self openInternal];
    } else {
        NSLog(@"Websocket Reconnected Outnumber ReconnectCount");
    }
}

- (void)send: (NSDictionary *)content {
    if (!socketIsConnected) {
        return;
    }
    NSString *randomId = [NSString randomStringWithLength:50];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:content];
    [dictM setObject:randomId forKey:@"id"];
    NSString *sendStr = [dictM mj_JSONString];
    [[QHSocketManager manager].socket send:sendStr];
    NSLog(@"WebSocket send:%@",content);
}

- (void)send: (NSDictionary *)content completion: (MessageCompletion)completion failure: (MessageCompletion)failue {
    if (!socketIsConnected) {
        if (failue) {
            failue(@"error");
            return;
        }
    }
    NSString *randomId = [NSString randomStringWithLength:50];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:content];
    [dictM setObject:randomId forKey:@"id"];
    NSString *sendStr = [dictM mj_JSONString];
    [[QHSocketManager manager].socket send:sendStr];
    if (completion) {
        [QHSocketManager manager].queue = @{randomId : completion};
    }
    if (failue) {
        [QHSocketManager manager].failureQueue = @{randomId : failue};
    }
    NSLog(@"WebSocket send:%@",sendStr);
}

- (void)configVersion:(NSString *)version {
    NSDictionary *dict = @{@"version" : version,
                           @"support" : @[version, @"pre2", @"pre1"],
                           @"msg" : @"connect"
                           };
    [[QHSocketManager manager] send:dict];
}

#pragma mark SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    [QHSocketManager manager].socketStatus = QHSocketStatus_Connected;
    if ([QHSocketManager manager].connect) {
        [QHSocketManager manager].connect();
    }
    _reconnectCounter = 0;
};

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"WebSocket receive:%@",message);
    [QHSocketManager manager].socketStatus = QHSocketStatus_Received;
    [[QHSocketManager manager] handleMessage:message socket:webSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket Failed With Error %@", error);
    [QHSocketManager manager].socketStatus = QHSocketStatus_Failed;
    [[QHSocketManager manager] reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Closed Reason:%@  code = %zd",reason,code);
    if (reason) {
        [QHSocketManager manager].socketStatus = QHSocketStatus_ClosedByServer;
        [self reconnect];
    } else {
        [QHSocketManager manager].socketStatus = QHSocketStatus_ClosedByUser;
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    NSLog(@"%@",pongPayload);
}

- (void)dealloc {
    [self closeInternal];
}

@end
