//
//  QHSimplePersoninfoCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"

@interface QHSimplePersoninfoCell : QHBaseTableViewCell

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *genderView;

@end
