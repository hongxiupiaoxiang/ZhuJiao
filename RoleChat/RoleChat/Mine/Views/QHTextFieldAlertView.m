//
//  QHTextFieldAlertView.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHTextFieldAlertView.h"

@implementation QHTextFieldAlertView {
    QHParamsCallback _sureBlock;
    QHNoParamCallback _cancelBlock;
    NSString *_title;
    NSString *_placeholder;
    UIView *_bgView;
    NSString *_content;
    UITextField *_tf;
}

- (instancetype)initWithTitle: (NSString *)title placeholder: (NSString *)placeholder content: (NSString *)content sureBlock: (QHParamsCallback)sure failureBlock: (QHNoParamCallback)failure {
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
    
    CGFloat bgViewWidth = 300.0 / 375 * SCREEN_WIDTH;
    CGFloat bgViewHeight = 0.6 * bgViewWidth;
    
    CGFloat btnWidth = 80.0 / 300.0 * bgViewWidth;
    CGFloat btnHeight = 50.0 / 180 * bgViewHeight;
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgViewWidth, bgViewHeight)];
    _bgView.center = self.center;
    _bgView.backgroundColor = WhiteColor;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(bgViewWidth);
        make.height.mas_equalTo(bgViewHeight);
        make.center.equalTo(self);
    }];

    _bgView.layer.cornerRadius = 5;
    _bgView.layer.shadowRadius = 5;
    _bgView.layer.shadowOpacity = 0.15f;
    _bgView.layer.shadowOffset = CGSizeMake(2, 2);
    _bgView.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
    
    UILabel *titleLabel = [UILabel labelWithFont:17 color:UIColorFromRGB(0x52627c)];
    [_bgView addSubview:titleLabel];
    titleLabel.text = _title;
    
    _tf = [[UITextField alloc] init];
    _tf.placeholder = _placeholder;
    _tf.text = _content;
    _tf.font = FONT(15);
    _tf.textColor = UIColorFromRGB(0x52627c);
    [_bgView addSubview:_tf];
    
    UIView *bottomLine = [[QHTools toolsDefault] addLineView:_bgView :CGRectZero];
    [_bgView addSubview:bottomLine];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:QHLocalizedString(@"取消", nil) forState:(UIControlStateNormal)];
    [_bgView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f6fa)] forState:(UIControlStateHighlighted)];
    [cancelBtn setTitleColor:UIColorFromRGB(0x939eae) forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = FONT(15);
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:QHLocalizedString(@"确定", nil) forState:(UIControlStateNormal)];
    [_bgView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [sureBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf5f6fa)] forState:(UIControlStateHighlighted)];
    [sureBtn setTitleColor:UIColorFromRGB(0xff4c79) forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = FONT(15);
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).mas_offset(15);
        make.top.equalTo(_bgView).mas_offset(20);
    }];
    
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).mas_offset(15);
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(20);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tf.mas_bottom).mas_offset(10);
        make.left.equalTo(_bgView).mas_offset(15);
        make.right.equalTo(_bgView).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView);
        make.bottom.equalTo(_bgView).mas_offset(-10);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sureBtn.mas_left);
        make.bottom.equalTo(sureBtn.mas_bottom);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIKeyboardWillChangeFrameNotification:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)UIKeyboardWillChangeFrameNotification: (NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (_bgView.frame.origin.y+_bgView.height > keyboardFrame.origin.y) {
        CGRect frame = _bgView.frame;
        frame.origin.y += (keyboardFrame.origin.y-_bgView.frame.origin.y-_bgView.height-60);
        _bgView.frame = frame;
    } else {
        _bgView.center = self.center;
    }
    [UIView animateWithDuration:duration animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)sureBtnClick {
    if (_sureBlock)
        _sureBlock(_tf.text);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}

- (void)dismiss {
    if (_cancelBlock) {
        _cancelBlock();
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self removeFromSuperview];
    }
}

- (void)show {
    [Kwindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation {
    _bgView.transform = CGAffineTransformMakeScale(0.20, 0.20);
    [UIView animateWithDuration:0.25f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
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
