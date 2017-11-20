//
//  QHPepperShopCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseSubTitleCell.h"
#import "QHProductModel.h"

@interface QHPepperShopCell : QHBaseSubTitleCell

@property (nonatomic, copy) QHParamsCallback callback;
@property (nonatomic, assign) BOOL isBuy;
@property (nonatomic, strong) QHProductModel *model;

@end
