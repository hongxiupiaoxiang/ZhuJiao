//
//  QHAddFriendCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHRealmContactModel.h"

@interface QHAddFriendCell : QHBaseTableViewCell

@property (nonatomic, strong) QHRealmContactModel *model;
@property (nonatomic, assign) BOOL isAdd;

@end
