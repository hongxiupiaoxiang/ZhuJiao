//
//  AppDelegate.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "AppDelegate.h"
#import "QHLaunchViewController.h"
#import "QHLoginViewController.h"
#import "QHBaseNavigationController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "QHUMengManager.h"

#import "QHRealmContactModel.h"

// 第三方登录
#import "WXApi.h"

@interface AppDelegate ()<WXApiDelegate, QQApiInterfaceDelegate>

@property (nonatomic, assign) UIBackgroundTaskIdentifier backIden;
@property (nonatomic, assign) BOOL enterBackground;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:WEIXIN_APPID];

    QHLaunchViewController *launchVC = [[QHLaunchViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    
    [[QHUMengManager manager] registService];
    // Override point for customization after application launch.
    return YES;
    
}
    
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
    [QQApiInterface handleOpenURL:url delegate:self];
    [TencentOAuth HandleOpenURL:url];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.backIden != UIBackgroundTaskInvalid) {
                [[UIApplication sharedApplication] endBackgroundTask:self.backIden];
                self.backIden = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    self.enterBackground = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger i = 0;
        while (self.enterBackground) {
            NSLog(@"%ld",i++);
            sleep(2);
        }
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    self.enterBackground = NO;
    if (self.backIden != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.backIden];
        self.backIden = UIBackgroundTaskInvalid;
    }
    if (!socketIsConnected) {
        [[QHSocketManager manager] connectServerWithUrlStr:IM_BASEURL connect:^{
            [[QHSocketManager manager] configVersion:@"1"];
            if ([QHPersonalInfo sharedInstance].alreadLogin) {
                [self configSub];
            }
        } failure:^(NSError *error) {
            [[QHSocketManager manager] reconnect];
        }];
    }
}

- (void)configSub {
    [[QHSocketManager manager] authLoginWithCompletion:^(id response) {
        NSString *authId = response[@"result"][@"id"];
        [[QHSocketManager manager] initPublishWithCompletion:^(id response) {
            [[QHSocketManager manager] authoIdWithId:authId Completion:nil failure:nil];
        } failure:nil];
        [[QHSocketManager manager] getFriendListCompletion:^(id response) {
            NSArray *modelArr = [NSArray modelArrayWithClass:[QHRealmContactModel class] json:response[@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [QHRealmDatabaseManager updateRecords:modelArr];
            });
        } failure:nil];
    } failure:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(NSString *)uuidString {
    if(_uuidString != nil && _uuidString.length != 0 && [_uuidString isEqual:[NSNull null]] == NO)
        return _uuidString;
    NSString* uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    _uuidString = uuid;
    return uuid;
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_LOGIN object:@{@"code" : temp.code}];
    }
}

@end
