//
//  QHBaseTabBarController.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QHBaseTabBar;
@class QHTabbarChildViewController;
@interface QHBaseTabBarController : UITabBarController

@property(nonatomic, strong) QHBaseTabBar* customTabBar;

-(void)addChildViewController:(QHTabbarChildViewController *)childController withTabName:(NSString*)tabName withTabImgPrefix:(NSString*)imgPrefix embedInNavController:(BOOL)embedInNavController;

@end
