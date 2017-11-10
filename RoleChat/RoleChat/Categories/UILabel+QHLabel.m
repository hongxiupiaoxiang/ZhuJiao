//
//  UILabel+QHLabel.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "UILabel+QHLabel.h"

@implementation UILabel (QHLabel)

+ (UILabel *)detailLabel {
    return [self labelWithFont:14 color:RGB939EAE];
}

+ (UILabel *)defalutLabel {
    return [self labelWithFont:15];
}

+ (UILabel *)labelWithColor: (UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = FONT(15);
    return label;
}

+ (UILabel *)labelWithFont: (NSInteger)font {
    return [self labelWithFont:font color:RGB4A5970];
}

+ (UILabel *)labelWithFont: (NSInteger)font color: (UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = FONT(font);
    return label;
}

@end
