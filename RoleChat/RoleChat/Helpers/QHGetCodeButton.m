//
//  QHGetCodeButton.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/9.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHGetCodeButton.h"

@interface QHGetCodeButton ()

@property(nonatomic, assign) NSUInteger timeInterval;
@property(nonatomic, assign) NSUInteger remainTimeInterval;
@property(nonatomic, strong) NSTimer* timer;

@end

@implementation QHGetCodeButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeInterval = 60.0f;
        _remainTimeInterval = _timeInterval;
        [self setTitleColor:MainColor forState:UIControlStateNormal];
        self.titleLabel.font = FONT(15);
        [self setTitleColor:UIColorFromRGB(0xC8C9CC) forState:UIControlStateDisabled];
        [self setTitle:QHLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithTimeInterval:(NSUInteger)timeInterval withAction:(GetCodeAction)action
{
    self = [super init];
    if (self) {
        _timeInterval = timeInterval;
        _remainTimeInterval = _timeInterval;
        _action = action;
    }
    return self;
}

-(instancetype)initWithTimeInterval:(NSUInteger)timeInterval {
    self = [super init];
    if(self) {
        _timeInterval = timeInterval;
        _remainTimeInterval = _timeInterval;
    }
    return self;
}

-(void)buttonPressed:(QHGetCodeButton*)sender {
    if(self.action == nil || (self.action != nil && self.action() == NO))
        return ;
    [self setTitle:[NSString stringWithFormat:QHLocalizedString(@"%d s", nil), _remainTimeInterval] forState:UIControlStateNormal];
    self.enabled = NO;
    __weak typeof(self) wself = self;
    _timer = [NSTimer timerWithTimeInterval:1.0f block:^(NSTimer * _Nonnull timer) {
        if(wself.remainTimeInterval == 1) {
            [timer invalidate];
            timer = nil;
            wself.enabled = YES;
            wself.remainTimeInterval = wself.timeInterval;
            [wself setTitle:QHLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
            [wself sizeToFit];
            return ;
        }
        
        [wself setTitle:[NSString stringWithFormat:QHLocalizedString(@"%d s", nil), --wself.remainTimeInterval] forState:UIControlStateNormal];
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    return ;
}

@end
