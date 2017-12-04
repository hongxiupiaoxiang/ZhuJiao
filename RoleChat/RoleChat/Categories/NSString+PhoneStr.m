//
//  NSString+PhoneStr.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "NSString+PhoneStr.h"

@implementation NSString (PhoneStr)

+ (NSString *)getPhoneHiddenStringWithPhone: (NSString *)phone {
    if (phone.length > 8) {
        return [NSString stringWithFormat:@"%@****%@",[phone substringToIndex:3], [phone substringWithRange:NSMakeRange(7, phone.length-7)]];
    } else {
        return phone;
    }
}

+ (NSString *)getNameHiddenStringWithName: (NSString *)name {
    if (name.length == 1) {
        return name;
    } else if (name.length == 2) {
        return [NSString stringWithFormat:@"%@*",[name substringToIndex:1]];
    } else {
        return [NSString stringWithFormat:@"%@*%@",[name substringToIndex:1], [name substringWithRange:NSMakeRange(name.length-1, 1)]];
    }
}
+ (NSString *)getIdCardHiddenStringWithIdCard: (NSString *)idCard {
    if (idCard.length > 10) {
        NSMutableString *attr = [[NSMutableString alloc] initWithString:[idCard substringToIndex:6]];
        for (NSInteger i = 0; i < attr.length - 10; i++) {
            [attr appendString:@"*"];
        }
        [attr appendFormat:@"%@",[idCard substringWithRange:NSMakeRange(idCard.length-4, 4)]];
        return attr.copy;
    } else {
        return idCard;
    }
}

@end
