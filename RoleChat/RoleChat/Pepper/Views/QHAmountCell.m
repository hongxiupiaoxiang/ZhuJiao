//
//  QHAmountCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAmountCell.h"

@implementation QHAmountCell {
    UILabel *_amountnum;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setAmount:(NSString *)amount {
    _amount = amount;
    NSString *originStr = [NSString stringWithFormat:@"$%@",amount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:originStr];
    [attr addAttribute:NSForegroundColorAttributeName value:MainColor range:[originStr rangeOfString:@"$"]];
    
    _amountnum.attributedText = attr;
}

- (void)setupCellUI {
    UILabel *amountLabel = [UILabel labelWithFont:15 color:RGB52627C];;
    [self.contentView addSubview:amountLabel];
    amountLabel.text = QHLocalizedString(@"总计金额", nil);
    
    _amountnum = [UILabel labelWithFont:18 color:RGB939EAE];
    [self.contentView addSubview:_amountnum];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    [_amountnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-20);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHAmountCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
