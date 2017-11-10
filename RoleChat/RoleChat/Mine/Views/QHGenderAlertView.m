//
//  QHGenderAlertView.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHGenderAlertView.h"

#define BTN_TAG 666

@implementation QHGenderAlertView {
    UIView *_backView;
    NSString *_gender;
    QHParamsCallback _callBack;
}

- (instancetype)initWithGender: (NSString *)gender callbackBlock: (QHParamsCallback)callBack {
    if (self = [super init]) {
        _callBack = callBack;
        _gender = gender;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = Kwindow.frame;
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat backViewWidth = 300.0 / 375 * SCREEN_WIDTH;
    CGFloat backViewHeight = 250.0 / 300 * backViewWidth;
    
    CGFloat rowHeight = 56.0 / 250 * backViewHeight;
    
    CGFloat btnWidth = 80.0 / 300.0 * backViewWidth;
    CGFloat btnHeight = 50.0 / 250 * backViewHeight;
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth, backViewHeight)];
    _backView.backgroundColor = WhiteColor;
    [self addSubview:_backView];
    _backView.center = self.center;
    _backView.layer.cornerRadius = 5;
    _backView.layer.shadowRadius = 5;
    _backView.layer.shadowOpacity = 0.15f;
    _backView.layer.shadowOffset = CGSizeMake(2, 2);
    _backView.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
    
    UILabel *genderLabel = [UILabel labelWithFont:17 color:UIColorFromRGB(0x52627c)];
    [_backView addSubview:genderLabel];
    genderLabel.text = QHLocalizedString(@"性别", nil);
    
    UIView *sepLine1 = [[QHTools toolsDefault] addLineView:_backView :CGRectZero];
    [_backView addSubview:sepLine1];
    
    UILabel *maleLabel = [UILabel labelWithFont:17 color:UIColorFromRGB(0x52627c)];
    [_backView addSubview:maleLabel];
    maleLabel.text = QHLocalizedString(@"男", nil);
    
    UIImageView *maleView = [[UIImageView alloc] init];
    maleView.image = IMAGENAMED(@"gender_male");
    [_backView addSubview:maleView];
    
    UIButton *maleBtn = [[UIButton alloc] init];
    [_backView addSubview:maleBtn];
    [maleBtn setImage:IMAGENAMED(@"check") forState:(UIControlStateSelected)];
    [maleBtn setImage:IMAGENAMED(@"normal") forState:(UIControlStateNormal)];
    [maleBtn addTarget:self action:@selector(chooseGender:) forControlEvents:(UIControlEventTouchUpInside)];
    maleBtn.tag = BTN_TAG;
    
    UIView *sepLine2 = [[QHTools toolsDefault] addLineView:_backView :CGRectZero];
    [_backView addSubview:sepLine2];
    
    UILabel *femaleLabel = [UILabel labelWithFont:17 color:UIColorFromRGB(0x52627c)];
    [_backView addSubview:femaleLabel];
    femaleLabel.text = QHLocalizedString(@"女", nil);
    
    UIImageView *femaleView = [[UIImageView alloc] init];
    femaleView.image = IMAGENAMED(@"gender_female");
    [_backView addSubview:femaleView];
    
    UIButton *femaleBtn = [[UIButton alloc] init];
    [_backView addSubview:femaleBtn];
    [femaleBtn setImage:IMAGENAMED(@"check") forState:(UIControlStateSelected)];
    [femaleBtn setImage:IMAGENAMED(@"normal") forState:(UIControlStateNormal)];
    [femaleBtn addTarget:self action:@selector(chooseGender:) forControlEvents:(UIControlEventTouchUpInside)];
    femaleBtn.tag = BTN_TAG+1;
    
    if ([_gender isEqualToString:@"1"]) {
        maleBtn.selected = YES;
    } else {
        femaleBtn.selected = YES;
    }
    
    UIView *sepLine3 = [[QHTools toolsDefault] addLineView:_backView :CGRectZero];
    [_backView addSubview:sepLine3];
    
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
    
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.centerY.equalTo(_backView.mas_top).mas_offset(rowHeight*0.5);
    }];
    
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.right.equalTo(_backView).mas_offset(-15);
        make.top.mas_equalTo(rowHeight-1);
        make.height.mas_equalTo(1);
    }];
    
    [maleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.centerY.equalTo(_backView.mas_top).mas_offset(rowHeight*1.5);
    }];
    
    [maleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(maleLabel.mas_right).mas_offset(35);
        make.centerY.equalTo(maleLabel);
        make.width.height.mas_equalTo(13);
    }];
    
    [maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(maleView);
        make.right.equalTo(_backView).mas_offset(-25);
        make.width.height.mas_equalTo(24);
    }];
    
    [sepLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.right.equalTo(_backView).mas_offset(-15);
        make.top.mas_equalTo(2*rowHeight-1);
        make.height.mas_equalTo(1);
    }];
    
    [femaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.centerY.equalTo(_backView.mas_top).mas_offset(rowHeight*2.5);
    }];
    
    [femaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(femaleLabel.mas_right).mas_offset(35);
        make.centerY.equalTo(femaleLabel);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(13);
    }];
    
    [femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(femaleView);
        make.right.equalTo(_backView).mas_offset(-25);
        make.width.height.mas_equalTo(24);
    }];
    
    [sepLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).mas_offset(15);
        make.right.equalTo(_backView).mas_offset(-15);
        make.top.mas_equalTo(3*rowHeight-1);
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
    if (_callBack)
        _callBack(_gender);
    [self removeFromSuperview];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)chooseGender: (UIButton *)sender {
    sender.selected = YES;
    UIButton *unselectedBtn = [_backView viewWithTag:abs((int)sender.tag-1-BTN_TAG)+BTN_TAG];
    _gender = [NSString stringWithFormat:@"%zd", sender.tag-BTN_TAG+1];
    unselectedBtn.selected = NO;
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
