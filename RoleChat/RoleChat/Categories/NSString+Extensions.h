//
//  NSString+Extensions.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

- (NSString *)sha256;
- (NSString *)getCardStringWithInterval: (NSInteger)interval;
+ (NSString *)getCurrencytagWithString: (NSString *)str;

@end
