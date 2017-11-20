//
//  QHChatFunctionView.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/20.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatFunctionView.h"

@interface QHChatFunctionView()

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation QHChatFunctionView

- (instancetype)initWithPoint:(CGPoint)point SelectedIndexCallback: (QHParamsCallback)seletedIndex {
    if (self = [super init]) {
        self.point = point;
        self.paramsCallback = seletedIndex;
        [self setupUI];
    }
    return self;
}
- (void)showInPoint: (CGPoint)point {
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
    [self show];
}

- (void)show {
    [Kwindow addSubview:self.maskView];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)setupUI {
    self.layer.cornerRadius = 3;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.15f;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
    self.backgroundColor = WhiteColor;
    
    
    WeakSelf
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        weakSelf.paramsCallback(0);
        [weakSelf dismiss];
    }];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.maskView addGestureRecognizer:tap];
    
    self.frame = CGRectMake(self.point.x, self.point.y, SCREEN_WIDTH-2*self.point.x, 150);
    [_maskView addSubview:self];
    
    NSArray *titleArr = @[QHLocalizedString(@"点赞", nil), QHLocalizedString(@"内容合理", nil) ,QHLocalizedString(@"内容不符", nil) ,QHLocalizedString(@"加标签", nil)];
    NSArray *picArr = @[@"Chat_like", @"Chat_good", @"Chat_bad", @"Chat_sign"];
    for (int i =0; i<4;i++) {
        UIButton *button = [UIButton getImageBtnWithTitle:titleArr[i] imageStr:picArr[i] imageWH:CGSizeMake(25, 25) titleSize:12 titleColoe:RGB939EAE space:6];
        [self addSubview:button];
        [button sizeToFit];
        button.backgroundColor = WhiteColor;
        button.tag = i+100;
        ButtonAddTarget(button, selectButton:)
        
        CGRect frame = button.frame;
        frame.origin.y = 30;
        button.frame = frame;
        button.centerX = (i+0.5)*(self.width/4.0);
    }
    
    [[QHTools toolsDefault] addLineView:self :CGRectMake(15, 100, self.width-30, 1)];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.width, 50)];
    [self addSubview:cancelBtn];
    [cancelBtn setTitle:QHLocalizedString(@"取消", nil) forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:RGB939EAE forState:(UIControlStateNormal)];
    cancelBtn.tag = 104;
    ButtonAddTarget(cancelBtn, selectButton:)
    
    CGRect fitFram = self.frame;
    self.layer.anchorPoint = CGPointMake(0.5, 0);
    self.frame = fitFram;
    self.alpha = 0;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
}

-(void)selectButton:(UIButton*)button{
    if (self.paramsCallback) {
        self.paramsCallback([NSString stringWithFormat:@"%ld",button.tag-100]);
    }
    [self dismiss];
}

-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    return _maskView;
}
-(void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [_maskView removeFromSuperview];
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
