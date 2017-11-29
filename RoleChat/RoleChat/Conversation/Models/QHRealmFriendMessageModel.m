//
//  QHFriendMessageModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/24.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRealmFriendMessageModel.h"

@implementation QHRealmFriendMessageModel

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"messageId" : @"id"};
}

+ (NSString *)primaryKey {
    return @"fromNickname";
}

@end