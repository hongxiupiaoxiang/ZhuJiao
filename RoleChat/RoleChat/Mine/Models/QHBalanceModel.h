//
//  QHBalanceModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/29.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHBalanceModel : QHBaseModel

@property (nonatomic, copy) NSString *cnyBalance;
@property (nonatomic, copy) NSString *cnyBalanceFreeze;
@property (nonatomic, copy) NSString *usdBalance;
@property (nonatomic, copy) NSString *usdBalanceFreeze;

+ (void)getUserbalanceWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
