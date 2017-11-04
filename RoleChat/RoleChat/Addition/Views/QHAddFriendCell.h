//
//  QHAddFriendCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHSearchFriendModel.h"

@interface QHAddFriendCell : QHBaseTableViewCell

@property (nonatomic, strong) QHSearchFriendModel *model;
@property (nonatomic, assign) BOOL isAdd;

@end
