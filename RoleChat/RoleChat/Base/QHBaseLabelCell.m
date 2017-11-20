//
//  QHBaseLabelCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseLabelCell.h"

@implementation QHBaseLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.titleLabel = [UILabel defalutLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    self.arrowView = [[QHTools toolsDefault] addCellRightView:self.contentView point:CGPointZero];
    [self.contentView addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
    self.detailLabel = [UILabel labelWithFont:15 color:RGB939EAE];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowView.mas_left).mas_offset(-10);
    }];
    
    self.rightView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowView.mas_left).mas_offset(-10);
        make.height.width.mas_equalTo(18);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHBaseLabelCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
