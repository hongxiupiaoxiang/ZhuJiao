//
//  QHBalanceModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/29.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBalanceModel.h"

@implementation QHBalanceModel

+ (void)getUserbalanceWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHBalanceModel sendGETRequestWithAPI:@"user/balance" baseURL:nil params:@{} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
