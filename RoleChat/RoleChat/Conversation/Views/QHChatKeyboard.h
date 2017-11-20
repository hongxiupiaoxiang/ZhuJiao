//
//  QHChatKeyboard.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/16.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

typedef NS_ENUM(NSInteger,Function) {
    Function_Image,
    Function_Video,
    Function_AudioChat,
    Function_VideoChat
};

@protocol QHChatKeyboardDelegate<NSObject>

//录音
- (void)record;
//发送消息
- (void)sendMessages: (NSString *)message;
//功能
- (void)selectFunction: (Function)function;
//底部高度变化
- (void)keyboardFrameChange;


@end

@interface QHChatKeyboard : QHBaseView

@property (nonatomic, assign) id<QHChatKeyboardDelegate> delegate;

- (instancetype)initWithKeyboardInView: (UIView *)view delegate: (id)delegate;
//辞去textview响应者
- (void)resetBtnState;
@end
