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
+(NSMutableAttributedString *)getAttributeFontColorWithFrontColor : (UIColor *)frontColor fontString :(NSString *)fontString behindColor:(UIColor *)behindColor behindString :(NSString *)behindString{
    NSString * str = [NSString stringWithFormat:@"%@ %@", fontString ,behindString];
    NSMutableAttributedString * mutAttStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mutAttStr addAttribute:NSForegroundColorAttributeName value:frontColor range:NSMakeRange(0, fontString.length)];
    [mutAttStr addAttribute:NSForegroundColorAttributeName value:behindColor range:NSMakeRange(fontString.length, str.length-fontString.length)];
    return mutAttStr;
}
+(NSMutableAttributedString *)getAttributeStringWithCenterColor : (UIColor *)centerColor centerString :(NSString *)centerString otherColor:(UIColor *)otherColor allString :(NSString *)allString{
    NSMutableAttributedString * mutAttStr = [[NSMutableAttributedString alloc] initWithString:allString];;
    [mutAttStr addAttribute:NSForegroundColorAttributeName value:otherColor range:NSMakeRange(0, allString.length)];
    NSString *temp = nil;
    for(int i =0; i < allString.length-centerString.length+1; i++)
    {
        temp = [allString substringWithRange:NSMakeRange(i, centerString.length)];
        if ([temp isEqualToString:centerString])
        {
            [mutAttStr addAttribute:NSForegroundColorAttributeName value:centerColor range:NSMakeRange(i, centerString.length)];
        }
    }
    return mutAttStr;
}
@end
