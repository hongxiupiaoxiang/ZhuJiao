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

@end
