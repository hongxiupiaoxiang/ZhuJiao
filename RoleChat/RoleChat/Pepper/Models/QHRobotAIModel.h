//
//  QHRobotAIModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/15.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

typedef NS_ENUM(NSInteger,Auth) {
    Auth_Yes = 1,
    Auth_No
};


@interface QHRobotAIModel : QHBaseModel

@property (nonatomic, copy) NSString *robotId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *startCreateAt;
@property (nonatomic, copy) NSString *endCreateAt;

+ (void)openAiWithRef: (NSString *)ref isauth: (Auth)auth successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)queryPepperSetWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

+ (void)updatePepperSetWithNickname: (NSString *)nickname pepperimageid: (NSString *)pepperimageid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)updatePepperSetWithPepperimageid: (NSString *)pepperimageid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)queryPepperImageWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
