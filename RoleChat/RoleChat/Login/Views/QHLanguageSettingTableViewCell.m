//
//  QHLanguageSettingTableViewCell.m
//  GoldWorld
//
//  Created by zfQiu on 2017/10/23.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHLanguageSettingTableViewCell.h"

@interface QHLanguageSettingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *radioButton;

@end

@implementation QHLanguageSettingTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    _radioButton.selected = selected;
    [super setSelected:selected animated:animated];
}

@end
