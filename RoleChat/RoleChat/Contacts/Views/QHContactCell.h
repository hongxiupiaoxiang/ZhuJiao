//
//  QHContactCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHRealmContactModel.h"

/**
 Cell类型枚举

 - ContentType_Default: 联系人
 - ContentType_Invite: 新的邀请
 - ContentType_Group: 群聊
 */
typedef NS_ENUM(NSInteger,ContentType) {
    ContentType_Default,
    ContentType_Invite,
    ContentType_Group
};

@interface QHContactCell : QHBaseTableViewCell

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
/**
 通讯录Cell类型
 */
@property (nonatomic, assign) ContentType contentType;

@property (nonatomic, strong) QHRealmContactModel *contactModel;

@end
