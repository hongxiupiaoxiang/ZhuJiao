//
//  QHRobotAIModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/15.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRobotAIModel.h"

@implementation QHRobotAIModel

+ (void)openAiWithRef: (NSString *)ref isauth: (Auth)auth successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHRobotAIModel sendRequestWithAPI:@"account/openAi" baseURL:nil params:@{@"ref" : ref, @"isauth" : @(auth)} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)queryPepperSetWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHRobotAIModel sendRequestWithAPI:@"product/queryPepperSet" baseURL:nil params:@{} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)updatePepperSetWithNickname: (NSString *)nickname pepperimageid: (NSString *)pepperimageid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHRobotAIModel sendRequestWithAPI:@"product/updatePepperSet" baseURL:nil params:@{@"nickname" : nickname, @"pepperimageid" : pepperimageid} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
