//
//  NSString+RandomString.m
//  ChatDemo
//
//  Created by zfqiu on 2017/11/2.
//  Copyright © 2017年 zfQiu. All rights reserved.
//

#import "NSString+RandomString.h"

@implementation NSString (RandomString)

+ (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i = 0; i < len; i++) {
        NSUInteger index = arc4random() % [letters length];
        [randomString appendFormat: @"%C", [letters characterAtIndex: index]];
    }
    return randomString;
}

@end
