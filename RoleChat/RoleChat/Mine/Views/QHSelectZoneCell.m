//
//  QHSelectZoneCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSelectZoneCell.h"

@implementation QHSelectZoneCell {
    UIImageView *_redView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    _redView.hidden = !isSelected;
}

- (void)setupCellUI {
    _redView = [[UIImageView alloc] init];
    _redView.image = IMAGENAMED(@"Personnal_select");
    [self.contentView addSubview:_redView];
    
    self.zoneLabel = [UILabel defalutLabel];
    [self.contentView addSubview:self.zoneLabel];
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.zoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(50);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHSelectZoneCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
