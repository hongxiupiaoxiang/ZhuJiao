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

- (void)setupCellUI {
    [super setupCellUI];
    UIButton *addBtn = self.contentView.subviews[3];
    addBtn.hidden = NO;
    [addBtn setTitle:QHLocalizedString(@"同意", nil) forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)btnClick: (UIButton *)sender {
    sender.hidden = YES;
    UILabel *label = self.contentView.subviews[4];
    label.hidden = NO;
}

+ (NSString *)reuseIdentifier {
    return @"QHInviteListCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
