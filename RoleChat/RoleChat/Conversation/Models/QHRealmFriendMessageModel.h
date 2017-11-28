//
//  QHFriendMessageModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/24.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRealmBaseModel.h"

@interface QHRealmFriendMessageModel : QHRealmBaseModel

@property (nonatomic, copy) NSString *messageId;
@property (nonatomic, copy) NSString *fromId;
@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *fromNickname;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *toNickname;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *fromPush;
@property (nonatomic, copy) NSString *tpPush;
@property (nonatomic, copy) NSString *expressAt;
@property (nonatomic, copy) NSString *imgurl;

// 本地添加属性
@property (nonatomic, copy) NSString *dealStatus; // 1:已同意 2:未同意
@property (nonatomic, assign) BOOL read; // 是否读取

@end
