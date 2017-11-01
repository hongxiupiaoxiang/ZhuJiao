//
//  QHTextFieldAlertView.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

@interface QHTextFieldAlertView : QHBaseView

// 创建带UITextField弹窗
- (instancetype)initWithTitle: (NSString *)title placeholder: (NSString *)placeholder sureBlock: (QHNoParamCallback)sure failureBlock: (QHNoParamCallback)failure;

// 展示
- (void)show;

@end
