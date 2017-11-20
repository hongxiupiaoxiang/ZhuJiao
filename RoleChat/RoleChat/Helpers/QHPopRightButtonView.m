//
//  QHPopRightButtonView.m
//  RoleChat
//
//  Created by zfQiu on 2017/11/20.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHPopRightButtonView.h"
@interface QHPopRightButtonView()

@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation QHPopRightButtonView {
    CGPoint _point;
    CGFloat _width;
    TitleAliment _aliment;
    CGFloat _cellHight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTitleArray:(NSArray *)array  point:(CGPoint)point selectIndexBlock:(QHParamsCallback)selectIndexBlock{
    self = [super init];
    if (self) {
        _titleArray = array;
        _point = point;
        _cellHight = 44;
        self.paramsCallback = selectIndexBlock;
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithTitleArray:(NSArray *)array cellHeight:(CGFloat)height titleAliment:(TitleAliment)aliment point:(CGPoint)point selectIndexBlock:(QHParamsCallback)selectIndexBlock {
    self = [super init];
    if (self) {
        _titleArray = array;
        _point = point;
        _cellHight = height;
        self.paramsCallback = selectIndexBlock;
        _aliment = aliment;
        [self setupUI];
    }
    return self;
}

- (void)showInPoint: (CGPoint)point {
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
    [self show];
}

- (void)show {
    [Kwindow addSubview:self.maskView];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
    }];
    self.isShow = YES;
}

- (void)setupUI {
    [self sortArray];
    self.layer.cornerRadius = 3;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.15f;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowColor = UIColorFromRGB(0x3d5276).CGColor;
    self.backgroundColor = WhiteColor;
    
    WeakSelf
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf dismiss];
    }];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.maskView addGestureRecognizer:tap];
    
    self.frame = CGRectMake(_point.x, _point.y, _width, _cellHight*(_titleArray.count));
    [_maskView addSubview:self];
    for (int i =0; i<_titleArray.count;i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 3+_cellHight*i, _width, 38)];
        [self addSubview:button];
        button.backgroundColor = WhiteColor;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14);
        button.tag = i+100;
        ButtonAddTarget(button, selectButton:)
        [button setTitleColor:RGB52627C forState:UIControlStateNormal];
        if (_aliment == TitleAliment_Left) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        }
    }
    CGRect fitFram = self.frame;
    self.layer.anchorPoint = CGPointMake(0.5, 0);
    self.frame = fitFram;
    self.alpha = 0;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
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
    self.isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [_maskView removeFromSuperview];
    }];
   
}

@end
