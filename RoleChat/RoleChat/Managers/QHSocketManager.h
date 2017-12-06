//
//  SocketManager.h
//  ChatDemo
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 连接状态
 */
typedef NS_ENUM(NSInteger,QHSocketStatus){
    QHSocketStatus_Connected,// 已连接
    QHSocketStatus_Failed,// 失败
    QHSocketStatus_ClosedByServer,// 系统关闭
    QHSocketStatus_ClosedByUser,// 用户关闭
    QHSocketStatus_Received// 接收消息
};

/**
 接受消息类型
 */
typedef NS_ENUM(NSInteger,QHSocketReceiveType){
    QHSocketReceiveType_Message,
    QHSocketReceiveType_Pong
};

/**
 成功回调
 */
typedef void(^SocketDidConnect)(void);

/**
 关闭回调

 @param code 失败码
 @param reason 失败原因
 @param wasClean 清理
 */
typedef void(^SocketDidClose)(NSInteger code,NSString *reason,BOOL wasClean);

/**
 失败回调

 @param error 错误
 */
typedef void(^SocketDidFail)(NSError *error);

/**
 消息回调
 
 @param response 消息体
 */
typedef void(^MessageCompletion)(id response);

@interface QHSocketManager : NSObject

/**
 连接回调
 */
@property (nonatomic, copy) SocketDidConnect connect;

/**
 失败回调
 */
@property (nonatomic, copy) SocketDidFail failure;

/**
 关闭回调
 */
@property (nonatomic, copy) SocketDidClose close;

/**
 消息接受回调
 */
@property (nonatomic, copy) MessageCompletion handler;

/**
 当前socket连接状态
 */
@property (nonatomic, assign) QHSocketStatus socketStatus;

/**
 超时重连时间,默认1秒
 */
@property (nonatomic, assign) NSTimeInterval overTime;

/**
 重连次数,默认5次
 */
@property (nonatomic, assign) NSInteger reconnectCount;

/**
 回调队列
 */
@property (nonatomic, strong) NSMutableDictionary *queue;

/**
 失败回调
 */
@property (nonatomic, strong) NSMutableDictionary *failureQueue;


@property (nonatomic, strong) NSMutableArray *rooms;

/**
 单例

 @return QHSocketManager
 */
+ (instancetype)manager;

/**
 消息发送

 @param content 字典类型消息体
 */
- (void)send: (NSDictionary *)content;


/**
 发送请求

 @param content 内容
 @param completion 成功回调
 @param failue 失败回调
 */
- (void)send: (NSDictionary *)content completion: (MessageCompletion)completion failure: (MessageCompletion)failue;

/**
 配置版本号

 @param version 版本名称
 */
- (void)configVersion: (NSString *)version;

/**
 服务器重连
 */
- (void)reconnect;

- (void)loginConfig;

/**
 连接socket

 @param urlStr socket地址
 @param connect 成功回调
 @param failure 失败回调
 */
- (void)connectServerWithUrlStr: (NSString *)urlStr connect: (SocketDidConnect)connect failure: (SocketDidFail)failure;

/**
 关闭
 */
- (void)closeServerWithClose: (SocketDidClose)close;

@end
