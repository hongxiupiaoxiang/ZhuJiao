//
//  QHBaseChooseCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"

@interface QHBaseChooseCell : QHBaseTableViewCell

@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isChoose;

@end
