//
//  QHAccountCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAccountCell.h"

@implementation QHAccountCell {
    UIImageView *_bgView;
    UIImageView *_logoView;
    UILabel *_cardName;
    UILabel *_phoneNum;
    UILabel *_cardNum;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImgColor:(BgImg)imgColor {
    _imgColor = imgColor;
}

- (void)setupCellUI {
    _bgView = [[UIImageView alloc] init];
    _bgView.image = IMAGENAMED(@"Wallet_green");
    [self.contentView addSubview:_bgView];
    
    _logoView = [[UIImageView alloc] init];
    _logoView.image = IMAGENAMED(@"PSBC");
    [_bgView addSubview:_logoView];
    
    _cardName = [UILabel labelWithFont:15 color:WhiteColor];
    _cardName.text = @"中国邮储银行";
    [_bgView addSubview:_cardName];
    
    _phoneNum = [UILabel labelWithFont:12 color:WhiteColor];
    _phoneNum.text = @"手机尾号3701";
    [_bgView addSubview:_phoneNum];
    
    NSString *text = @"1234567890123456";
    _cardNum = [UILabel labelWithFont:24 color:WhiteColor];
    _cardNum.text = [text getCardStringWithInterval:4];
    [_bgView addSubview:_cardNum];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).mas_offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_offset(110);
    }];
    [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_bgView).mas_offset(15);
        make.width.height.mas_equalTo(40);
    }];
    [_cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoView.mas_right).mas_offset(15);
        make.top.equalTo(_bgView).mas_offset(16);
    }];
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardName.mas_bottom).mas_offset(10);
        make.left.equalTo(_cardName);
    }];
    [_cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneNum.mas_bottom).mas_equalTo(15);
        make.left.equalTo(_bgView).mas_offset(70);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHAccountCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
