//
//  QHSubTitleCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSubTitleCell.h"

@implementation QHSubTitleCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QHRealmContactModel *)model {
    _model = model;
    [self.headView loadImageWithUrl:model.imgurl placeholder:ICON_IMAGE];
    self.nameLabel.text = model.nickname;
    self.phoneLabel.text = [NSString stringWithFormat:@"+%@ %@", model.phoneCode, [NSString getPhoneHiddenStringWithPhone:model.phone]];
    self.addBtn.hidden = model.isfriends;
    self.addLabel.hidden = !model.isfriends;
}

- (void)setupCellUI {
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [self.contentView addSubview:self.headView];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:self.headView cornerRedii:3];
    
    self.nameLabel = [UILabel labelWithFont:15 color:UIColorFromRGB(0x4a5970)];
    [self.contentView addSubview:self.nameLabel];
    
    self.phoneLabel = [UILabel detailLabel];
    [self.contentView addSubview:self.phoneLabel];
    
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, 20, 50, 30)];
    [self.contentView addSubview:self.addBtn];
    self.addBtn.layer.cornerRadius = 3;
    self.addBtn.backgroundColor = UIColorFromRGB(0xff4c79);
    [self.addBtn setTitle:QHLocalizedString(@"添加", nil) forState:(UIControlStateNormal)];
    self.addBtn.hidden = YES;
    self.addBtn.titleLabel.font = FONT(12);
    [self.addBtn addTarget:self action:@selector(addFriend) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.addLabel = [UILabel detailLabel];
    self.addLabel.hidden = YES;
    self.addLabel.text = QHLocalizedString(@"已添加", nil);
    [self.contentView addSubview:self.addLabel];
    
    [[QHTools toolsDefault] addLineView:self.contentView :CGRectMake(70, 69, SCREEN_WIDTH-85, 1)];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView);
        make.left.equalTo(self.headView.mas_right).mas_offset(15);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(self.nameLabel);
    }];
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
