//
//  QHSwitchBtnCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/10.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"

@interface QHSwitchBtnCell : QHBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) QHParamsCallback callback;
@property (nonatomic, strong) UISwitch *switchBtn;

@end
