//
//  QHConversationCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHRealmMListModel.h"

@interface QHConversationCell : QHBaseTableViewCell

@property (nonatomic, strong) QHRealmMListModel *model;

@end
