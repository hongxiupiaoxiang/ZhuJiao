//
//  QHRealmMessageModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>
#import "QHRealmSenderModel.h"

@interface QHRealmMessageModel : RLMObject

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *ts;
@property QHRealmSenderModel *u;

@end
