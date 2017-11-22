//
//  QHRobotAIModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/15.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHRobotAIModel : QHBaseModel

+ (void)openAiWithRef: (NSString *)ref successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;


+ (void)queryPepperSetWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

+ (void)updatePepperSetWithNickname: (NSString *)nickname pepperimageid: (NSString *)pepperimageid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
