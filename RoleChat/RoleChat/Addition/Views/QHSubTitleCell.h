//
//  QHSubTitleCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewCell.h"
#import "QHSearchFriendModel.h"

@interface QHSubTitleCell : QHBaseViewCell

@property (nonatomic, strong) QHSearchFriendModel *model;
@property (nonatomic, copy) QHNoParamCallback addFriendBlock;

@end
