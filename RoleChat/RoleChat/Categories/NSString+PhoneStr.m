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

@end
