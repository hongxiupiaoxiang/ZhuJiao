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
    UIView *_chooseView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        _chooseView.hidden = NO;
    } else {
        _chooseView.hidden = YES;
    }
}

- (void)setModel:(QHBankModel *)model {
    _model = model;
    if ([model.bankName containsString:@"农业银行"]) {
        _cardName.text = QHLocalizedString(@"中国农业银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_green");
        _logoView.image = IMAGENAMED(@"ABC");
    } else if ([model.bankName containsString:@"中国建设银行"]) {
        _cardName.text = QHLocalizedString(@"中国建设银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"CCB");
    } else if ([model.bankName containsString:@"招商银行"]) {
        _cardName.text = QHLocalizedString(@"招商银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"CMBC");
    } else if ([model.bankName containsString:@"中国银行"]) {
        _cardName.text = QHLocalizedString(@"中国银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"BC");
    } else if ([model.bankName containsString:@"工商银行"]) {
        _cardName.text = QHLocalizedString(@"中国工商银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"ICBC");
    } else if ([model.bankName containsString:@"交通银行"]) {
        _cardName.text = QHLocalizedString(@"交通银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"BCM");
    } else if ([model.bankName containsString:@"平安银行"]) {
        _cardName.text = QHLocalizedString(@"平安银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_yellow");
        _logoView.image = IMAGENAMED(@"PABC");
    } else if ([model.bankName containsString:@"浦发银行"]) {
        _cardName.text = QHLocalizedString(@"上海浦发银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"SPDB");
    } else if ([model.bankName containsString:@"邮政储蓄银行"]) {
        _cardName.text = QHLocalizedString(@"中国邮政储蓄银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_green");
        _logoView.image = IMAGENAMED(@"PSBC");
    } else if ([model.bankName containsString:@"华夏银行"]) {
        _cardName.text = QHLocalizedString(@"华夏银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"HXB");
    } else if ([model.bankName containsString:@"杭州银行"]) {
        _cardName.text = QHLocalizedString(@"杭州银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"HZB");
    } else if ([model.bankName containsString:@"大连银行"]) {
        _cardName.text = QHLocalizedString(@"大连银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"DLB");
    } else if ([model.bankName containsString:@"北京银行"])  {
        _cardName.text = QHLocalizedString(@"北京银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"BJB");
    } else if ([model.bankName containsString:@"民生银行"]) {
        _cardName.text = QHLocalizedString(@"中国民生银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"CMBC-1");
    } else if ([model.bankName containsString:@"中信银行"]) {
        _cardName.text = QHLocalizedString(@"中信银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_red");
        _logoView.image = IMAGENAMED(@"CCB-1");
    } else if ([model.bankName containsString:@"光大银行"]) {
        _cardName.text = QHLocalizedString(@"中国光大银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_yellow");
        _logoView.image = IMAGENAMED(@"CEB");
    } else if ([model.bankName containsString:@"兴业银行"]) {
        _cardName.text = QHLocalizedString(@"兴业银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"HSBC");
    } else if ([model.bankName containsString:@"泰隆商业银行"]) {
        _cardName.text = QHLocalizedString(@"浙江泰隆商业银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_yellow");
        _logoView.image = IMAGENAMED(@"ZJB");
    } else if ([model.bankName containsString:@"天津银行"]) {
        _cardName.text = QHLocalizedString(@"天津银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"TJB");
    } else if ([model.bankName containsString:@"发展银行"]) {
        _cardName.text = QHLocalizedString(@"深圳发展银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"SJB");
    } else if ([model.bankName containsString:@"上海银行"]) {
        _cardName.text = QHLocalizedString(@"上海银行储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"SHB");
    } else if ([model.bankName containsString:@"农商银行"]) {
        _cardName.text = QHLocalizedString(@"上海农商银行SRCB储蓄卡", nil);
        _bgView.image = IMAGENAMED(@"Wallet_blue");
        _logoView.image = IMAGENAMED(@"SRCB");
    }
    _cardNum.text = [model.accountNumber getCardStringWithInterval:4];
    _phoneNum.text = [NSString stringWithFormat:QHLocalizedString(@"手机尾号%@", nil),[model.username substringWithRange:NSMakeRange(model.username.length-4, 4)]];
}

- (void)setupCellUI {
    _bgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgView];
    
    _logoView = [[UIImageView alloc] init];
    [_bgView addSubview:_logoView];
    
    _cardName = [UILabel labelWithFont:15 color:WhiteColor];
    [_bgView addSubview:_cardName];
    
    _phoneNum = [UILabel labelWithFont:12 color:WhiteColor];
    [_bgView addSubview:_phoneNum];
    
    _cardNum = [UILabel labelWithFont:24 color:WhiteColor];
    [_bgView addSubview:_cardNum];
    
    _chooseView = [[UIImageView alloc] init];
    [_bgView addSubview:_chooseView];
    _chooseView.hidden = YES;
    
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
    [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView).mas_offset(12);
        make.right.equalTo(_bgView).mas_offset(-15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
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
