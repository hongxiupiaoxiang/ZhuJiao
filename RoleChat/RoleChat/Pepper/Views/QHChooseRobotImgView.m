//
//  QHChooseRobotImgView.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChooseRobotImgView.h"

@implementation QHChooseRobotImgView {
    NSString *_imgStr;
    NSString *_titleStr;
    UILabel *_currentTitleLabel;
    UIImageView *_selectImgView;
    QHParamsCallback _callback;
}

- (instancetype)initWithImgStr: (NSString *)imgStr title: (NSString *)title imageCallback: (QHParamsCallback)callback {
    if (self = [super init]) {
        _imgStr = imgStr;
        _titleStr = title;
        _callback = callback;
        [self setupUI];
    }
    return self;
}

- (void)setIsCurrentImage:(BOOL)isCurrentImage {
    _isCurrentImage = isCurrentImage;
    _currentTitleLabel.hidden = !_isCurrentImage;
}

- (void)setIsSelectImage:(BOOL)isSelectImage {
    _isSelectImage = isSelectImage;
    if (isSelectImage) {
        self.backgroundColor = RGBF5F6FA;
        _selectImgView.hidden = NO;
    } else {
        self.backgroundColor = WhiteColor;
        _selectImgView.hidden = YES;
    }
}

- (void)setupUI {
    self.backgroundColor = WhiteColor;
    self.bounds = CGRectMake(0, 0, SCREEN_WIDTH/3, 140);
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 60, 60)];
    imgView.centerX = self.bounds.size.width*0.5;
    [self addSubview:imgView];
    imgView.image = IMAGENAMED(_imgStr);
    
    UILabel *titleLabel = [UILabel labelWithFont:15 color:RGB939EAE];
    [self addSubview:titleLabel];
    titleLabel.text = _titleStr;
    [titleLabel sizeToFit];
    CGRect titleFrame = titleLabel.frame;
    titleFrame.origin.y = 90;
    titleLabel.frame = titleFrame;
    titleLabel.centerX = self.bounds.size.width*0.5;
    
    _currentTitleLabel = [UILabel labelWithFont:12 color:UIColorFromRGB(0x1f8ded)];
    [self addSubview:_currentTitleLabel];
    _currentTitleLabel.text = QHLocalizedString(@"当前形象", nil);
    [_currentTitleLabel sizeToFit];
    CGRect currentTitleFrame = _currentTitleLabel.frame;
    currentTitleFrame.origin.y = 115;
    _currentTitleLabel.frame = currentTitleFrame;
    _currentTitleLabel.hidden = YES;
    _currentTitleLabel.centerX = self.bounds.size.width*0.5;
    
    _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-20, 0, 20, 20)];
    _selectImgView.image = IMAGENAMED(@"Robot_check");
    _selectImgView.hidden = YES;
    [self addSubview:_selectImgView];
    
    WeakSelf
    __weak typeof(_callback)weakCallBack = _callback;
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if (weakSelf.isCurrentImage) {
            return ;
        } else {
            weakSelf.isSelectImage = YES;
            if (weakCallBack) {
                weakCallBack(_titleStr);
            }
        }
    }];
    [self addGestureRecognizer:tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
