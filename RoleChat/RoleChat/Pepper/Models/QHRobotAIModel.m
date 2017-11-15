//
//  QHRobotAIModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/15.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRobotAIModel.h"

@implementation QHRobotAIModel

+ (void)openAiWithRef: (NSString *)ref successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHRobotAIModel sendRequestWithAPI:@"account/openAi" baseURL:nil params:@{@"ref" : ref} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
