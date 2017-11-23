//
//  QHOrderListCell.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHOrderListCell.h"

@implementation QHOrderListCell {
    UILabel *_orderId;
    UILabel *_orderAmount;
    UILabel *_orderTime;
    UILabel *_orderState;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QHOrderModel *)model {
    _model = model;
    _orderId.text = [NSString stringWithFormat:QHLocalizedString(@"订单号: %@", nil), model.orderId];
    _orderTime.text = [NSString timechange:model.createAt withFormat:@"yyyy/MM/dd HH:mm"];
    _orderAmount.text = [NSString stringWithFormat:QHLocalizedString(@"订单总额: %.3f", nil), [model.orderAmount floatValue]];
    if ([model.status isEqualToString:@"1"]) {
        _orderState.textColor = MainColor;
        _orderState.text = QHLocalizedString(@"待付款", nil);
    } else {
        _orderState.textColor = RGB939EAE;
        if ([model.status isEqualToString:@"2"]) {
            _orderState.text = QHLocalizedString(@"已完成", nil);
        } else {
            _orderState.text = QHLocalizedString(@"已取消", nil);
        }
    }
}

- (void)setupCellUI {
    UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 4, 12)];
    redView.backgroundColor = MainColor;
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:redView cornerRedii:1];
    [self.contentView addSubview:redView];
    
    _orderId = [UILabel detailLabel];
    [self.contentView addSubview:_orderId];
    
    _orderAmount = [UILabel labelWithFont:14 color:RGB52627C];
    [self.contentView addSubview:_orderAmount];
    
    _orderTime = [UILabel labelWithFont:12 color:RGB939EAE];
    [self.contentView addSubview:_orderTime];
    
    _orderState = [UILabel labelWithFont:14 color:UIColorFromRGB(0xff4c79)];
    [self.contentView addSubview:_orderState];
    
    [_orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView);
        make.left.equalTo(redView.mas_right).mas_offset(9);
    }];
    
    [_orderAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderId.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.contentView).mas_offset(15);
    }];
    
    [_orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(19);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    [_orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderTime.mas_bottom).mas_offset(11);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
}

+ (NSString *)reuseIdentifier {
    return @"QHOrderListCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
