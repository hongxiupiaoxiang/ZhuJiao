//
//  QHTextFieldAlertView.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHTextFieldAlertView.h"

@implementation QHTextFieldAlertView {
    QHNoParamCallback _sureBlock;
    QHNoParamCallback _cancelBlock;
    NSString *_title;
    NSString *_placeholder;
    UIView *_backView;
    NSString *_content;
}

- (instancetype)initWithTitle: (NSString *)title placeholder: (NSString *)placeholder content: (NSString *)content sureBlock: (QHNoParamCallback)sure failureBlock: (QHNoParamCallback)failure {
    if (self = [super init]) {
        _title = title;
        _placeholder = placeholder;
        _sureBlock = sure;
        _cancelBlock = failure;
        _content = content;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = Kwindow.frame;
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat backViewWidth = 300.0 / 375 * SCREEN_WIDTH;
    CGFloat backViewHeight = 0.6 * backViewWidth;
    
    CGFloat btnWidth = 80.0 / 300.0 * backViewWidth;
    CGFloat btnHeight = 50.0 / 180 * backViewHeight;
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth, backViewHeight)];
    _backView.center = self.center;
    _backView.backgroundColor = WhiteColor;
    [self addSubview:_backView];

    _backView.layer.cornerRadius = 5;
    _backView.layer.shadowRadius = 5;
    _backView.layer.shadowOpacity = 0.15f;
    _backView.layer.shadowOffset = CGSizeMake(2, 2);
    _backView.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
    
    UILabel *titleLabel = [UILabel labelWithFont:17 color:UIColorFromRGB(0x52627c)];
    [_backView addSubview:titleLabel];
    titleLabel.text = _title;
    
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = _placeholder;
    tf.text = _content;
    tf.font = FONT(15);
    tf.textColor = UIColorFromRGB(0x52627c);
    [_backView addSubview:tf];
    
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:_backView :CGRectZero];
    [_backView addSubview:bottomLine];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:QHLocalizedString(@"取消", nil) forState:(UIControlStateNormal)];
    [_backView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f6fa)] forState:(UIControlStateHighlighted)];
    [cancelBtn setTitleColor:UIColorFromRGB(0x939eae) forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = FONT(15);
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:QHLocalizedString(@"确定", nil) forState:(UIControlStateNormal)];
    [_backView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [sureBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f6fa)] forState:(UIControlStateHighlighted)];
    [sureBtn setTitleColor:UIColorFromRGB(0xff4c79) forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = FONT(15);
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.top.equalTo(_backView).mas_offset(20);
    }];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(20);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tf.mas_bottom).mas_offset(10);
        make.left.equalTo(_backView).mas_offset(15);
        make.right.equalTo(_backView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView);
        make.bottom.equalTo(_backView).mas_offset(-10);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sureBtn.mas_left);
        make.bottom.equalTo(sureBtn.mas_bottom);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(btnHeight);
    }];
}

- (void)sureBtnClick {
    if (_sureBlock)
        _sureBlock();
    [self removeFromSuperview];
}

- (void)dismiss {
    if (_cancelBlock) {
        _cancelBlock();
    } else {
        [self removeFromSuperview];
    }
}

- (void)show {
    [Kwindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation {
    _backView.transform = CGAffineTransformMakeScale(0.20, 0.20);
    [UIView animateWithDuration:0.25f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _backView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
