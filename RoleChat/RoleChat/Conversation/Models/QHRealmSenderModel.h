//
//  QHRealmSenderModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>

@interface QHRealmSenderModel : RLMObject

@property NSString *_id;
@property NSString *username;
@property NSString *nickname;
@property NSString *imgurl;

@end
