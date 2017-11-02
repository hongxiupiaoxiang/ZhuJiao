//
//  QHSocketManager.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager ()

@property (nonatomic, copy) SocketCompletion internalConnetionHandler;

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


- (void)clear {
    
}

@end
