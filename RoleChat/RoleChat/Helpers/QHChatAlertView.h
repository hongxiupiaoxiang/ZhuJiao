//
//  QHChatAlertView.h
//  GoldWorld
//
//  Created by zfqiu on 2017/3/17.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseView.h"

@class QHChatAlertView;
typedef void(^AlertResult)(QHChatAlertView* alertView);

@interface QHChatAlertView : QHBaseView

@property (nonatomic,copy) AlertResult sureBlock;
@property (nonatomic, copy) AlertResult cancelBlock;
@property (nonatomic, assign) BOOL alertViewShouldAlwaysShown;

/**
 自定义一至两个按钮，多个按钮用父类方法
 
 @param title 标题
 @param message 提示信息
 @param sureTitle 确定按钮(利用block处理事件）
 @param cancleTitle 取消按钮
 @return UIAlertView
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;
- (instancetype)initWithTitle:(NSString *)title placeHolderStr:(NSString *)placeHolderStr sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;
- (void)showChatAlertView;
- (void)buttonEvent:(UIButton *)sender;

@end

@interface QHChatAlertView()

@property(nonatomic, strong) UIWindow* innerWindow;
//弹窗
@property (nonatomic, strong) UIView *alertView;
//title
@property (nonatomic, strong) UILabel *titleLbl;
//内容
@property (nonatomic, strong) UILabel *msgLbl;
//确定按钮
@property (nonatomic, strong) UIButton *sureBtn;
//取消按钮
@property (nonatomic, strong) UIButton *cancleBtn;
//横线线
@property (nonatomic, strong) UIView *lineView;
//竖线
@property (nonatomic, strong) UIView *verLineView;
//文本框
@property (nonatomic, strong) UITextField *msgTF;

@end
