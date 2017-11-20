//
//  QHShopExtensionsViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDefaultTableViewController.h"
#import "QHProductModel.h"

@protocol QHShopExtensionDelegate<NSObject>

- (void)addShopmodel: (QHProductModel *)model;
- (void)deleteShopmodel: (QHProductModel *)model;

@end

@interface QHShopExtensionsViewController : QHDefaultTableViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, assign) Product productType;

@end
