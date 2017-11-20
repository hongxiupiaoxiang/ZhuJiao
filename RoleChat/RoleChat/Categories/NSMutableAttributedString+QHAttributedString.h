//
//  NSMutableAttributedString+QHAttributedString.h
//  ShareMedianet
//
//  Created by zfqiu on 2017/7/5.
//  Copyright © 2017年 qhsj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (QHAttributedString)

+ (NSMutableAttributedString *)getAttr: (NSString *)str lineSpacing: (CGFloat)lineSpacing font: (CGFloat)font;
+ (NSMutableAttributedString *)getAttr: (NSString *)originStr color: (UIColor *)color targetStr: (NSString *)targerStr;

@end
