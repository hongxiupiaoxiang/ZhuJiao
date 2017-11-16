//
//  QHContactCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHContactCell.h"

@implementation QHContactCell  {
    UIButton *_countBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.headView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(40);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:self.headView cornerRedii:3];
    });
    
    self.nameLabel = [UILabel labelWithFont:15 color:RGB4A5970];
    self.nameLabel.text = @"Pepper";
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_headView.mas_right).mas_offset(15);
    }];
    
    _countBtn = [[UIButton alloc] init];
    _countBtn.layer.cornerRadius = 8;
    [_countBtn setBackgroundColor:UIColorFromRGB(0xfd2f51)];
    [self.contentView addSubview:_countBtn];
    _countBtn.titleLabel.font = FONT(10);
    [_countBtn setTitle:@"11" forState:(UIControlStateNormal)];
    [_countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(16);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(70);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
}


+ (NSString *)reuseIdentifier {
    return @"QHContactCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
