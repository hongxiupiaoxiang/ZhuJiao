//
//  QHSocketManager.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"
#import <Starscream/Starscream-Swift.h>

@interface QHSocketManager ()<SRWebSocketDelegate>

@property (nonatomic, strong) NSURL *serverURL;
@property (nonatomic, strong) WebSocket *webSocket;

@end

@implementation QHSocketManager

+(instancetype)manager {
    static QHSocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QHSocketManager alloc]init];
    });
    return manager;
}
//
//- (BOOL)isConect {
//    return self.socket.readyState == SR_OPEN || self.socket.readyState == SR_CONNECTING;
//}
//
//- (void)connect {
//    if (self.socket) {
//        self.socket.delegate = nil;
//        [self.socket close];
//    }
//    
//    self.socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://54.251.134.162:3000/websocket"]]];
//    self.socket.delegate = self;
//    [self.socket open];
//}
//
//- (void)close {
//    if (self.socket) {
//        [self.socket close];
//    }
//}
//
//#pragma mark - SRWebSocketDelegate
//- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    NSLog(@"Websocket Connected");
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
//    NSLog(@":( Websocket Failed With Error %@", error);
//    self.socket = nil;
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
//    // 接受消息
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
//    self.socket = nil;
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
//    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",reply);
//}

@end
