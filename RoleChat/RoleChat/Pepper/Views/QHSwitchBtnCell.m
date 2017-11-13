//
//  QHSwitchBtnCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/10.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSwitchBtnCell.h"

@implementation QHSwitchBtnCell 

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
    
    self.switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-61, 0, 48, 24)];
    self.switchBtn.backgroundColor = UIColorFromRGB(0xc5c6c1);
    self.switchBtn.tintColor = UIColorFromRGB(0xc5c6c1);
    self.switchBtn.onTintColor = UIColorFromRGB(0xff4c79);
    self.switchBtn.thumbTintColor = WhiteColor;
    self.switchBtn.layer.cornerRadius = 15.5;
    self.switchBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:_switchBtn];
    [self.switchBtn addTarget:self action:@selector(changeStates:) forControlEvents:(UIControlEventValueChanged)];
    [self.switchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)changeStates: (UISwitch *)sender {
    if (self.callback) {
        self.callback(@(sender.isOn));
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
