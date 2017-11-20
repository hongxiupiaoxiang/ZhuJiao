//
//  QHChatOtherMoreCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/20.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatOtherMoreCell.h"

@implementation QHChatOtherMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCheck:(BOOL)check {
    _check = check;
    self.operateBtn.selected = check;
}

- (void)setupCellUI {
    [super setupCellUI];
    
    //操作按钮
    self.operateBtn = [[UIButton alloc] init];
    [self.operateBtn setImage:IMAGENAMED(@"Auto_unselected") forState:(UIControlStateNormal)];
    [self.operateBtn setImage:IMAGENAMED(@"Auto_selected") forState:(UIControlStateSelected)];
    [self.operateBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.operateBtn];
    [self.operateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.headView);
    }];
    
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(50);
    }];
}

- (void)btnClick: (UIButton *)sender {
    sender.selected = !sender.isSelected;
    if ([self.delegate respondsToSelector:@selector(checkInView:model:)]) {
        [self.delegate checkInView:self model:self.model];
    }
}

+ (NSString *)reuseIdentifier {
    return @"QHChatOtherMoreCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
