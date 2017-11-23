//
//  QHGroupMemberCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/23.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHRealmContactModel.h"

@protocol QHGroupMemberDelegate<NSObject>

- (void)showAllMember: (BOOL)ture;
- (void)tapHeadInView: (UICollectionViewCell *)cell userModel: (QHRealmContactModel *)model;

@end

@interface QHGroupMemberCell : QHBaseTableViewCell

@property (nonatomic, strong) NSArray *members;
@property (nonatomic, assign) id<QHGroupMemberDelegate> delegate;

@end
