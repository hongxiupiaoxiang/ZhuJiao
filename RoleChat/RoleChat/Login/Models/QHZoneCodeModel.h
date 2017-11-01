//
//  QHZoneCodeModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/27.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

typedef NS_ENUM(NSInteger) {
    Group_PhoneCode,
    Group_Country
} Group;

@interface QHZoneCodeModel : QHBaseModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *value;

+ (void)getGlobalParamWithGroup: (Group)group lastUpdateDate: (NSString *)lastUpdate successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

@end
