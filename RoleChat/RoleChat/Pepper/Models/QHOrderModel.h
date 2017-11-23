//
//  QHOrderModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/23.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@class QHOrderDetailModel;
@interface QHOrderDetailModel : QHBaseModel

@property (nonatomic, copy) NSString *orderDetailId;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *productid;
@property (nonatomic, copy) NSString *userAddress;
@property (nonatomic, copy) NSString *groupcar;
@property (nonatomic, copy) NSString *productname;
@property (nonatomic, copy) NSString *producttotal;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *statusnotcannel;

@end

@interface QHOrderModel : QHBaseModel

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *productIds;
@property (nonatomic, copy) NSString *buyUserAddress;
@property (nonatomic, copy) NSString *saleUserAddress;
@property (nonatomic, copy) NSString *orderAmount;
@property (nonatomic, copy) NSString *groupcar;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *usdtotal;
@property (nonatomic, copy) NSString *cnytotal;
// 1.待付款 2.已付款 3.取消
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *paymethod;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *isDoFlag;
@property (nonatomic, copy) NSString *startCreateAt;
@property (nonatomic, copy) NSString *endCreateAt;
@property (nonatomic, copy) NSString *buyUserName;
@property (nonatomic, copy) NSString *saleUserName;
@property (nonatomic, copy) NSArray<QHOrderDetailModel *> *orderDetails;

// 创建订单
+ (void)createOrderWithSuccessBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

// 查询订单
+ (void)queryOrdersWithPageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
