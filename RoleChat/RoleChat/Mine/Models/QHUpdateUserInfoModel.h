//
//  QHUpdateUserInfoModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHUpdateUserInfoModel : QHBaseModel

+ (void)updateUserInfoWithNickName: (NSString *)nickName imgurl: (NSString *)imgurl gender: (NSString *)gender success: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

+ (void)updateUserInfoWithCountry: (NSString *)country success: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

@end
