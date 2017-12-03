//
//  QHUMengManager.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHUMengManager.h"

static QHUMengManager *manager;
@implementation QHUMengManager

+(instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QHUMengManager alloc] init];
    });
    
    return manager;
}

-(void)registService {
    NSDictionary* apiKeys = [Util getApiKeyConfigurationDependsToBundleID];
    
    if([apiKeys containsObjectForKey:@"UMengApiKey"] == NO)
        return ;
    
    UMConfigInstance.appKey = [apiKeys valueForKey:@"UMengApiKey"];
    UMConfigInstance.channelId = @"Social";
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];
    return ;
}

@end
