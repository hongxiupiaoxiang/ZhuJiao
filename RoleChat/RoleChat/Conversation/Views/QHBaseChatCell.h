//
//  QHBaseChatCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/17.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"
#import "QHChatModel.h"

@class QHBaseChatCell;

@protocol QHChatDelegate<NSObject>

- (void)longTapinView: (QHBaseChatCell *)cell model: (QHChatModel *)model ges: (UILongPressGestureRecognizer*)ges;

- (void)checkInView: (QHBaseChatCell *)cell model: (QHChatModel *)model;

@end

@interface QHBaseChatCell : QHBaseTableViewCell

@property (nonatomic, strong) QHChatModel *model;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, assign) id<QHChatDelegate> delegate;

@end
