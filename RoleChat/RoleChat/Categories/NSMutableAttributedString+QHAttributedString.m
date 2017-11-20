//
//  NSMutableAttributedString+QHAttributedString.m
//  ShareMedianet
//
//  Created by zfqiu on 2017/7/5.
//  Copyright © 2017年 qhsj. All rights reserved.
//

#import "NSMutableAttributedString+QHAttributedString.h"

@implementation NSMutableAttributedString (QHAttributedString)

+ (NSMutableAttributedString *)getAttr: (NSString *)str lineSpacing: (CGFloat)lineSpacing font: (CGFloat)font {
    if (!str.length) {
        str = @"";
    }
    NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:str];
    atrStr.alignment = (NSTextAlignment)(NSTextAlignmentJustified | NSTextAlignmentNatural);
    atrStr.lineSpacing = lineSpacing;
    atrStr.font = FONT(font);
    return atrStr;
}

+ (NSMutableAttributedString *)getAttr: (NSString *)originStr color: (UIColor *)color targetStr: (NSString *)targerStr {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:originStr];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:[originStr rangeOfString:targerStr]];
    return attr;
}

@end
