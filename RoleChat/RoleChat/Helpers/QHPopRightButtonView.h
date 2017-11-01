//
//  QHPopRightButtonView.h
//  GoldWorld
//
//  Created by baijiang on 2017/6/9.
//  Copyright © 2017年 qhspeed. All rights reserved.
//
#import "QHBaseView.h"

typedef NS_ENUM(NSInteger, QHpopViewType) {
    BlackColorType,  
    MainColorType
};

@interface QHPopRightButtonView : QHBaseView
@property(assign ,nonatomic) QHpopViewType popViewType;
@property (nonatomic, assign) NSInteger selectIndex;
-(instancetype)initWithTitleArray:(NSArray *)array point:(CGPoint)point selectIndexBlock:(QHParamsCallback)selectIndexBlock;
-(void)show;
-(void)showCurrency;
@end
