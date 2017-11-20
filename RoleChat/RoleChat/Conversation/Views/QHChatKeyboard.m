//
//  QHChatKeyboard.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHChatKeyboard.h"

#define FUNCTIONBTN_TAG 666

typedef NS_ENUM(NSInteger,ChatboxType) {
    ChatboxType_None,
    ChatboxType_Send
};

@interface QHChatKeyboard()<YYTextViewDelegate>

@property (nonatomic, copy) UIView *topContainer;
@property (nonatomic, copy) UIView *bottomContainer;
@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UIButton *recordBtn;
@property (nonatomic, assign) ChatboxType messageType;
@property (nonatomic, strong) UIView *functionView;
@property (nonatomic, strong) UIView *recordView;
           
@end

@implementation QHChatKeyboard {
    UIView *_superView;
}


- (instancetype)initWithKeyboardInView: (UIView *)view delegate: (id)delegate {
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

    [self addSubview:self.topContainer];
    [self addSubview:self.bottomContainer];
    
    [_bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    [_topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(_bottomContainer.mas_top);
    }];
}

- (UIView *)bottomContainer {
    if (_bottomContainer == nil) {
        _bottomContainer = [[UIView alloc] init];
        _bottomContainer.backgroundColor = UIColorFromRGB(0xf2f3f7);
        [_bottomContainer addSubview:self.recordView];
        [_bottomContainer addSubview:self.functionView];
        self.recordView.hidden = YES;
        self.functionView.hidden = YES;
    }
    return _bottomContainer;
}

- (UIView *)functionView {
    if (_functionView == nil) {
        _functionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        NSArray *titleArr = @[QHLocalizedString(@"图片", nil), QHLocalizedString(@"视频", nil), QHLocalizedString(@"语音聊天", nil), QHLocalizedString(@"视频聊天", nil)];
        NSArray *imgArr = @[@"Chat_pic", @"Chat_player", @"Chat_phone", @"Chat_video"];
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *functionBtn = [UIButton getImageBtnWithTitle:titleArr[i] imageStr:imgArr[i] imageWH:CGSizeMake(30, 30) titleSize:12 titleColoe:RGB939EAE space:5];
            functionBtn.tag = FUNCTIONBTN_TAG+i;
            [functionBtn sizeToFit];
            CGRect frame = functionBtn.frame;
            frame.origin.y = 20;
            functionBtn.frame = frame;
            functionBtn.centerX = (SCREEN_WIDTH/4.0*(i+0.5));
            [functionBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [_functionView addSubview:functionBtn];
            
        }
    }
    return _functionView;
}

- (void)functionBtnClick: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectFunction:)]) {
        [self.delegate selectFunction:sender.tag-FUNCTIONBTN_TAG];
    }
}

- (UIView *)topContainer {
    if (_topContainer == nil) {
        _topContainer = [[UIView alloc] init];
        _topContainer.backgroundColor = WhiteColor;
        [[QHTools toolsDefault] addLineView:_topContainer :CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        
        self.recordBtn = [[UIButton alloc] init];
        [_topContainer addSubview:self.recordBtn];
        [self.recordBtn setImage:IMAGENAMED(@"Chat_record") forState:(UIControlStateNormal)];
        self.recordBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.recordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.emojiBtn = [[UIButton alloc] init];
        [_topContainer addSubview:self.emojiBtn];
        [self.emojiBtn setImage:IMAGENAMED(@"Chat_emoji") forState:(UIControlStateNormal)];
        self.emojiBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.emojiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.emojiBtn addTarget:self action:@selector(emojiBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.sendBtn = [[UIButton alloc] init];
        [_topContainer addSubview:self.sendBtn];
        [self.sendBtn setImage:IMAGENAMED(@"Chat_add") forState:(UIControlStateNormal)];
        [self.sendBtn setImage:IMAGENAMED(@"Chat_cancel") forState:(UIControlStateSelected)];
        [self.sendBtn setBackgroundColor:UIColorFromRGB(0x00a6f1)];
        [self.sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:(UIControlEventTouchUpInside)];
        self.sendBtn.titleLabel.font = FONT(15);
        
        self.textView = [[YYTextView alloc] init];
        self.textView.textContainerInset = UIEdgeInsetsMake(13, 0, 13, 0);
        self.textView.font = FONT(15);
        self.textView.textColor = RGB52627C;
        self.textView.returnKeyType = UIReturnKeySend;
        YYTextLinePositionSimpleModifier *mode = [[YYTextLinePositionSimpleModifier alloc] init];
        mode.fixedLineHeight = 20;
        self.textView.linePositionModifier = mode;
        [_topContainer addSubview:self.textView];
        self.textView.delegate = self;
        
        [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(_topContainer);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(50);
        }];
        
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(_topContainer);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(60);
        }];
        
        [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_topContainer);
            make.right.equalTo(self.sendBtn.mas_left);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(50);
        }];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.recordBtn.mas_right).mas_offset(15);
            make.right.equalTo(self.emojiBtn.mas_left).mas_offset(-15);
            make.top.bottom.equalTo(_topContainer);
        }];
    }
    return _topContainer;
}

