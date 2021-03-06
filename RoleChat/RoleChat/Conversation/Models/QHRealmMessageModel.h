//
//  QHRealmMessageModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>
#import "QHRealmSenderModel.h"
#import "QHRealmDateModel.h"

@interface QHRealmMessageModel : RLMObject

@property NSString *_id;
@property NSString *rid;
@property NSString *msg;
@property QHRealmDateModel *_updatedAt;
@property QHRealmSenderModel *u;
@property BOOL read;

@end
