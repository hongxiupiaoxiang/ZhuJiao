//
//  QHBuycarModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"
#import "QHProductModel.h"

@interface QHBuycarModel : QHBaseModel

@property (nonatomic, copy) NSString *buycarId;
@property (nonatomic, strong)QHProductModel *product;

@end
