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
// 开通时间
@property (nonatomic, copy) NSString *startCreateAt;
// 结束时间
@property (nonatomic, copy) NSString *endCreateAt;
// 续费时间
@property (nonatomic, copy) NSString *lastTime;
// 1:不自动续费 2:自动续费
@property (nonatomic, copy) NSString *isAuth;

+ (void)openAiWithRef: (NSString *)ref isauth: (Auth)auth successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)queryPepperSetWithSuccessBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

+ (void)updatePepperSetWithNickname: (NSString *)nickname pepperimageid: (NSString *)pepperimageid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)updatePepperSetWithPepperimageid: (NSString *)pepperimageid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)queryPepperImageWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)updatePepperSetWithAuth: (NSString *)auth successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
