//
//  QHProductIntroduceCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/2.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHProductIntroduceCell.h"

@implementation QHProductIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.contentView.backgroundColor = RGBF5F6FA;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = WhiteColor;
    [self.contentView addSubview:bgView];
    
    UILabel *titleLabel = [UILabel labelWithFont:16 color:RGB52627C];
    titleLabel.text = QHLocalizedString(@"商品介绍", nil);
    [self.contentView addSubview:titleLabel];
    
    self.contentLabel = [UILabel detailLabel];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"placeholder";
    [self.contentView addSubview:self.contentLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(20);
        make.left.equalTo(self.contentView).mas_offset(30);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(30);
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(11);
        make.right.equalTo(self.contentView).mas_offset(-30);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentLabel).with.insets(UIEdgeInsetsMake(-47, -15, -20, -15));
        make.bottom.equalTo(self.contentView);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:bgView cornerRedii:3];
    });
}

+ (NSString *)reuseIdentifier {
    return @"QHProductIntroduceCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
