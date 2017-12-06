//
//  QHConversationCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHConversationCell.h"
#import "QHRealmContactModel.h"

@implementation QHConversationCell {
    UIImageView *_headView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UILabel *_timeLabel;
    UIButton *_countBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QHRealmMListModel *)model {
    _model = model;
    QHRealmContactModel *contactModel = [QHRealmContactModel objectInRealm:[QHRealmDatabaseManager currentRealm] forPrimaryKey:model.rid];
    if (contactModel) {
        _nameLabel.text = contactModel.nickname;
    } else {
        _nameLabel.text = model.u.username;
    }
    _contentLabel.text = model.msg;
    [_countBtn setTitle:[NSString stringWithFormat:@"%ld",model.unreadcount] forState:(UIControlStateNormal)];
    _countBtn.hidden = !model.unreadcount;
    _timeLabel.text = [NSObject timechange:model.ts.$date withFormat:@"yyyy/MM/dd HH:mm"];
}

- (void)setupCellUI {
    _headView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headView];
    _headView.image = IMAGENAMED(@"pepper_normal");
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(40);
        make.left.equalTo(self.contentView).mas_offset(15);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_headView cornerRedii:3];
    });
    
    _nameLabel = [UILabel labelWithFont:15 color:RGB4A5970];
    _nameLabel.text = @"Pepper";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(20);
        make.left.equalTo(_headView.mas_right).mas_offset(15);
    }];
    
    _contentLabel = [UILabel detailLabel];
    _contentLabel.text = @"Pepper";
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).mas_offset(8);
        make.left.equalTo(_nameLabel);
    }];
    
    _timeLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    _timeLabel.text = @"2017/1/31";
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(20);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    _countBtn = [[UIButton alloc] init];
    _countBtn.layer.cornerRadius = 8;
    [_countBtn setBackgroundColor:UIColorFromRGB(0xfd2f51)];
    [self.contentView addSubview:_countBtn];
    _countBtn.titleLabel.font = FONT(10);
    [_countBtn setTitle:@"11" forState:(UIControlStateNormal)];
    [_countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.top.equalTo(_contentLabel);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(16);
    }];
    
    UIView *bottomView = [[QHTools toolsDefault] addLineView:self.contentView :CGRectZero];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(70);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHConversationCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
