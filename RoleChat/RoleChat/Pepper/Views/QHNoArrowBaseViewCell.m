//
//  QHNoArrowBaseViewCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHNoArrowBaseViewCell.h"

@implementation QHNoArrowBaseViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    [super setupCellUI];
    
    self.titleLabel.font = FONT(14);
    self.titleLabel.textColor = RGB52627C;
    
    self.rightView.hidden = YES;
    self.arrowView.hidden = YES;
    
    self.detailLabel.font = FONT(14);
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowView.mas_left).mas_offset(8);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHNoArrowBaseViewCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
