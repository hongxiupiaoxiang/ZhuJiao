//
//  NSString+Extensions.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Extensions)

- (NSString *)sha256 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)getCardStringWithInterval: (NSInteger)interval {
    NSMutableString *attr = [NSMutableString stringWithString:self];
    if (attr.length < interval+1) {
        return self;
    }
    for (NSInteger i = 0; i < attr.length-interval; i++) {
        [attr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    NSInteger j = 0;
    for (NSInteger i = 0; i < attr.length; i+=interval) {
        j = (i+interval-1) >= attr.length ? attr.length-i : interval;
        NSString *str = [attr substringWithRange:NSMakeRange(i, j)];
        [arrM addObject:str];
    }
    return [arrM componentsJoinedByString:@" "];
}

@end
