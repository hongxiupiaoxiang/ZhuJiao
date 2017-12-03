//
//  QHTextFiledCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHTextFieldCell.h"

#define kTag 666

@implementation QHTextFieldCell

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
    
    self.textFileld = [[UITextField alloc] init];
    self.textFileld.font = FONT(15);
    self.textFileld.tag = kTag;
    [self.contentView addSubview:self.textFileld];
    [self.textFileld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(15);
        make.left.equalTo(self.contentView).mas_offset(100);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHTextFieldCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
