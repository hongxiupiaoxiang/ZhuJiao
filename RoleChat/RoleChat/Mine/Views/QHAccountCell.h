//
//  QHAccountCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHBankModel.h"

@interface QHAccountCell : QHBaseTableViewCell

@property (nonatomic, strong) QHBankModel *model;

@end
