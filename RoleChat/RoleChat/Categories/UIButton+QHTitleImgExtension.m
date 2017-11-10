//
//  UIButton+QHTitleImgExtension.m
//  GoldWorld
//
//  Created by zfqiu on 2017/5/15.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "UIButton+QHTitleImgExtension.h"
#import "NSAttributedString+QHAddition.h"

@implementation UIButton (QHTitleImgExtension)

+ (UIButton *)getImageBtnWithTitle: (NSString *)title imageStr: (NSString *)iamge imageWH: (CGSize)imgSize titleSize: (NSInteger)titleSize titleColoe: (UIColor *)titleColor space: (CGFloat)space {
    UIButton *imageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    NSAttributedString *attr = [NSAttributedString qh_imageTextWithImage:IMAGENAMED(iamge) imageWH:imgSize title:title fontSize:titleSize titleColor:titleColor spacing:space];
    [imageBtn setAttributedTitle:attr forState:(UIControlStateNormal)];
    imageBtn.titleLabel.numberOfLines = 0;
    imageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    return imageBtn;
}
+(UIButton *)initBottomButton:(UIView *)view fram :(CGRect)fram{
    UIButton * button = [[UIButton alloc] initWithFrame:fram];
    [view addSubview:button];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    button.titleLabel.font = FONT(16);
    button.backgroundColor = MainColor;
    button.layer.cornerRadius = 2;
    button.layer.borderColor = UIColorFromRGB(0x0082bc).CGColor;
    button.layer.borderWidth = 0.5;
    return button;
}
@end
