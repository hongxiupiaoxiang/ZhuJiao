//
//  QHShopCarViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDefaultTableViewController.h"
#import "QHProductModel.h"

@protocol QHShopCarDelegate<NSObject>

- (void)deleteCarShop;
- (void)deleteProduct: (QHProductModel *)model;

@end

@interface QHShopCarViewController : QHDefaultTableViewController

@property (nonatomic, strong) NSMutableArray<QHProductModel *> *modelArrM;
@property (nonatomic, assign) id<QHShopCarDelegate> delegate;

@end
