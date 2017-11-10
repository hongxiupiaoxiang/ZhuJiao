//
//  QHModeSelectedView.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/10.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

@interface QHModeSelectedView : QHBaseView

/**
 标题字体大小,默认16
 */
@property (nonatomic, assign) NSInteger titleFont;

/**
 单元格标题大小,默认15
 */
@property (nonatomic, assign) NSInteger contentTitleFont;
/**
 单元格内容大小,默认12
 */
@property (nonatomic, assign) NSInteger detailTitleFont;
/**
 收起按钮字体大小,默认14
 */
@property (nonatomic, assign) NSInteger showBtnFont;
/**
 标题栏高度
 */
@property (nonatomic, assign) CGFloat titleHeight;
/**
 单元格高度
 */
@property (nonatomic, assign) CGFloat contentHeight;
/**
 是否展开
 */
@property (nonatomic, assign) BOOL isShow;

/**
 初始化方法

 @param title 顶部标题
 @param contentTitles 单元格标题
 @param detailTitles 详细信息
 @param keyword 关键字,赋予特殊颜色
 @param selectedIndex 当前选中的单元格,默认从一开始
 @param selectedCallback 选择回调
 @return QHModeSelectedView
 */
- (instancetype)initWithTitle: (NSString *)title contentTitles: (NSArray *)contentTitles  detailTitles: (NSArray *)detailTitles keyword: (NSString *)keyword selectedCallback: (QHParamsCallback)selectedCallback selectedIndex: (NSInteger)selectedIndex;

@end
