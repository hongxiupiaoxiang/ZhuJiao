//
//  QHProductModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/20.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

typedef NS_ENUM(NSInteger, Product) {
    Product_Expand = 1,
    Product_Sign,
    Product_Image
};

@interface QHProductModel : QHBaseModel

@property (nonatomic, assign) Product product;

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *startCreateAt;
@property (nonatomic, copy) NSString *endCreateAt;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *isbuy;

+ (void)queryProductWithType: (Product)product pageIndex: (NSInteger)pageIndex pageSize: (NSInteger)pageSize successBlock: (RequestCompletedBlock)success failureBlock: (RequestCompletedBlock)failure;

@end
