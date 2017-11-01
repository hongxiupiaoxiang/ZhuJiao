//
//  QHChatAlertView.m
//  GoldWorld
//
//  Created by zfqiu on 2017/3/17.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHChatAlertView.h"

@implementation QHChatAlertView {
    NSString *_cancelTitle;
    NSString *_title;
    NSString *_placeHolderStr;
    NSString *_sureTitle;
    NSString *_message;
    CGFloat _btnHeight;
    CGFloat _tfHeight;
}

- (void)setupUIWithMsg: (BOOL)isMsgType {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.alertView = [[UIView alloc] init];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.layer.cornerRadius = 8.0;
    CGRect frame = CGRectMake(0, 0, 300, 180);
    _btnHeight = 50;
    _tfHeight = 40;
    self.alertView.frame = frame;
    self.alertView.layer.position = self.center;
    
    self.titleLbl = [[UILabel alloc] init];
    self.titleLbl.text = _title;
    self.titleLbl.font = FONT(17);
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.alertView addSubview:self.titleLbl];
    
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView).mas_offset(30);
        make.left.right.equalTo(self.alertView);
        make.height.mas_equalTo(17);
    }];
    
    if (!isMsgType) {
        self.msgTF = [[UITextField alloc] init];
        self.msgTF.returnKeyType = UIReturnKeyDone;
        self.msgTF.borderStyle = UITextBorderStyleRoundedRect;
        self.msgTF.placeholder = _placeHolderStr;
        [self.alertView addSubview:self.msgTF];
        
        
        [self.msgTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom).mas_equalTo(20);
            make.left.equalTo(self.alertView).mas_offset(15);
            make.right.equalTo(self.alertView).mas_offset(-15);
            make.height.mas_equalTo(_tfHeight);
        }];
    } else {
        self.msgLbl = [[UILabel alloc] init];
        self.msgLbl.textAlignment = NSTextAlignmentCenter;
        self.msgLbl.font = FONT(14);
        self.msgLbl.numberOfLines = 0;
        self.msgLbl.textAlignment = NSTextAlignmentCenter;
        self.msgLbl.textColor = UIColorFromRGB(0x969699);
        [self.alertView addSubview:self.msgLbl];
        
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0f;

        paragraphStyle.alignment = NSTextAlignmentCenter;
//        if (titleHeight > 18.0f) {
//            paragraphStyle.alignment = NSTextAlignmentLeft;
//        }
        
        // 判断行高
//        CGFloat titleHeight = [_message boundingRectWithSize:CGSizeMake(300 - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT(14.0f)} context:nil].size.height + 0.5f;
        
        self.msgLbl.attributedText = [[NSAttributedString alloc] initWithString:_message?_message:@"" attributes:@{NSParagraphStyleAttributeName : paragraphStyle,}];
        [self.msgLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.titleLbl.mas_bottom).mas_equalTo(10);
            make.centerY.equalTo(self.alertView.mas_top).mas_offset(85);
            make.left.equalTo(self.alertView).mas_offset(15);
            make.right.equalTo(self.alertView).mas_offset(-15);
        }];
        if (_title.length < 1) {
            [self.msgLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLbl.mas_bottom).mas_offset(5);
            }];
        }
    }
    
    self.lineView = [[QHTools toolsDefault] addLineView:self.alertView :CGRectMake(0, 0, self.alertView.width, 2.0f / SCREEN_SCALE)];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.alertView).mas_offset(-_btnHeight);
        make.left.right.equalTo(self.alertView);
        make.height.mas_equalTo(2.0 / SCREEN_SCALE);
    }];
    self.sureBtn = [[UIButton alloc] init];
    [self.sureBtn setTitleColor:MainColor forState:(UIControlStateNormal)];
    self.sureBtn.titleLabel.font = FONT(14);
    [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
    [self.sureBtn setTitle:_sureTitle forState:UIControlStateNormal];
    self.sureBtn.tag = 2;
    [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:self.sureBtn];
    if (_cancelTitle.length < 1) {
        self.sureBtn.frame = CGRectMake(0, 0, self.alertView.width, _btnHeight);
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.alertView);
            make.height.mas_equalTo(_btnHeight);
        }];
    } else {
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cancleBtn setTitleColor:UIColorFromRGB(0x646466) forState:(UIControlStateNormal)];
        self.cancleBtn.titleLabel.font = FONT(14);
        self.cancleBtn.frame = CGRectMake(0, 0, self.alertView.width*0.5, _btnHeight);
        [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
        [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
        [self.cancleBtn setTitle:_cancelTitle forState:UIControlStateNormal];
        self.cancleBtn.tag = 1;
        [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.cancleBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.cancleBtn.layer.mask = maskLayer;
        
        [self.alertView addSubview:self.cancleBtn];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.alertView);
            make.height.mas_equalTo(_btnHeight);
            make.width.mas_equalTo(self.alertView.width*0.5);
        }];
        
        self.verLineView = [[QHTools toolsDefault] addLineView:self.alertView :CGRectMake(0, 0, 1.0 / SCREEN_SCALE, _btnHeight)];
        [self.alertView addSubview:self.verLineView];
        [self.verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.alertView).mas_offset(self.alertView.width*0.5);
            make.bottom.equalTo(self.alertView);
            make.width.mas_equalTo(1.0 / SCREEN_SCALE);
            make.height.mas_equalTo(_btnHeight);
        }];
        
        
        self.sureBtn.frame = CGRectMake(0, 0, self.alertView.width*0.5, _btnHeight);
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.alertView);
            make.width.mas_equalTo(self.alertView.width*0.5);
            make.height.mas_equalTo(_btnHeight);
        }];
    }
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.sureBtn.bounds;
    maskLayer2.path = maskPath2.CGPath;
    self.sureBtn.layer.mask = maskLayer2;
    [self addSubview:self.alertView];
}

- (instancetype)initWithTitle:(NSString *)title placeHolderStr:(NSString *)placeHolderStr sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle {
    if (self == [super init]) {
        _title = title;
        _placeHolderStr = placeHolderStr;
        _cancelTitle = cancleTitle;
        _sureTitle = sureTitle;
        [self setupUIWithMsg:NO];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    if (self == [super init]) {
        _title = title;
        _message = message;
        _sureTitle = sureTitle;
        _cancelTitle = cancleTitle;
        [self setupUIWithMsg:YES];
    }
    
    return self;
}

#pragma mark 弹窗
- (void)showChatAlertView
{
    if(_innerWindow == nil) {
        _innerWindow = [[UIWindow alloc] initWithFrame:App_Delegate.window.bounds];
        [_innerWindow addSubview:self];
        [_innerWindow makeKeyAndVisible];
    }
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPan:)];
    [self.alertView addGestureRecognizer:pan];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.20, 0.20);
    [UIView animateWithDuration:0.25f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark 回调
- (void)buttonEvent:(UIButton *)sender
{
    WeakSelf
    if (sender.tag == 2 && self.sureBlock) {
        self.sureBlock(weakSelf);
        
    } else if(sender.tag == 1 && self.cancelBlock) {
        self.cancelBlock(weakSelf);
    }
    
    if(self.alertViewShouldAlwaysShown == NO) {
        [UIView animateWithDuration:0.25f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alertView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [_innerWindow resignKeyWindow];
            _innerWindow.hidden = YES;
        }];
    }
    
    return ;
}

// 添加平移手势,防止文本框被键盘遮挡
- (void)viewPan: (UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, translation.x, translation.y);
    [sender setTranslation:CGPointZero inView:sender.view];
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
