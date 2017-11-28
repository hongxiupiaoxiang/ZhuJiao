//
//  QHBankModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHBankModel : QHBaseModel

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, copy) NSString *verifySmsCode;
@property (nonatomic, copy) NSString *accountNumber;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, copy) NSString *currency;

// 添加银行卡
+ (void)addBankAccountWithPhoneNumber: (NSString *)phoneNumber phoneCode: (NSString *)phoneCode verifySmsCode: (NSString *)verifySmsCode accountNumber: (NSString *)accountNumber bankName: (NSString *)bankName realName: (NSString *)realName accountType: (NSString *)accountType currency: (NSString *)currency successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure;

// 查询银行卡
+ (void)queryBankAccountWithPageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 通过卡号查询银行卡
+ (void)bankNameByNumber: (NSString *)phoneNumber successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
