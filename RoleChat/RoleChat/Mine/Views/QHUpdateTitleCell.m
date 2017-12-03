//
//  QHUpdateTitleCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHUpdateTitleCell.h"

@implementation QHUpdateTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.titleLabel = [UILabel defalutLabel];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.text = @"1.0.0版本更新";
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(26);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    self.detailLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.text = @"发布时间: 2017/12/12 21:12";
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(8);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    UIView *bottomLine = [[QHTools toolsDefault]  addLineView:self.contentView :CGRectZero];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHUpdateTitleCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
