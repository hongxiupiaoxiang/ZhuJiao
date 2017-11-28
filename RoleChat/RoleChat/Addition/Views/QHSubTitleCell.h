//
//  QHSubTitleCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewCell.h"
#import "QHRealmContactModel.h"

@interface QHSubTitleCell : QHBaseViewCell

@property (nonatomic, strong) QHRealmContactModel *model;
@property (nonatomic, copy) QHNoParamCallback addFriendBlock;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel *addLabel;

@end
