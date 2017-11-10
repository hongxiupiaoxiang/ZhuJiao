//
//  QHSubTitleCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSubTitleCell.h"

@implementation QHSubTitleCell {
    UIImageView *_headView;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UIButton *_addBtn;
    UILabel *_addLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QHSearchFriendModel *)model {
    _model = model;
    [_headView loadImageWithUrl:model.imgUrl placeholder:ICON_IMAGE];
    _nameLabel.text = model.name;
    _phoneLabel.text = [NSString stringWithFormat:@"+%@ %@", model.phoneCode, [NSString getPhoneHiddenStringWithPhone:model.phonenumber]];
    _addBtn.hidden = [model.isFriend isEqualToString:@"1"];
    _addLabel.hidden = ![model.isFriend isEqualToString:@"1"];
}

- (void)setupCellUI {
    _headView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [self.contentView addSubview:_headView];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_headView cornerRedii:3];
    
    _nameLabel = [UILabel labelWithFont:15 color:UIColorFromRGB(0x4a5970)];
    [self.contentView addSubview:_nameLabel];
    
    _phoneLabel = [UILabel detailLabel];
    [self.contentView addSubview:_phoneLabel];
    
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, 20, 50, 30)];
    [self.contentView addSubview:_addBtn];
    _addBtn.layer.cornerRadius = 3;
    _addBtn.backgroundColor = UIColorFromRGB(0xff4c79);
    [_addBtn setTitle:QHLocalizedString(@"添加", nil) forState:(UIControlStateNormal)];
    _addBtn.hidden = YES;
    _addBtn.titleLabel.font = FONT(12);
    [_addBtn addTarget:self action:@selector(addFriend) forControlEvents:(UIControlEventTouchUpInside)];
    
    _addLabel = [UILabel detailLabel];
    _addLabel.hidden = YES;
    _addLabel.text = QHLocalizedString(@"已添加", nil);
    [self.contentView addSubview:_addLabel];
    
    [[QHTools toolsDefault] addLineView:self.contentView :CGRectMake(70, 69, SCREEN_WIDTH-85, 1)];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(_headView.mas_right).mas_offset(15);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(_nameLabel);
    }];
    
    [_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
}

- (void)addFriend {
    if (self.addFriendBlock) {
        self.addFriendBlock();
    }
}

+ (NSString *)reuseIdentifier {
    return @"QHSubTitleCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
