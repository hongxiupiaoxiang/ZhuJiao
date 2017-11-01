//
//  QHLogoutModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHLogoutModel.h"

@implementation QHLogoutModel

+ (void)logoutWithSuccess: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHBaseModel sendGETRequestWithAPI:@"user/logout" baseURL:nil params:nil hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
