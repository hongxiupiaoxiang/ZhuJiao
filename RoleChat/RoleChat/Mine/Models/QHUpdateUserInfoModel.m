//
//  QHUpdateUserInfoModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHUpdateUserInfoModel.h"

@implementation QHUpdateUserInfoModel

+ (void)updateUserInfoWithNickName: (NSString *)nickName imgurl: (NSString *)imgurl gender: (NSString *)gender success: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHBaseModel sendRequestWithAPI:@"user/updateUserInfo" baseURL:nil params:@{@"nickName" : nickName, @"imgurl" : imgurl, @"sex" : gender} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
