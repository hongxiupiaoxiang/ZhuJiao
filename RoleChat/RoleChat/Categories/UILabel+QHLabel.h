//
//  UILabel+QHLabel.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (QHLabel)

+ (UILabel *)detailLabel;

+ (UILabel *)defalutLabel;

+ (UILabel *)labelWithFont: (NSInteger)font;

+ (UILabel *)labelWithColor: (UIColor *)color;

+ (UILabel *)labelWithFont: (NSInteger)font color: (UIColor *)color;

@end
