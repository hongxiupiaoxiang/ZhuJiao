//
//  QHBaseSubCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseSubCell.h"

@implementation QHBaseSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.titleLabel = [UILabel defalutLabel];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    [self.contentView addSubview:self.contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(18);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(9);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    UIImageView *arrowView = [[QHTools toolsDefault] addCellRightView:self.contentView point:CGPointZero];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHBaseSubCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
