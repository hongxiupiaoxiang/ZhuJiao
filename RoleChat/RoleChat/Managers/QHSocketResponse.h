//
//  QHSocketResponse.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHSocketResponse : NSObject

@property (nonatomic, strong) WebSocket *socket;
@property (nonatomic, assign) id result;
@property (nonatomic, copy) NSString *responseId;
@property (nonatomic, copy) NSString *collection;
@property (nonatomic, copy) NSString *event;

@end
