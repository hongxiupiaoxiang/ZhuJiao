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
// 前后不同颜色
+(NSMutableAttributedString *)getAttributeFontColorWithFrontColor : (UIColor *)frontColor fontString :(NSString *)fontString behindColor:(UIColor *)behindColor behindString :(NSString *)behindString;
//中间某字符串不同颜色
+(NSMutableAttributedString *)getAttributeStringWithCenterColor : (UIColor *)centerColor centerString :(NSString *)centerString otherColor:(UIColor *)otherColor allString :(NSString *)allString;
@end
