//
//  QHRealmContactModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/21.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>

@interface QHRealmContactModel : RLMObject

@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, assign) BOOL isfriends;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, copy) NSString *username;

@end
