//
//  QHZoneCodeModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/27.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHZoneCodeModel.h"

@implementation QHZoneCodeModel

+ (void)getGlobalParamWithGroup: (Group)group lastUpdateDate: (NSString *)lastUpdate successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    NSString *groupStr = group == Group_Country ? @"country" : @"phonecode";
    [QHZoneCodeModel sendRequestWithAPI:@"system/globalParam" baseURL:nil params:@{@"lastUpdateDate" : lastUpdate} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
