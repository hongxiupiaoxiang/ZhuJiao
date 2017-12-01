//
//  QHDrawOrderModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHDrawOrderModel : QHBaseModel

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *userAddress;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *unlineAmount;
@property (nonatomic, copy) NSString *unlineCurrency;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *payMethod;
@property (nonatomic, copy) NSString *remark;
// -1 删除 1:创建订单 2:确认打款 3:订单完成 4:取消订单
@property (nonatomic, copy) NSString *orderState;
@property (nonatomic, copy) NSString *drawAccount;
@property (nonatomic, copy) NSString *bankAccountId;
@property (nonatomic, copy) NSString *drawAccountRealname;
@property (nonatomic, copy) NSString *rule;
@property (nonatomic, copy) NSString *refundPaymentId;
@property (nonatomic, copy) NSString *userNick;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *giveMoneyAt;
@property (nonatomic, copy) NSString *bankAccount;


+ (void)createDrawOrderWithAmount: (NSString *)amount currency: (NSString *)currency bankAmountId: (NSString *)bankAmountId successBlock: (RequestCompletedBlock)success failueBlock: (RequestCompletedBlock)failure;

+ (void)queryDrawOrderWithPageindex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

+ (void)queryDrawOrdersDetailWithId: (NSString *)orderId successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
