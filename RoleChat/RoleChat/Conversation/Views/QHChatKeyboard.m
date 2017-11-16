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

@interface QHChatKeyboard()<YYTextViewDelegate>

@property (nonatomic, copy) UIView *topContainer;
@property (nonatomic, copy) UIView *bottomContainer;

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
//    [self addSubview:self.bottomContainer];
    
    [_topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
}

- (UIView *)topContainer {
    if (_topContainer == nil) {
        _topContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _topContainer.backgroundColor = WhiteColor;
        [[QHTools toolsDefault] addLineView:_topContainer :CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        
        UIButton *recordBtn = [[UIButton alloc] init];
        [_topContainer addSubview:recordBtn];
        [recordBtn setImage:IMAGENAMED(@"Chat_record") forState:(UIControlStateNormal)];
        recordBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        recordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton *emojiBtn = [[UIButton alloc] init];
        [_topContainer addSubview:emojiBtn];
        [emojiBtn setImage:IMAGENAMED(@"Chat_emoji") forState:(UIControlStateNormal)];
        emojiBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        emojiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [emojiBtn addTarget:self action:@selector(emojiBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton *sendBtn = [[UIButton alloc] init];
        [_topContainer addSubview:sendBtn];
        [sendBtn setImage:IMAGENAMED(@"Chat_add") forState:(UIControlStateNormal)];
        [sendBtn setImage:IMAGENAMED(@"Chat_cancel") forState:(UIControlStateSelected)];
        [sendBtn setBackgroundColor:UIColorFromRGB(0x00a6f1)];
        [sendBtn addTarget:self action:@selector(sendMessage:) forControlEvents:(UIControlEventTouchUpInside)];
        
        YYTextView *textView = [[YYTextView alloc] init];
        textView.textContainerInset = UIEdgeInsetsMake(13, 0, 13, 0);
        textView.font = FONT(15);
        textView.textColor = RGB52627C;
        textView.returnKeyType = UIReturnKeySend;
        YYTextLinePositionSimpleModifier *mode = [[YYTextLinePositionSimpleModifier alloc] init];
        mode.fixedLineHeight = 20;
        textView.linePositionModifier = mode;
        [_topContainer addSubview:textView];
        textView.delegate = self;
        
        [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(_topContainer);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(50);
        }];
        
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(_topContainer);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(60);
        }];
        
        [emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_topContainer);
            make.right.equalTo(sendBtn.mas_left);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(50);
        }];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(recordBtn.mas_right).mas_offset(15);
            make.right.equalTo(emojiBtn.mas_left).mas_offset(-15);
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
    
    /** 解决chatBar高度变化后,tableView高度修改 */
//    [self.view layoutIfNeeded];
}

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    
    
    
    //解决textView大小不定时 contentOffset不正确的bug
    //固定了textView后可以设置滚动YES
    CGSize sizeThatShouldFitTheContent = [textView sizeThatFits:textView.frame.size];
    //每次textView的文本改变后 修改chatBar的高度
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
        NSString *messageContent;
        if (textView.text.length > 0) {
            messageContent = textView.text;
        }
        
        [textView setAttributedText:nil];
        [self setNeedsLayout];
        
        return NO;
    }
    return YES;
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
