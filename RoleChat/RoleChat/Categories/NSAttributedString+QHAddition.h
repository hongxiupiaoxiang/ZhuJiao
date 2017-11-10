//
//  NSAttributedString+QHAddition.h
//  GoldWorld
//
//  Created by zfqiu on 2017/3/21.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (QHAddition)

+ (instancetype)qh_imageTextWithImage:(UIImage *)image imageWH:(CGSize)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;

@end
