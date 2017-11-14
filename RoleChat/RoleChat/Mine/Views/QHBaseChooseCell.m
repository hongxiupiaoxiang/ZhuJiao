//
//  QHBaseChooseCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseChooseCell.h"

@implementation QHBaseChooseCell {
    UIButton *_checkBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsChoose:(BOOL)isChoose {
    _isChoose = isChoose;
    _checkBtn.selected = isChoose;
}

- (void)setupCellUI {
    self.leftView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftView];
    
    self.titleLabel = [UILabel labelWithFont:15 color:RGB52627C];
    [self.contentView addSubview:self.titleLabel];
    
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).mas_offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    _checkBtn = [[UIButton alloc] init];
    [_checkBtn setImage:IMAGENAMED(@"normal") forState:(UIControlStateNormal)];
    [_checkBtn setImage:IMAGENAMED(@"check") forState:(UIControlStateSelected)];
    [self.contentView addSubview:_checkBtn];
    _checkBtn.userInteractionEnabled = NO;
    
    [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-20);
        make.width.height.mas_equalTo(24);
    }];
    
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(70);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHBaseChooseCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
