//
//  QHBaseChatCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/17.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseChatCell.h"

@implementation QHBaseChatCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QHChatModel *)model {
    _model = model;
    self.timeLabel.hidden = !model.showTime;
    self.timeLabel.text = [NSObject distanceTimeWithBeforeTime:[[[model.time componentsSeparatedByString:@":"] lastObject] doubleValue]];
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(model.showTime ? 64: 25);
    }];
    
    self.nameLabel.hidden = !model.showNickname;
    self.nameLabel.text = @"Pepper";
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(model.showNickname ? 35 : 12.5);
    }];
    self.contentLabel.text = model.content;
}

- (void)setupCellUI {
    [super setupCellUI];
    
    self.timeLabel = [UILabel labelWithFont:12 color:RGB939EAE];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.text = @"2017/10/20 09:24";
    self.timeLabel.hidden = YES;
    
    self.headView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headView];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(25);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(25);
        make.width.height.mas_equalTo(40);
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_headView cornerRedii:3];
    });
    
    self.nameLabel = [UILabel detailLabel];
    self.nameLabel.hidden = YES;
    [self.contentView addSubview:_nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView);
    }];
    
    self.bgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgView];
    
    self.contentLabel = [UILabel labelWithFont:15 color:RGB52627C];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(12.5);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentLabel).insets(UIEdgeInsetsMake(-12.5, -10, -12.5, -13));
        make.bottom.lessThanOrEqualTo(self.contentView).offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
