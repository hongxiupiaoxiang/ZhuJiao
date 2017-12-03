//
//  QHLaunchViewController.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHLaunchViewController.h"
#import "QHLoginViewController.h"

@interface QHLaunchViewController ()

@end

@implementation QHLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.view.backgroundColor = WhiteColor;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame
                            ];
    [self.view addSubview:imgView];
    NSString *imgStr = [NSString stringWithFormat:@"%dx%d",(int)(SCREEN_WIDTH*SCREEN_SCALE),(int)(SCREEN_HEIGHT*SCREEN_SCALE)];
    imgView.image = IMAGENAMED(imgStr);
    if (imgView.image == nil) {
        imgView.image = IMAGENAMED(@"750x1334");
    }
    
    QHLoginViewController *loginViewController = [[QHLoginViewController alloc] init];
    QHBaseNavigationController *navController = [[QHBaseNavigationController alloc] initWithRootViewController:loginViewController];
    
    PerformOnMainThreadDelay(2.0f, {
        [UIView transitionWithView:self.view duration:1.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            imgView.alpha = 0.0f;
            imgView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
        } completion:^(BOOL finished) {
            if(finished) {
                App_Delegate.window.rootViewController = navController;
            }
        }];
    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
