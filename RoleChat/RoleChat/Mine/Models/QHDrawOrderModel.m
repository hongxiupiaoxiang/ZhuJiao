//
//  QHDrawOrderModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDrawOrderModel.h"

@implementation QHDrawOrderModel

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"orderId" : @"id"};
}

+ (void)createDrawOrderWithAmount: (NSString *)amount currency: (NSString *)currency bankAmountId: (NSString *)bankAmountId successBlock: (RequestCompletedBlock)success failueBlock: (RequestCompletedBlock)failure {
    [QHDrawOrderModel sendRequestWithAPI:@"draw/createDrawOrder" baseURL:nil params:@{@"amount" : amount, @"curreny" : currency, @"bankAmountId" : bankAmountId} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)queryDrawOrderWithPageindex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHDrawOrderModel sendPOSTRequestNoHudWithAPI:@"draw/queryDrawOrders" baseURL:nil params:@{@"pageIndex" : @(pageIndex), @"pageSize" : @(pageSize)} beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)queryDrawOrdersDetailWithId: (NSString *)orderId successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHDrawOrderModel sendRequestWithAPI:@"draw/queryDrawOrdersDetail" baseURL:nil params:@{@"id" : orderId} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
