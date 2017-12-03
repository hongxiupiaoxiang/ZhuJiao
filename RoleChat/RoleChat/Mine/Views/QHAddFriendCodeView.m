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
    
    CGFloat bgViewWidth = 300.0 / 375 * SCREEN_WIDTH;
    CGFloat bgViewHeight = 390.0 / 667 * SCREEN_HEIGHT;
    
    CGFloat codeViewWH = 250.0 / 300 * bgViewWidth;
    CGFloat topMargin = 50.0 / 390 *  bgViewHeight;
    CGFloat middleMargin = 30.0 / 390 * bgViewHeight;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgViewWidth, bgViewHeight)];
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:bgView cornerRedii:5];
    bgView.backgroundColor = WhiteColor;
    bgView.centerX = Kwindow.centerX;
    bgView.centerY = Kwindow.centerY-45;
    [_bgView addSubview:bgView];
    
    UIImageView *codeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, codeViewWH, codeViewWH)];
    
    UIImageView *headView = [[UIImageView alloc] init];
    [headView loadImageWithUrl:[QHPersonalInfo sharedInstance].userInfo.imgurl placeholder:nil];
    
    codeView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:[QHPersonalInfo sharedInstance].userInfo.userAddress logoImage:headView.image logoScaleToSuperView:0.3];
    
    codeView.centerX = bgViewWidth*0.5;
    codeView.centerY = topMargin+codeViewWH*0.5;
    [bgView addSubview:codeView];
    
    UILabel *descritptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgViewWidth, 16)];
    descritptionLabel.textAlignment = NSTextAlignmentCenter;
    descritptionLabel.text = QHLocalizedString(@"扫描添加我为好友", nil);
    descritptionLabel.textColor = UIColorFromRGB(0x52627c);
    descritptionLabel.font = FONT(15);
    descritptionLabel.centerX = bgViewWidth*0.5;
    descritptionLabel.centerY = topMargin+middleMargin+codeViewWH+8;
    [bgView addSubview:descritptionLabel];
    
    UIButton *dissmisBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [dissmisBtn setImage:IMAGENAMED(@"cancel") forState:(UIControlStateNormal)];
    dissmisBtn.backgroundColor = WhiteColor;
    dissmisBtn.layer.cornerRadius = 25;
    dissmisBtn.layer.masksToBounds = YES;
    dissmisBtn.centerX = Kwindow.centerX;
    dissmisBtn.centerY = bgView.mj_y+bgView.height+40+25;
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
