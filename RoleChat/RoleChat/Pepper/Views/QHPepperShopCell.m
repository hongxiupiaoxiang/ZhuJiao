//
//  QHPepperShopCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPepperShopCell.h"

@implementation QHPepperShopCell {
    UILabel *_rightLabel;
    UIButton *_rightBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsBuy:(BOOL)isBuy {
    _isBuy = isBuy;
    _rightBtn.selected = isBuy;
}

- (void)setModel:(QHProductModel *)model {
    _model = model;
    [self.leftView loadImageWithUrl:model.imgurl placeholder:IMAGENAMED(@"Shop_audio")];
    self.titleLabel.text = model.name;
    self.detailLabel.text = [NSString stringWithFormat:@"$%@",model.total];
    
    if ([model.isbuy isEqualToString:@"1"]) {
        _rightBtn.hidden = NO;
        _rightLabel.hidden = YES;
    } else {
        _rightBtn.hidden = YES;
        _rightLabel.hidden = NO;
    }
}

- (void)setupCellUI {
    [super setupCellUI];
    
    _rightLabel = [UILabel detailLabel];
    _rightLabel.text = QHLocalizedString(@"已购买", nil);
    [self.contentView addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-20);
    }];
    _rightLabel.hidden = YES;
    
    _rightBtn = [[UIButton alloc] init];
    [_rightBtn setImage:IMAGENAMED(@"Shop_buy") forState:(UIControlStateNormal)];
    [_rightBtn setImage:IMAGENAMED(@"Shop_cancel") forState:(UIControlStateSelected)];
    [self.contentView addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-20);
    }];
    [_rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.leftView.image = IMAGENAMED(@"Shop_audio");
    self.titleLabel.text = @"音频处理";
    self.detailLabel.text = @"$5000.00";
}

- (void)btnClick: (UIButton *)sender {
    if (self.callback) {
        self.callback(@(sender.tag));
    }
    sender.selected = !sender.isSelected;
}

+ (NSString *)reuseIdentifier {
    return @"QHPepperShopCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
