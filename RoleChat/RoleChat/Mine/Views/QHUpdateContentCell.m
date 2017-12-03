//
//  QHUpdateContentCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHUpdateContentCell.h"

@implementation QHUpdateContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    UILabel *titleLabel = [UILabel labelWithFont:20 color:RGB52627C];
    [self.contentView addSubview:titleLabel];
    titleLabel.text = QHLocalizedString(@"标题", nil);
    
    UILabel *detailLabel = [UILabel labelWithFont:14 color:RGB939EAE];
    [self.contentView addSubview:detailLabel];
    detailLabel.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"自从用了这个APP,我都可以在深圳买房了" attributes:@{NSParagraphStyleAttributeName : paragraphStyle}];
    detailLabel.attributedText = attr;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(30);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(11);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    UIImageView *contentView = [[UIImageView alloc] init];
    [self.contentView addSubview:contentView];
    contentView.image = IMAGENAMED(@"Rainfall");
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLabel.mas_bottom).mas_offset(23);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(170);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHUpdateContentCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
