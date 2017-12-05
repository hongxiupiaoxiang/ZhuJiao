//
//  QHFriendMessageModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/24.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRealmBaseModel.h"

@interface QHRealmFriendMessageModel : QHRealmBaseModel

@property NSString *messageId;
@property NSString *fromId;
@property NSString *phoneCode;
@property NSString *phone;
@property NSString *username;
@property NSString *fromNickname;
@property NSString *to;
@property NSString *toNickname;
@property NSString *message;
@property NSString *state;
@property NSString *fromPush;
@property NSString *tpPush;
@property NSString *expressAt;
@property NSString *imgurl;

// 本地添加属性
@property NSString *dealStatus; // 1:已同意 2:未同意
@property BOOL read; // 是否读取

@end
