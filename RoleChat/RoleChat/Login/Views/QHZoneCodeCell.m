//
//  QHZoneCodeCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/27.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHZoneCodeCell.h"

@implementation QHZoneCodeCell {
    UIImageView *_selectedView;
    UILabel *_codeLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)reuseIdentifier {
    return @"QHZoneCodeCell";
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (_isSelect) {
        _selectedView.image = IMAGENAMED(@"radio_selected");
    } else {
        _selectedView.image = IMAGENAMED(@"radio_unselected");
    }
}

- (void)setModel:(QHZoneCodeModel *)model {
    _model = model;
    _codeLabel.text = [NSString stringWithFormat:@"+%@",model.code];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 28, 15, 15)];
    _selectedView.image = IMAGENAMED(@"radio_unselected");
    [self.contentView addSubview:_selectedView];
    
    _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 16)];
    _codeLabel.text = @"+86";
    _codeLabel.centerY = _selectedView.centerY;
    _codeLabel.font = FONT(15);
    [self.contentView addSubview:_codeLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
