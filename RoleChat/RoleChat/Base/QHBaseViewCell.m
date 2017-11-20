//
//  QHBaseInfoCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewCell.h"

@implementation QHBaseViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.leftView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = FONT(15);
    self.titleLabel.textColor = UIColorFromRGB(0x4a5970);
    
    self.detailLabel = [UILabel labelWithFont:14 color:UIColorFromRGB(0xc5c6d1)];
    [self.contentView addSubview:self.detailLabel];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).mas_offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(70);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    self.arrowView = [[QHTools toolsDefault] addCellRightView:self.contentView point:CGPointZero];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowView.mas_left).mas_offset(-10);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHBaseInfoCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
