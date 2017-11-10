//
//  QHSubtitleCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseSubTitleCell.h"

@implementation QHBaseSubTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.contentView addSubview:self.leftView];
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.titleLabel = [UILabel labelWithColor:RGB52627C];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(17);
        make.left.equalTo(self.leftView.mas_right).mas_offset(15);
    }];
    
    self.detailLabel = [UILabel detailLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(self.titleLabel);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(70);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHSubtitleCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
