//
//  QHChatOtherCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/17.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatOtherCell.h"

@implementation QHChatOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    [super setupCellUI];
    self.headView.image = ICON_IMAGE;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_right).mas_offset(20);
        make.right.lessThanOrEqualTo(self.contentView).mas_offset(-SCREEN_WIDTH*0.3);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_right).mas_offset(15);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentLabel).insets(UIEdgeInsetsMake(-12.5, -13, -12.5, -10));
        make.bottom.lessThanOrEqualTo(self.contentView).offset(0);
    }];
    self.bgView.image = IMAGENAMED(@"Chat_other");
    self.bgView.userInteractionEnabled = YES;
    
    // 长按手势
    UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.bgView addGestureRecognizer:ges];
    
    self.headView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.headView addGestureRecognizer:tap];
}

- (void)tap: (UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(tapInHeadView:model:)]) {
        [self.delegate tapInHeadView:self model:self.model];
    }
}

- (void)longPress: (UILongPressGestureRecognizer *)ges {
    if ([self.delegate respondsToSelector:@selector(longTapinView:model:ges:)]) {
        [self.delegate longTapinView:self model:self.model ges:ges];
    }
}

+ (NSString *)reuseIdentifier {
    return @"QHChatOtherCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
