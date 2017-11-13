//
//  QHCarButton.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHCarButton.h"

@implementation QHCarButton {
    UIButton *_rightBtn;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = CGRectMake(0, 0, 35, 32);
    [self setImage:IMAGENAMED(@"Shop_car") forState:(UIControlStateNormal)];
    
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-14, 0, 14, 14)];
    _rightBtn.backgroundColor = MainColor;
    _rightBtn.layer.cornerRadius = 7;
    _rightBtn.clipsToBounds = YES;
    [_rightBtn setTitle:@"0" forState:(UIControlStateNormal)];
    _rightBtn.hidden = YES;
    _rightBtn.titleLabel.font = FONT(9);
    [self addSubview:_rightBtn];
}

- (void)setShopCount:(NSInteger)shopCount {
    _shopCount = shopCount;
    if (shopCount == 0) {
        _rightBtn.hidden = YES;
    } else {
        _rightBtn.hidden = NO;
        [_rightBtn setTitle:[NSString stringWithFormat:@"%ld",shopCount] forState:(UIControlStateNormal)];
    }
}

- (void)addShopCount {
    self.shopCount++;
}

- (void)decreaseCount {
    if (self.shopCount > 0) {
        self.shopCount--;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
