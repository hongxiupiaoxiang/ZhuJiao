//
//  SocketManager.m
//  ChatDemo
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "QHSocketManager.h"
#import "QHSocketManager+Handlers.h"
#import "QHRealmContactModel.h"
#import "QHRealmFriendMessageModel.h"

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
        manager.queue = [[NSMutableDictionary alloc] init];
        manager.failureQueue = [[NSMutableDictionary alloc] init];
        manager.socketStatus = QHSocketStatus_Failed;
        manager.rooms = [[NSMutableArray alloc] init];
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
    [[QHSocketManager manager].failureQueue removeAllObjects];
    [[QHSocketManager manager].queue removeAllObjects];
    [[QHSocketManager manager].rooms removeAllObjects];
    
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
        DLog(@"Websocket Reconnected Outnumber ReconnectCount");
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
    DLog(@"WebSocket send:%@",content);
}

- (void)send: (NSDictionary *)content completion: (MessageCompletion)completion failure: (MessageCompletion)failue {
    if (!socketIsConnected) {
        if (failue) {
            failue(@"error");
        }
        return;
    }
    NSString *randomId = [NSString randomStringWithLength:50];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:content];
    [dictM setObject:randomId forKey:@"id"];
    NSString *sendStr = [dictM mj_JSONString];
    [[QHSocketManager manager].socket send:sendStr];
    if (completion) {
        [[QHSocketManager manager].queue setValue:completion forKey:randomId];
    }
    if (failue) {
        [[QHSocketManager manager].failureQueue setValue:failue forKey:randomId];
    }
    DLog(@"WebSocket send:%@",sendStr);
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
    DLog(@"Websocket Connected");
    [QHSocketManager manager].socketStatus = QHSocketStatus_Connected;
    if ([QHSocketManager manager].connect) {
        [QHSocketManager manager].connect();
    }
    _reconnectCounter = 0;
};

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    [QHSocketManager manager].socketStatus = QHSocketStatus_Received;
    [[QHSocketManager manager] handleMessage:message socket:webSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    DLog(@":( Websocket Failed With Error %@", error);
    [QHSocketManager manager].socketStatus = QHSocketStatus_Failed;
    [[QHSocketManager manager] reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    DLog(@"Closed Reason:%@  code = %zd",reason,code);
    if (reason) {
        [QHSocketManager manager].socketStatus = QHSocketStatus_ClosedByServer;
        [self reconnect];
    } else {
        [QHSocketManager manager].socketStatus = QHSocketStatus_ClosedByUser;
    }
}

- (void)configSub {
    [[QHSocketManager manager] authLoginWithCompletion:^(id response) {
        NSString *authId = response[@"result"][@"id"];
        [[QHSocketManager manager] initPublishWithCompletion:^(id response) {
            [[QHSocketManager manager] authoIdWithId:authId Completion:nil failure:nil];
        } failure:nil];
        [[QHSocketManager manager] getFriendListCompletion:^(id response) {
            NSArray *modelArr = [NSArray modelArrayWithClass:[QHRealmContactModel class] json:response[@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [QHRealmDatabaseManager updateRecords:modelArr];
            });
        } failure:nil];
    } failure:nil];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    DLog(@"%@",pongPayload);
}

- (void)loginConfig {
    [[QHSocketManager manager] authLoginWithCompletion:^(id response) {
        NSString *authId = response[@"result"][@"id"];
        [[QHSocketManager manager] getRoomsChangeWithUserId:authId Completion:^(id response) {
            DLog(@"%@",response);
        } failure:nil];
        [[QHSocketManager manager] initPublishWithCompletion:^(id response) {
            [[QHSocketManager manager] authoIdWithId:authId Completion:^(id response) {
                [[QHSocketManager manager] initDataWithCompletion:^(id response) {
//                    if (response[@"result"] && response[@"result"][@"friendMessage"]) {
//                        NSArray *models = [NSArray modelArrayWithClass:[QHRealmFriendMessageModel class] json:response[@"result"][@"friendMessage"]];
//                        if (models.count > 0) {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [QHRealmDatabaseManager updateRecords:models];
//                            });
//                        }
//                    }
                } failure:nil];
            } failure:nil];
        } failure:nil];
        [[QHSocketManager manager] getRoomsChangeWithUserId:authId Completion:^(id response) {
            DLog(@"%@",response);
        } failure:nil];
        [[QHSocketManager manager] getFriendListCompletion:^(id response) {
            NSArray *modelArr = [NSArray modelArrayWithClass:[QHRealmContactModel class] json:response[@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [QHRealmDatabaseManager updateRecords:modelArr];
            });
        } failure:nil];
    } failure:nil];
}

- (void)dealloc {
    [self closeInternal];
}

@end
