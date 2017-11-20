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

+ (void)queryProductWithType: (Product)product pageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure {
    [QHProductModel sendPOSTRequestNoHudWithAPI:@"product/queryProduct" baseURL:nil params:@{@"type" : @(product), @"pageIndex" : @(pageIndex), @"pageSize" : @(pageSize)} beforeRequest:nil successBlock:success failedBlock:failure];
}

@end
