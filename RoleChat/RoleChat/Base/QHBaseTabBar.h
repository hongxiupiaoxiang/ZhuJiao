//
//  QHBaseTabBar.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHTabbarButton : UIButton

@end

@class QHBaseTabBar;
@protocol QHBaseTabBarDelegate <NSObject>

@optional
- (void)tabBar:(QHBaseTabBar *)tabBar didSelectItem:(UITabBarItem *)item;

@end

@interface QHBaseTabbarHostTabbar : UITabBar

@end

@interface QHBaseTabBar : UIView

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, strong) QHTabbarButton* innerButton;
@property(nonatomic, assign) id<QHBaseTabBarDelegate> delegate;

-(void)setTitle:(NSString*)title forItemAtIndex:(NSInteger)index;
-(void)addTabBarItem:(UITabBarItem*)tabBarItem;

@end
