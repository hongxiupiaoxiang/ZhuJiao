//
//  QHRealmMListModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/12/6.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>
#import "QHRealmSenderModel.h"
#import "QHRealmDateModel.h"

@interface QHRealmMListModel : RLMObject

@property NSString *_id;
@property NSString *rid;
@property NSString *msg;
@property QHRealmDateModel *ts;
@property QHRealmSenderModel *u;
@property NSInteger unreadcount;

@end
