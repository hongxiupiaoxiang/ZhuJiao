//
//  QHSocketManager.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHSocketManager : NSObject

@property (nonatomic, assign) BOOL isConect;

+ (instancetype)manager;
- (void)connect;
- (void)close;

@end
