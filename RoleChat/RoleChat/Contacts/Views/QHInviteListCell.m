//
//  QHInviteListCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHInviteListCell.h"

@implementation QHInviteListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMessageModel:(QHRealmFriendMessageModel *)messageModel {
    _messageModel = messageModel;
    if ([messageModel.dealStatus isEqualToString:@"1"]) {
        self.addLabel.text = QHLocalizedString(@"已同意", nil);
        self.addLabel.hidden = NO;
        self.addBtn.hidden = YES;
    } else if ([messageModel.dealStatus isEqualToString:@"2"]) {
        self.addLabel.text = QHLocalizedString(@"已拒绝", nil);
        self.addLabel.hidden = NO;
        self.addBtn.hidden = YES;
    } else {
        self.addLabel.hidden = YES;
        self.addBtn.hidden = NO;
    }
    [self.headView loadImageWithUrl:messageModel.imgurl placeholder:ICON_IMAGE];
    self.nameLabel.text = messageModel.fromNickname;
    self.phoneLabel.text = [NSString stringWithFormat:@"+%@ %@",messageModel.phoneCode,[NSString getPhoneHiddenStringWithPhone:messageModel.phone]];
}

- (void)setupCellUI {
    [super setupCellUI];
    [self.addBtn setTitle:QHLocalizedString(@"同意", nil) forState:(UIControlStateNormal)];
    [self.addBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)btnClick: (UIButton *)sender {
    if (self.agreeCallback) {
        self.agreeCallback(self.messageModel);
    }
}

+ (NSString *)reuseIdentifier {
    return @"QHInviteListCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
