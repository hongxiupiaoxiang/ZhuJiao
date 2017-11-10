//
//  QHSwitchBtnCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/10.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSwitchBtnCell.h"

@implementation QHSwitchBtnCell {
    UISwitch *_switchBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    self.titleLabel = [UILabel defalutLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-61, 0, 48, 24)];
    _switchBtn.backgroundColor = UIColorFromRGB(0xc5c6c1);
    _switchBtn.tintColor = UIColorFromRGB(0xc5c6c1);
    _switchBtn.onTintColor = UIColorFromRGB(0xff4c79);
    _switchBtn.thumbTintColor = WhiteColor;
    _switchBtn.layer.cornerRadius = 15.5;
    _switchBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:_switchBtn];
    [_switchBtn addTarget:self action:@selector(changeStates:) forControlEvents:(UIControlEventValueChanged)];
    [_switchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)changeStates: (UISwitch *)sender {
    if (sender.isOn) {
        if (self.callBackBlock) {
            self.callBackBlock(@(sender.isOn));
        }
    }
}

+ (NSString *)reuseIdentifier {
    return @"QHSwitchBtnCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
