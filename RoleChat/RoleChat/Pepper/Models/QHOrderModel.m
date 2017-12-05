//
//  QHOrderModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/23.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHOrderModel.h"

@implementation QHOrderDetailModel

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"orderDetailId" : @"id"};
}

@end

@implementation QHOrderModel

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"orderId" : @"id"};
}

+ (void)createOrderWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHOrderModel sendRequestWithAPI:@"order/createOrder" baseURL:nil params:@{} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)queryOrdersWithPageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHOrderModel sendPOSTRequestNoHudWithAPI:@"order/queryOrders" baseURL:nil params:@{@"pageIndex" : @(pageIndex), @"pageSize" : @(pageSize)} beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)wechatOrderWithOrderid: (NSString *)orderid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHOrderModel sendRequestWithAPI:@"wechat/wechatOrder" baseURL:nil params:@{@"orderid" : orderid, @"isIos" : @"1"} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)cancelOrderWithOrderid: (NSString *)orderid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHOrderModel sendRequestWithAPI:@"order/cannelOrder" baseURL:nil params:@{@"orderid" : orderid} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

+ (void)bankPayOrderWithOrderid: (NSString *)orderid txnAmt: (NSString *)txnAmt successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHOrderModel sendRequestWithAPI:@"bankpay/bankPayOrder" baseURL:nil params:@{@"orderId" : orderid, @"txnAmt" : txnAmt} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
