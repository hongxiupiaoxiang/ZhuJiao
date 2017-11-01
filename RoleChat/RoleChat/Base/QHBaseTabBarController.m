//
//  QHBaseTabBarController.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseTabBar.h"
#import "QHBaseTabBarController.h"
#import "QHTabbarChildViewController.h"
#import "QHBaseNavigationController.h"

@interface QHBaseTabBarController () <QHBaseTabBarDelegate>

@end

@implementation QHBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QHBaseTabbarHostTabbar* hostTabbar = [[QHBaseTabbarHostTabbar alloc] init];
    [self setValue:hostTabbar forKey:@"tabBar"];
    [hostTabbar addSubview:self.customTabBar];
    return ;
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    _customTabBar.selectedIndex = selectedIndex;
    return ;
}

-(QHBaseTabBar *)customTabBar {
    if(_customTabBar == nil) {
        _customTabBar = [[QHBaseTabBar alloc] initWithFrame:self.tabBar.bounds];
        _customTabBar.delegate = self;
        
        _customTabBar.backgroundColor = [UIColor whiteColor];
//        _customTabBar.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.05f].CGColor;
//        _customTabBar.layer.shadowOffset = CGSizeMake(0, -1);
//        _customTabBar.layer.shadowRadius = 4.0f;
//        _customTabBar.layer.shadowOpacity = 1.0f;
//        _customTabBar.clipsToBounds = NO;
    }
    
    return _customTabBar;
}

-(void)addChildViewController:(QHTabbarChildViewController *)childController withTabName:(NSString *)tabName withTabImgPrefix:(NSString *)imgPrefix embedInNavController:(BOOL)embedInNavController {
    UITabBarItem* tabbarItem = nil;
    if(embedInNavController) {
        childController.navigationItem.title = QHLocalizedString(tabName, nil);
        QHBaseNavigationController* navController = [[QHBaseNavigationController alloc] initWithRootViewController:childController];
//        [navController.navigationBar setShadowImage:[UIImage new]];
        [self addChildViewController:navController];
        
        tabbarItem = navController.tabBarItem;
    }else {
        [self addChildViewController:childController];
        tabbarItem = childController.tabBarItem;
    }
    
    childController.tabTitleKey = tabName;
    tabbarItem.title = QHLocalizedString(tabName, nil);
    tabbarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", imgPrefix]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    tabbarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imgPrefix]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : MainColor,
                                         NSFontAttributeName : FONT(11)} forState:(UIControlStateSelected)];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : BtnClickColor,
                                         NSFontAttributeName : FONT(11)} forState:(UIControlStateNormal)];
    [self.customTabBar addTabBarItem:tabbarItem];
    return ;
}

-(void)viewWillLayoutSubviews {

    CGRect tabbarFrame = CGRectMake(0, SCREEN_HEIGHT - 50.0f, SCREEN_WIDTH, 50.0f);
    for (UIView* subView in self.view.subviews) {
        if([subView isEqual:_customTabBar]) {
            subView.frame = tabbarFrame;
        }else if([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            subView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - tabbarFrame.size.height);
        }
    }

    return [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QHBaseTabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        for (UIViewController* viewController in self.childViewControllers) {
            if([viewController.tabBarItem isEqual:item]) {
                self.selectedViewController = viewController;
                [self.delegate tabBarController:self didSelectViewController:viewController];
                break;
            }
        }
    }
    return ;
}

@end
