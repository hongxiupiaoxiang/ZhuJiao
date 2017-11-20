//
//  QHSaleBonusCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/18.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSaleBonusCell.h"

@implementation QHSaleBonusCell {
    UILabel *_idLabel;
    UILabel *_nameLabel;
    UILabel *_bonusLabel;
    UILabel *_timeLabel;
    UIImageView *_headView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    [super setupCellUI];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(15, 14, 4, 12)];
    redView.backgroundColor = UIColorFromRGB(0xff4c79);
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:redView cornerRedii:1];
    [self.contentView addSubview:redView];
    
    [[QHTools toolsDefault] addLineView:self.contentView :CGRectMake(15, 40, SCREEN_WIDTH-30, 1)];
    
    _idLabel = [UILabel detailLabel];
    _idLabel.text = @"订单号: 100000";
    [self.contentView addSubview:_idLabel];
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(redView);
        make.left.equalTo(redView.mas_right).mas_offset(9);
    }];
    
    _timeLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    _timeLabel.text = [NSObject getCurrentDataString:@"yyyy/MM/dd HH:mm"];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(redView);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    _headView = [[UIImageView alloc] init];
    LOADMYIMAGE(_headView);
    [self.contentView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(55);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(40);
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_headView cornerRedii:3];
    });
    
    _nameLabel = [UILabel defalutLabel];
    _nameLabel.text = @"Pepper";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(57);
        make.left.equalTo(_headView.mas_right).mas_offset(15);
    }];
    
    
    _bonusLabel = [UILabel labelWithFont:14 color:UIColorFromRGB(0x52627c)];
    [self.contentView addSubview:_bonusLabel];
    _bonusLabel.attributedText = [NSMutableAttributedString getAttr:[NSString stringWithFormat:QHLocalizedString(@"销售奖励: $%.2f", nil),10000] color:MainColor targetStr:@"$"];
    
    [_bonusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).mas_offset(9);
        make.left.equalTo(_nameLabel);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHSaleBonusCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
