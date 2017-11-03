//
//  QHMainTabBarViewController.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHChatAlertView.h"
#import "QHConversationViewController.h"
#import "QHContactsViewController.h"
#import "QHPepperViewController.h"
#import "QHMineViewController.h"
#import "UIApplication+QHCheckUpdate.h"
#import "QHLoginViewController.h"
#import "QHAppUpdateModel.h"
#import "QHBaseTabBar.h"
#import "QHTabbarChildViewController.h"
#import "Util.h"
#import "UIApplication+QHLogout.h"
#import "QHMainTabBarViewController.h"
#import "QHPersonalInfo.h"
#import "QHRealmLoginModel.h"

@interface QHMainTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation QHMainTabBarViewController {
    NSInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkForUpdate];
    
    [self initChildViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:kLanguageChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLogin:) name:kUserMustBeReloginNotification object:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return ;
}

-(void)checkForUpdate {
    WeakSelf;
//    [[UIApplication sharedApplication] checkUpdateWithSuccess:^(NSURLSessionTask *task, id responseObject) {
//        App_Delegate.updateModel = [QHAppUpdateModel modelWithJSON:responseObject[@"data"]];
//        DLog(@"%@", App_Delegate.updateModel);
//        [weakSelf askForUpdate];
//        return ;
//    } Failure:^(NSURLSessionTask *task, NSError *error) {
//        return ;
//    }];
    return ;
}

-(void)gotoLogin:(NSNotification*)notification {
    WeakSelf
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSString* resultCode = notification.userInfo[@"resultCode"];
    
    [[QHSocketManager manager] unsubSciptionsWithCompletion:^(id response) {
        [[QHSocketManager manager] authLogoutWithCompletion:^(id response) {
            NSLog(@"退出登录");
        }];
    }];
    
    [weakSelf logoutInternal:resultCode msg:notification.userInfo[@"msg"]];
}

-(void)logoutInternal:(NSString*)resultCode msg:(NSString*)msg {
    
    QHLoginViewController* loginController = [[QHLoginViewController alloc] init];
    [QHPersonalInfo clearInfo];
    
    RLMResults* result = [QHRealmLoginModel allObjectsInRealm:[QHRealmDatabaseManager defaultRealm]];
    if(result.count != 0 && result != nil) {
        [[QHRealmDatabaseManager defaultRealm] transactionWithBlock:^{
            [[QHRealmDatabaseManager defaultRealm] deleteObjects:result];
        }];
    }
    
    [UIView transitionFromView:self.view toView:loginController.view duration:kDefaultAnimationIntervalKey options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        App_Delegate.window.rootViewController = [[QHBaseNavigationController alloc] initWithRootViewController:loginController];
        if([resultCode isEqualToString:kNotLoggedinMsg] || [resultCode isEqualToString:kTokenNotFoundMsg]) {
            [loginController showHUDOnlyTitle:msg];
        }
    }];
}

#pragma mark - Version Update
-(void)askForUpdate {
    NSInteger currentVersion = [[[Util getApplicationVersion] stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    NSInteger newVersion = [[App_Delegate.updateModel.version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    
    if(currentVersion < newVersion) {
        
        QHChatAlertView* alertView = [[QHChatAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:QHLocalizedString(@"有新的版本(%@)", nil), App_Delegate.updateModel.version] sureBtn:QHLocalizedString(@"立即更新", nil) cancleBtn:(App_Delegate.updateModel.mustUpdate == 0 ? QHLocalizedString(@"稍后再说", nil) : nil)];
        alertView.sureBlock = ^(QHChatAlertView* alertView) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:App_Delegate.updateModel.url]];
        };
        
        if(App_Delegate.updateModel.mustUpdate == YES)
            alertView.alertViewShouldAlwaysShown = YES;
        [alertView showChatAlertView];
    }
    return ;
}

-(void)initChildViewController {
    self.delegate = self;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    QHConversationViewController *conversationVC = [[QHConversationViewController alloc] init];
    QHContactsViewController *contactsVC = [[QHContactsViewController alloc] init];
    QHPepperViewController *pepperVC = [[QHPepperViewController alloc] init];
    QHMineViewController *mineVC = [[QHMineViewController alloc] init];
    
    [self addChildViewController:conversationVC withTabName:@"会话" withTabImgPrefix:@"chat" embedInNavController:YES];
    [self addChildViewController:contactsVC withTabName:@"通讯录" withTabImgPrefix:@"contact" embedInNavController:YES];
    [self addChildViewController:pepperVC withTabName:@"pepper" withTabImgPrefix:@"pepper" embedInNavController:YES];
    [self addChildViewController:mineVC withTabName:@"我的" withTabImgPrefix:@"mine" embedInNavController:YES];
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Language Changed
-(void)languageChanged:(NSNotification*)notification {
    for(int i = 0; i != self.childViewControllers.count; ++i) {
        QHTabbarChildViewController* controller = [((QHBaseNavigationController*)[self.childViewControllers objectAtIndex:i]).viewControllers objectAtIndex:0];
        [self.customTabBar setTitle:QHLocalizedString(controller.tabTitleKey, nil) forItemAtIndex:i];
        [controller setupUI];
    }
    
    return ;
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    return ;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
