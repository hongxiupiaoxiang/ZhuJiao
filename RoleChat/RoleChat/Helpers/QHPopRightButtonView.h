//
//  QHPopRightButtonView.h
//  RoleChat
//
//  Created by zfQiu on 2017/11/20.
//  Copyright © 2017年 qhspeed. All rights reserved.
//
#import "QHBaseView.h"

typedef NS_ENUM(NSInteger, TitleAliment) {
    TitleAliment_Center,
    TitleAliment_Left,
    TitleAliment_Right
};

@interface QHPopRightButtonView : QHBaseView

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, copy) UIColor *titleColor;

-(instancetype)initWithTitleArray:(NSArray *)array point:(CGPoint)point selectIndexBlock:(QHParamsCallback)selectIndexBlock;
-(instancetype)initWithTitleArray:(NSArray *)array cellHeight:(CGFloat)height titleAliment:(TitleAliment)aliment point:(CGPoint)point selectIndexBlock:(QHParamsCallback)selectIndexBlock;
-(void)show;
- (void)showInPoint: (CGPoint)point;

@end
