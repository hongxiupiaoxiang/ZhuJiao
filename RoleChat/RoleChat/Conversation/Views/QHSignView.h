//
//  QHSignView.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

@interface QHSignView : QHBaseView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL hideCheck;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) UIColor *color;

@end
