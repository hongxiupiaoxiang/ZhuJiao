//
//  UIButton+QHTitleImgExtension.h
//  GoldWorld
//
//  Created by zfqiu on 2017/5/15.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (QHTitleImgExtension)

+ (UIButton *)getImageBtnWithTitle: (NSString *)title imageStr: (NSString *)iamge imageWH: (CGSize)imgSize titleSize: (NSInteger)titleSize titleColoe: (UIColor *)titleColor space: (CGFloat)space;
+(UIButton *)initBottomButton:(UIView *)view fram :(CGRect)fram;
@end
