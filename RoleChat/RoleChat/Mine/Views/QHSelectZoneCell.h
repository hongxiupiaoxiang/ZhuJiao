//
//  QHSelectZoneCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"

@interface QHSelectZoneCell : QHBaseTableViewCell

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UILabel *zoneLabel;

@end
