//
//  QHSignView.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSignView.h"

@implementation QHSignView {
    UILabel *_titleLabel;
    UIImageView *_checkView;
    UIView *_bgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_bgView];
    
    _titleLabel = [UILabel labelWithFont:15 color:WhiteColor];
    [self addSubview:_titleLabel];
    
    _checkView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-16, self.height-16, 16, 16)];
    _checkView.image = IMAGENAMED(@"Chat_sign");
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_checkView cornerRedii:8];
    _checkView.hidden = YES;
    [self addSubview:_checkView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:_bgView cornerRedii:20];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.text = self.title;
    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(self.width*0.5, self.height*0.5);
    
    _bgView.backgroundColor = self.color;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    _checkView.hidden = !self.isSelect;
}

- (void)tap {
    if (self.hideCheck == NO)
        _checkView.hidden = !_checkView.isHidden;
    if (self.paramsCallback) {
        self.paramsCallback(self.title);
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
