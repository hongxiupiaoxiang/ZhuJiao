//
//  QHEditBaseViewCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHEditBaseViewCell.h"

@implementation QHEditBaseViewCell {
    UIButton *_editBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    _editBtn.hidden = !isEdit;
}

- (void)setupCellUI {
    [super setupCellUI];
    
    _editBtn = [[UIButton alloc] init];
    _editBtn.hidden = YES;
    [self.contentView addSubview:_editBtn];
    [_editBtn addTarget:self action:@selector(edit) forControlEvents:(UIControlEventTouchUpInside)];
    [_editBtn setImage:IMAGENAMED(@"Pepper_edit") forState:(UIControlStateNormal)];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
}

- (void)edit {
    if (self.callback) {
        self.callback(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
