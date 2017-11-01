//
//  QHAddFriendCodeView.m
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHAddFriendCodeView.h"

static QHAddFriendCodeView *addCodeView;

@implementation QHAddFriendCodeView {
    UIView *_bgView;
}


+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addCodeView = [[QHAddFriendCodeView alloc] init];
    });
    return addCodeView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)show {
    [Kwindow addSubview:_bgView];
}

- (void)setupUI {
    _bgView = [[UIView alloc] initWithFrame:Kwindow.frame];
    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    CGFloat backViewWidth = 300.0 / 375 * SCREEN_WIDTH;
    CGFloat backViewHeight = 390.0 / 667 * SCREEN_HEIGHT;
    
    CGFloat codeViewWH = 250.0 / 300 * backViewWidth;
    CGFloat topMargin = 50.0 / 390 *  backViewHeight;
    CGFloat middleMargin = 30.0 / 390 * backViewHeight;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth, backViewHeight)];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:backView cornerRedii:5];
    backView.backgroundColor = WhiteColor;
    backView.centerX = Kwindow.centerX;
    backView.centerY = Kwindow.centerY-45;
    [_bgView addSubview:backView];
    
    UIImageView *codeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, codeViewWH, codeViewWH)];
    
    codeView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:[QHPersonalInfo sharedInstance].userInfo.userAddress logoImageName:nil logoScaleToSuperView:0.3];
    codeView.centerX = backViewWidth*0.5;
    codeView.centerY = topMargin+codeViewWH*0.5;
    [backView addSubview:codeView];
    
    UILabel *descritptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backViewWidth, 16)];
    descritptionLabel.textAlignment = NSTextAlignmentCenter;
    descritptionLabel.text = QHLocalizedString(@"扫描添加我为好友", nil);
    descritptionLabel.textColor = UIColorFromRGB(0x52627c);
    descritptionLabel.font = FONT(15);
    descritptionLabel.centerX = backViewWidth*0.5;
    descritptionLabel.centerY = topMargin+middleMargin+codeViewWH+8;
    [backView addSubview:descritptionLabel];
    
    UIButton *dissmisBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [dissmisBtn setImage:IMAGENAMED(@"cancel") forState:(UIControlStateNormal)];
    dissmisBtn.backgroundColor = WhiteColor;
    dissmisBtn.layer.cornerRadius = 25;
    dissmisBtn.layer.masksToBounds = YES;
    dissmisBtn.centerX = Kwindow.centerX;
    dissmisBtn.centerY = backView.mj_y+backView.height+40+25;
    [_bgView addSubview:dissmisBtn];
    
    [dissmisBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)dismiss {
    [_bgView removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
