//
//  QHOrderListCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewCell.h"
#import "QHOrderModel.h"
#import "QHDrawOrderModel.h"

@interface QHOrderListCell : QHBaseViewCell

@property (nonatomic, strong) QHOrderModel *model;
@property (nonatomic, strong) QHDrawOrderModel *orderModel;

@end
