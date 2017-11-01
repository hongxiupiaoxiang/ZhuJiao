//
//  QHBaseViewController+MBProgressHud.m
//  藏宝商户版
//
//  Created by shaw on 16/11/19.
//  Copyright © 2016年 shaw. All rights reserved.
//

#import "MBProgressHUD.h"
#import "QHBaseViewController+MBProgressHud.h"

@implementation QHBaseViewController (MBProgressHud)

-(void)showHUD{
    [self showHUDWithTitle:nil];
}

-(void)showHUDWithTitle:(NSString *)title{
    [self showHUDWithTitle:title hideDelay:0];
}

-(void)showHUDOnlyTitle:(NSString *)title{
    [self showHUDWithMode:MBProgressHUDModeText title:title hideDelay:1.5];
}

-(void)showHUDWithTitle:(NSString *)title hideDelay:(NSTimeInterval)delay{
    [self showHUDWithMode:MBProgressHUDModeIndeterminate title:title hideDelay:delay];
}

-(void)showHUDWithMode:(MBProgressHUDMode)mode title:(NSString *)title hideDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.mode = mode;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    
    if(mode == MBProgressHUDModeIndeterminate)
        hud.dimBackground = YES;
    
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
}

- (void)showHUDInWindowWithMode: (MBProgressHUDMode)mode Title:(NSString *)title hideDelay:(NSTimeInterval)delay
{
    UIWindow * theWindow =[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:theWindow];
    hud.mode = mode;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = title;
    hud.removeFromSuperViewOnHide = YES;
    [theWindow addSubview:hud];
    [hud showAnimated:YES];
    
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
    
}

- (void)showHUDInWindowWithTitle:(NSString *)title hideDelay:(NSTimeInterval)delay
{
    UIWindow * theWindow =[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:theWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = title;
    hud.removeFromSuperViewOnHide = YES;
    [theWindow addSubview:hud];
    [hud showAnimated:YES];
    
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
    
}
-(void)changeHUDTitle:(NSString *)title hideDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if(hud){
        hud.label.text = title;
    }
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
}


-(void)showHUDWithProgress:(CGFloat)progress{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if(hud){
        hud.progress = progress;
    }else{
        hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.mode = MBProgressHUDModeDeterminate;
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor blackColor];
        hud.progress = progress;
        hud.removeFromSuperViewOnHide = YES;
        [self.view addSubview:hud];
        [hud showAnimated:YES];
    }
}

-(void)hideHUD{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    [hud hideAnimated:YES];
}

-(void)hideWindowHUD {
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:mainWindow];
    [hud hideAnimated:YES];
}

@end
