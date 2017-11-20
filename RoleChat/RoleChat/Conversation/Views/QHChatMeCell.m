//
//  QHChatMeCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/17.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatMeCell.h"

@implementation QHChatMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    [super setupCellUI];
    [self.headView loadImageWithUrl:[QHPersonalInfo sharedInstance].userInfo.imgurl placeholder:ICON_IMAGE];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView.mas_left).mas_offset(-20);
        make.left.greaterThanOrEqualTo(self.contentView).mas_offset(SCREEN_WIDTH*0.3);
    }];
    self.contentLabel.textColor = WhiteColor;
    self.bgView.image = IMAGENAMED(@"Chat_own");
}

+ (NSString *)reuseIdentifier {
    return @"QHChatMeCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
