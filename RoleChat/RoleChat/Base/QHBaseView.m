//
//  QHBaseView.m
//  RoleChat
//
//  Created by zfQiu on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseView.h"

@interface QHBaseView () <UIGestureRecognizerDelegate>

@property(nonatomic, strong) UITapGestureRecognizer* tapGesture;

@end

@implementation QHBaseView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}
-(void)setupView{
    
}
-(void)addTapGesture {
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    _tapGesture.delegate = self;
    [self addGestureRecognizer:_tapGesture];
    return ;
}

-(void)setEnableBackgroundTap:(BOOL)enableBackgroundTap {
    _enableBackgroundTap = enableBackgroundTap;
    
    if(_enableBackgroundTap) {
        if(_tapGesture == nil)
            [self addTapGesture];
    }
    
    _tapGesture.enabled = _enableBackgroundTap;
    return ;
}

-(void)backgroundTapped {
    for (UIView* subView in self.subviews) {
        if([subView isKindOfClass:[UITextField class]])
            [((UITextField*)subView) resignFirstResponder];
    }
    return ;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}


@end
