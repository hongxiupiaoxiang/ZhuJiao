//
//  QHChatFunctionView.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/20.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

@interface QHChatFunctionView : QHBaseView

- (instancetype)initWithPoint:(CGPoint)point SelectedIndexCallback: (QHParamsCallback)seletedIndex;

- (void)show;

@end
