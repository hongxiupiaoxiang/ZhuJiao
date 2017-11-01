//
//  QHUserInfo.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/13.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "NSObject+YYModel.h"
#import "QHPersonalInfo.h"

static QHPersonalInfo* personalInfo;
@implementation QHPersonalInfo

+(instancetype)sharedInstance {
    
    if(personalInfo == nil)
        @synchronized (self) {
            personalInfo = [[QHPersonalInfo alloc] init];
        }
    
    return personalInfo;
}

-(BOOL)alreadLogin {
    return _appLoginToken.length != 0;
}

+(void)clearInfo {
    personalInfo.userInfo = nil;
    personalInfo.appLoginToken = nil;
    personalInfo.alreadLogin = NO;
    
    return ;
}

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"userInfo" : @"user"};
}

@end


@implementation QHUserInfo

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"userID" : @"id"};
}

@end
