//
//  QHZoneCodeCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/27.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHZoneCodeModel.h"

@interface QHZoneCodeCell : QHBaseTableViewCell

@property (nonatomic, strong) QHZoneCodeModel *model;
@property (nonatomic, assign) BOOL isSelect;

+ (NSString *)reuseIdentifier;

@end
