//
//  QHPasswordManageCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPasswordManageCell.h"

@implementation QHPasswordManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.titleLabel = [UILabel labelWithFont:15 color:UIColorFromRGB(0x4a5970)];
    [self.contentView addSubview:self.titleLabel];
    
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.font = FONT(15);
    [self.contentView addSubview:self.inputTextField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(120);
        make.right.equalTo(self.contentView).mas_offset(-15);
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
    return @"QHPasswordManageCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
