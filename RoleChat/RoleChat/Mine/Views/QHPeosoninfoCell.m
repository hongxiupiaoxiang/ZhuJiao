//
//  QHPeosoninfoCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHPeosoninfoCell.h"

@implementation QHPeosoninfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 25, 40, 40)];
    [self.contentView addSubview:self.headView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = FONT(15);
    self.nameLabel.textColor = RGB4A5970;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_equalTo(25);
        make.left.equalTo(self.headView.mas_right).mas_equalTo(15);
    }];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.font = FONT(14);
    self.phoneLabel.textColor = UIColorFromRGB(0x939eae);
    [self.contentView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(self.nameLabel);
    }];
    
    self.qrView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-51, 38.5, 18, 18)];
    [self.contentView addSubview:self.qrView];
    
    [[QHTools toolsDefault] addCellRightView:self.contentView point:CGPointMake(SCREEN_WIDTH-23, 38.5)];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 90, SCREEN_WIDTH-30, 60)];
    backView.backgroundColor = UIColorFromRGB(0x7989a2);
    [self.contentView addSubview:backView];
    backView.layer.cornerRadius = 3;
    backView.layer.masksToBounds = YES;
    
    UILabel *tradeLabel = [[UILabel alloc] init];
    tradeLabel.text = QHLocalizedString(@"交易地址", nil);
    tradeLabel.font = FONT(15);
    tradeLabel.textColor = WhiteColor;
    [backView addSubview:tradeLabel];
    [tradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(backView).mas_offset(10);
    }];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = FONT(14);
    self.addressLabel.textColor = UIColorFromRGB(0xb6c1d2);
    [backView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tradeLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(tradeLabel);
    }];
    
    UIButton *pasteBtn = [[UIButton alloc] init];
    [pasteBtn setTitle:QHLocalizedString(@"复制", nil) forState:UIControlStateNormal];
    pasteBtn.titleLabel.font = FONT(15);
    [pasteBtn addTarget:self action:@selector(paste) forControlEvents:(UIControlEventTouchUpInside)];
    [pasteBtn setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [pasteBtn setBackgroundColor:UIColorFromRGB(0x95a3b9)];
    [backView addSubview:pasteBtn];
    [pasteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(backView);
        make.width.mas_equalTo(60);
    }];
}

- (void)paste {
    if (self.pasteBlock) {
        self.pasteBlock();
    }
}

+ (NSString *)reuseIdentifier {
    return @"QHPersoninfoCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
