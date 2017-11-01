//
//  QHBaseViewController+MBProgressHud.h
//  藏宝商户版
//
//  Created by shaw on 16/11/19.
//  Copyright © 2016年 shaw. All rights reserved.
//

#import "QHBaseViewController.h"

@interface QHBaseViewController (MBProgressHud)

-(void)showHUD;
-(void)showHUDOnlyTitle:(NSString *)title;
-(void)showHUDWithTitle:(NSString *)title;
-(void)showHUDWithTitle:(NSString *)title hideDelay:(NSTimeInterval)delay;
-(void)showHUDWithMode:(MBProgressHUDMode)mode title:(NSString *)title hideDelay:(NSTimeInterval)delay;
-(void)showHUDInWindowWithMode: (MBProgressHUDMode)mode Title:(NSString *)title hideDelay:(NSTimeInterval)delay;
-(void)showHUDWithProgress:(CGFloat)progress;

-(void)changeHUDTitle:(NSString *)title hideDelay:(NSTimeInterval)delay;
-(void)showHUDInWindowWithTitle:(NSString *)title hideDelay:(NSTimeInterval)delay;
-(void)hideHUD;
-(void)hideWindowHUD;

@end
