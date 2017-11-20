//
//  QHChattipCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/20.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChattipCell.h"

@implementation QHChattipCell {
    UILabel *_tipLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColorFromRGB(0xf0f1f5);
    [self.contentView addSubview:bgView];
    
    _tipLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    _tipLabel.text = QHLocalizedString(@"你撤回了一条消息", nil);
    [self.contentView addSubview:_tipLabel];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tipLabel).insets(UIEdgeInsetsMake(-5, -15, -5, -15));
        make.bottom.lessThanOrEqualTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).mas_offset(25);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:bgView cornerRedii:3];
    });
}

+ (NSString *)reuseIdentifier {
    return @"QHChattipCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
