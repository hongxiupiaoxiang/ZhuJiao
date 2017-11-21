//
//  QHAddFriendCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/4.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAddFriendCell.h"

@implementation QHAddFriendCell {
    UIImageView *_headView;
    UILabel *_nameLabel;
    UIImageView *_addView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsAdd:(BOOL)isAdd {
    _isAdd = isAdd;
    if (_isAdd) {
        _addView.image = IMAGENAMED(@"check");
    } else {
        _addView.image = IMAGENAMED(@"normal");
    }
}

- (void)setModel:(QHRealmContactModel *)model {
    _model = model;
    [_headView loadImageWithUrl:model.imgurl placeholder:ICON_IMAGE];
    _nameLabel.text = model.nickname;
}

- (void)setupCellUI {
    _headView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_headView cornerRedii:3];
    [self.contentView addSubview:_headView];
    
    _nameLabel = [UILabel defalutLabel];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_headView.mas_right).mas_offset(15);
    }];
    
    _addView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44, 23, 24, 24)];
    _addView.image = IMAGENAMED(@"normal");
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_addView cornerRedii:3];
    [self.contentView addSubview:_addView];
}

+ (NSString *)reuseIdentifier {
    return @"QHAddFriendCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
