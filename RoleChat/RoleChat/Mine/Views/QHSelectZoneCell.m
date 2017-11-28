//
//  QHSelectZoneCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSelectZoneCell.h"

@implementation QHSelectZoneCell {
    UIImageView *_redView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    
}

+ (NSString *)reuseIdentifier {
    return @"QHSelectZoneCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
