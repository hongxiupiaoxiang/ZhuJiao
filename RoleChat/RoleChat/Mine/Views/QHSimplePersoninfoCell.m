//
//  QHSimplePersoninfoCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSimplePersoninfoCell.h"

@implementation QHSimplePersoninfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 100, 100)];
    [self.contentView addSubview:self.headView];
    
    self.nameLabel = [UILabel defalutLabel];
    [self.contentView addSubview:self.nameLabel];
    
    self.phoneLabel = [UILabel detailLabel];
    [self.contentView addSubview:self.phoneLabel];
    
    self.genderView = [[UIButton alloc] init];
    [self.contentView addSubview:self.genderView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(30);
        make.left.equalTo(self.headView.mas_right).mas_offset(25);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(15);
        make.left.equalTo(self.headView.mas_right).mas_offset(25);
    }];
    
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).mas_offset(8);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    self.genderView.userInteractionEnabled = NO;
}

+ (NSString *)reuseIdentifier {
    return @"QHSimplePersonInfoCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
