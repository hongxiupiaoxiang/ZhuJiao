//
//  QHChatKeyboard.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatKeyboard.h"

#define TEXTVIEW_HEIGHT 50
#define FACEVIEW_HEIGHT 180
#define FUNCTION_HEIGHT 100

@interface QHChatKeyboard()

@property (nonatomic, strong) UIView *functionView;

@end

@implementation QHChatKeyboard {
    UIView *_superView;
}


- (instancetype)initKeyboardInView: (UIView *)view delegate: (id)delegate {
    if (self = [super init]) {
        _superView = view;
        [view addSubview:self];
        self.delegate = delegate;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = CGRectMake(0, _superView.height-TEXTVIEW_HEIGHT-64, SCREEN_WIDTH, TEXTVIEW_HEIGHT+FACEVIEW_HEIGHT);
    
    [[QHTools toolsDefault] addLineView:self :CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    
    UIButton *recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 50)];
    [self addSubview:recordBtn];
    [recordBtn setImage:IMAGENAMED(@"Chat_record") forState:(UIControlStateNormal)];
    recordBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    recordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *emojiBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105, 0, 45, 50)];
    [self addSubview:emojiBtn];
    [emojiBtn setImage:IMAGENAMED(@"Chat_emoji") forState:(UIControlStateNormal)];
    emojiBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emojiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [emojiBtn addTarget:self action:@selector(emojiBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 50)];
    [self addSubview:sendBtn];
    [sendBtn setImage:IMAGENAMED(@"Chat_add") forState:(UIControlStateNormal)];
    [sendBtn setImage:IMAGENAMED(@"Chat_cancel") forState:(UIControlStateSelected)];
    sendBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    sendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (UIView *)functionView {
    if (_functionView == nil) {
        _functionView = [UIView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
}

- (void)recordBtnClick {
    
}

- (void)emojiBtnClick {
    
}

- (void)sendMessage: (UIButton *)sender {
    sender.selected = !sender.isSelected;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
