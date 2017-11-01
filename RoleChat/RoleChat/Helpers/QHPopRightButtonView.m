//
//  QHPopRightButtonView.m
//  GoldWorld
//
//  Created by baijiang on 2017/6/9.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHPopRightButtonView.h"
@interface QHPopRightButtonView()
{
    CGPoint _point;
    CGFloat _width;
    NSInteger _showType;
}
@property(strong, nonatomic) UIView * maskView;
@property(strong, nonatomic)NSArray * titleArray;
@end
@implementation QHPopRightButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTitleArray:(NSArray *)array point:(CGPoint)point selectIndexBlock:(QHParamsCallback)selectIndexBlock{
    self = [super init];
    if (self) {
        //
        _selectIndex = -1;
        _titleArray = array;
        _point = point;
        self.paramsCallback = selectIndexBlock;
    }
    return self;
}
-(void)showCurrency{
    _showType = 2;
    [self show];
}
-(void)show{
    [self sortArray];
    self.layer.cornerRadius = 3;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.15f;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
    self.backgroundColor = WhiteColor;
    
    [Kwindow addSubview:self.maskView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self dismiss];
    }];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_maskView addGestureRecognizer:tap];
    
    self.frame = CGRectMake(_point.x, _point.y, _width, 44*(_titleArray.count));
    [Kwindow addSubview:self];
    for (int i =0; i<_titleArray.count;i++) {
        if (i > 0) {
            if (_showType == 2) {
                [[QHTools toolsDefault] addLineView:self :CGRectMake(15, 44*i-2.0/SCREEN_SCALE, _width-30, 2.0/SCREEN_SCALE)];
            }else{
                [[QHTools toolsDefault] addLineView:self :CGRectMake(0, 44*i-2.0/SCREEN_SCALE, _width, 2.0/SCREEN_SCALE)];
            }
        }

        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 3+44*i, _width, 38)];

        [self addSubview:button];
        button.backgroundColor = WhiteColor;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        button.tag = i+100;
        ButtonAddTarget(button, selectButton:)
        [button setTitleColor:BlackColor forState:UIControlStateNormal];
        if (_popViewType == MainColorType) {
            if (i == 0) {
                [button setTitleColor:MainColor forState:UIControlStateNormal];
            }else{
                [button setTitleColor:LightGrayTextColor forState:UIControlStateNormal];
            }
        }
        //
        if (i == self.selectIndex) {
            [button setTitleColor:MainColor forState:UIControlStateNormal];
        }
    }
    CGRect fitFram = self.frame;
    self.layer.anchorPoint = CGPointMake(1, 0);
    self.frame = fitFram;
    self.alpha = 0;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
    }];
}
-(void)sortArray{
    NSMutableArray * lengthArray = [NSMutableArray new];
    for (NSString * titles in _titleArray) {
        CGSize size = [titles boundingRectWithSize:CGSizeMake(MAXFLOAT, 34) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(14)} context:nil].size;
        [lengthArray addObject:@(ceil(size.width))];
    }
    NSArray *sortedArray = [lengthArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (obj1 > obj2) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    _width = [[sortedArray firstObject] floatValue]+5;
    if (_width < 120) {
        _width = 120;
    }
}
-(void)selectButton:(UIButton*)button{
    if (self.paramsCallback) {
    self.paramsCallback([NSString stringWithFormat:@"%ld",button.tag-100]);
    }
    [self dismiss];
}

-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    return _maskView;
}
-(void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [_maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
   
}

@end