- (void)recordBtnClick {
    
}

- (void)emojiBtnClick {
    
}

- (void)sendMessage: (UIButton *)sender {
    if (self.messageType == ChatboxType_Send) {
        // 发送消息
        [self.sendBtn setTitle:nil forState:(UIControlStateNormal)];
        [self.sendBtn setImage:IMAGENAMED(@"Chat_add") forState:(UIControlStateNormal)];
        self.messageType = ChatboxType_None;
        if ([self.delegate respondsToSelector:@selector(sendMessages:)]) {
            [self.delegate sendMessages:self.textView.text];
        }
        self.textView.text = nil;
        return;
    }
    sender.selected = !sender.isSelected;
    if (self.textView.text.length && !self.sendBtn.isSelected) {
        [self.sendBtn setTitle:QHLocalizedString(@"发送", nil) forState:(UIControlStateNormal)];
        [self.sendBtn setImage:nil forState:(UIControlStateNormal)];
        self.messageType = ChatboxType_Send;
    }
    [self.textView resignFirstResponder];
    if (!sender.isSelected) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_superView).mas_offset(100);
        }];
    } else {
        self.functionView.hidden = NO;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_superView);
        }];
    }
    [_superView layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(keyboardFrameChange)]) {
        [self.delegate keyboardFrameChange];
    }
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView {
    
    CGSize sizeThatShouldFitTheContent = [textView sizeThatFits:textView.frame.size];
    CGFloat constant = MAX(50.f, MIN(sizeThatShouldFitTheContent.height,80));
    //每次textView的文本改变后 修改chatBar的高度
    [self.topContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(constant);
    }];
    textView.scrollEnabled = constant >= 80;
    
}

- (void)resetBtnState {
    if (self.sendBtn.selected) {
        
    } else {
        [self.textView resignFirstResponder];
        if (self.textView.text.length) {
            [self.sendBtn setTitle:QHLocalizedString(@"发送", nil) forState:(UIControlStateNormal)];
            [self.sendBtn setImage:nil forState:(UIControlStateNormal)];
            self.messageType = ChatboxType_Send;
        }
    }
}

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    self.sendBtn.selected = NO;
    if (self.messageType == ChatboxType_Send) {
        // 发送消息
        [self.sendBtn setTitle:nil forState:(UIControlStateNormal)];
        [self.sendBtn setImage:IMAGENAMED(@"Chat_add") forState:(UIControlStateNormal)];
        self.messageType = ChatboxType_None;
    }
    CGSize sizeThatShouldFitTheContent = [textView sizeThatFits:textView.frame.size];
    CGFloat chatBarHeight = MAX(50.f, MIN(sizeThatShouldFitTheContent.height,80));
    
    textView.scrollEnabled = chatBarHeight>=80;
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //实现textView.delegate  实现回车发送,return键发送功能
    if ([@"\n" isEqualToString:text]) {
        
        [self.topContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
        }];
        
        if (textView.text.length > 0) {
            if ([self.delegate respondsToSelector:@selector(sendMessages:)]) {
                [self.delegate sendMessages:self.textView.text];
            }
        }
        
        textView.text = nil;
        [self setNeedsLayout];
        
        return NO;
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
