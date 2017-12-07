//
//  QHRealmContactModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/21.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>

@interface QHRealmContactModel : RLMObject

@property NSString *imgurl;
@property BOOL isfriends;
@property NSString *nickname;
@property NSString *openid;
@property NSString *phone;
@property NSString *phoneCode;
@property NSString *username;
@property NSString *rid;

@end
