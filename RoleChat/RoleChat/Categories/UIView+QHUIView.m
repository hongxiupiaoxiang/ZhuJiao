//
//  UIView+QHUIView.m
//  GoldWorld
//
//  Created by baijiang on 2017/6/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//
#import "MBProgressHUD.h"
#import "UIView+QHUIView.h"

const char* key = "MBPROGRESSHUDKEY";
@implementation UIView (QHUIView)

+(UIView *)initWhiteView:(UIView*)view :(CGRect)frame{
    UIView * whiteView = [[UIView alloc] initWithFrame:frame];
    whiteView.backgroundColor = WhiteColor;
    [view addSubview:whiteView];
    return whiteView;
}

-(void)showHUD {
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.dimBackground = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    [self addSubview:hud];
    [hud showAnimated:YES];
    
    objc_setAssociatedObject(self, (const void*)key, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return ;
}

-(void)hideHUD {
    MBProgressHUD* hud = objc_getAssociatedObject(self, key);
    if(hud)
        [hud hideAnimated:YES];
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return ;
}

@end
