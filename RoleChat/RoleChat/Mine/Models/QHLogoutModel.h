//
//  QHLogoutModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHLogoutModel : QHBaseModel

+ (void)logoutWithSuccess: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

@end
