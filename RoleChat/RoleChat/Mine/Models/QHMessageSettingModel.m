//
//  QHMessageSettingModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHMessageSettingModel.h"

@implementation QHMessageSettingModel

+ (void)updateCallStatusWithMessagecall: (NSString *)messagecall voicecall: (NSString *)voicecall shockcall: (NSString *)shockcall successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHMessageSettingModel sendRequestWithAPI:@"user/updateCallStatus" baseURL:nil params:@{@"messagecall" : messagecall, @"voicecall" : voicecall, @"shockcall" : shockcall} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
