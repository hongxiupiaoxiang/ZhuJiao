//
//  QHProductModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/20.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHProductModel.h"

@implementation QHProductModel

+(NSDictionary*)modelCustomPropertyMapper {
    return @{@"productId" : @"id"};
}

// 查询商品
+ (void)queryProductWithType: (Product)product pageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHProductModel sendPOSTRequestNoHudWithAPI:@"product/queryProduct" baseURL:nil params:@{@"type" : @(product), @"pageIndex" : @(pageIndex), @"pageSize" : @(pageSize)} beforeRequest:nil successBlock:success failedBlock:failure];
}

// 添加购物车
+ (void)addBuyCarWithProductid: (NSString *)productid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHProductModel sendPOSTRequestNoHudWithAPI:@"product/addBuyCar" baseURL:nil params:@{@"productid" : productid} beforeRequest:nil successBlock:success failedBlock:failure];
}

// 删除购物车
+ (void)deleteBuyCarWithProductid: (NSString *)productid successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHProductModel sendRequestWithAPI:@"product/deleteBuyCar" baseURL:nil params:@{@"productid" : productid} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 清空购物车
+ (void)clearBuyCarWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHProductModel sendRequestWithAPI:@"product/clearBuyCar" baseURL:nil params:@{} hudTitle:nil beforeRequest:nil successBlock:success failedBlock:failure];
}

// 查询购物车
+ (void)queryBuyCarWithPageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    [QHProductModel sendPOSTRequestNoHudWithAPI:@"product/queryBuyCar" baseURL:nil params:@{@"pageIndex" : @(pageIndex), @"pageSize" : @(pageSize)}  beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
