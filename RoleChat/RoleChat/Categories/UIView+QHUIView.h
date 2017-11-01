//
//  UIView+QHUIView.h
//  GoldWorld
//
//  Created by baijiang on 2017/6/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QHUIView)

+(UIView *)initWhiteView:(UIView*)view :(CGRect)frame;

-(void)showHUD;
-(void)hideHUD;

@end
