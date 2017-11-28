//
//  QHInviteListCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSubTitleCell.h"
#import "QHRealmFriendMessageModel.h"

@interface QHInviteListCell : QHSubTitleCell

@property (nonatomic, copy) QHParamsCallback agreeCallback;
@property (nonatomic, strong) QHRealmFriendMessageModel *messageModel;

@end
