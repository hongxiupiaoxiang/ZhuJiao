//
//  QHBankModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBankModel.h"

@implementation QHBankModel

// 添加银行卡
+ (void)addBankAccountWithPhoneNumber: (NSString *)phoneNumber phoneCode: (NSString *)phoneCode verifySmsCode: (NSString *)verifySmsCode accountNumber: (NSString *)accountNumber bankName: (NSString *)bankName realName: (NSString *)realName accountType: (NSString *)accountType currency: (NSString *)currency successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHBankModel sendRequestWithAPI:@"account/addBankAccount" baseURL:nil params:@{@"phoneNumber" : phoneNumber, @"phoneCode" : phoneCode, @"verifySmsCode" : verifySmsCode, @"accountNumber" : accountNumber, @"bankName" : bankName, @"realName" : realName, @"accountType" : accountType, @"currency" : currency} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 查询银行卡
+ (void)queryBankAccountWithPageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHBankModel sendRequestWithAPI:@"account/queryBankAccount" baseURL:nil params:@{@"pageIndex" : @(pageIndex), @"pageSize" : @(pageSize)} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 通过卡号查询银行卡
+ (void)bankNameByNumber: (NSString *)phoneNumber successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHBankModel sendRequestWithAPI:@"account/bankNameByNumber" baseURL:nil params:@{@"phoneNumber" : phoneNumber} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
