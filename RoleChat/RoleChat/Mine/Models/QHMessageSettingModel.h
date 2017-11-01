//
//  QHMessageSettingModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHMessageSettingModel : QHBaseModel

+ (void)updateCallStatusWithMessagecall: (NSString *)messagecall voicecall: (NSString *)voicecall shockcall: (NSString *)shockcall successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
