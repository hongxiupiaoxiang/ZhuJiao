//
//  QHBaseNavigationController.m
//  GoldWorld
//
//  Created by baijiang on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseTabBar.h"
#import "QHBaseTabBarController.h"
#import "QHBaseNavigationController.h"

@interface QHBaseNavigationController ()

@end

@implementation QHBaseNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(void)initialize {
    [super initialize];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:WhiteColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:UIColorFromRGB(0xf0f1f5)]];

    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0f], NSForegroundColorAttributeName : UIColorFromRGB(0x4a5970)}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
