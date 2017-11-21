//
//  QHPepperShopCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseSubTitleCell.h"
#import "QHProductModel.h"

typedef NS_ENUM(NSInteger,Purchase) {
    Purchase_Buy,
    Purchase_Remove
};

@interface QHPepperShopCell : QHBaseSubTitleCell

@property (nonatomic, copy) QHParamsCallback callback;
@property (nonatomic, strong) QHProductModel *model;
@property (nonatomic, assign) BOOL isAdd;

@end
