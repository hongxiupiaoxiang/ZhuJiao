//
//  QHBaseTabBar.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseTabBar.h"

#define kBaseTag 1000

@implementation QHBaseTabbarHostTabbar

-(void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView* subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UITabBarButton")])
            [subView removeFromSuperview];
        else
            subView.frame = self.bounds;
    }
    
    return ;
}

@end

@implementation QHTabbarButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setContentMode:UIViewContentModeCenter];
        [self.imageView setContentMode:UIViewContentModeCenter];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    [self.imageView sizeToFit];
    self.imageView.frame = CGRectMake(0, 10, 20, 20);
    self.imageView.center = CGPointMake(self.bounds.size.width / 2, 20);
    self.titleLabel.frame = CGRectMake(0, 35, self.titleLabel.size.width, self.titleLabel.size.height);
    self.titleLabel.center = CGPointMake(self.bounds.size.width / 2, self.titleLabel.center.y);
    [self.titleLabel setTextColor:BtnClickColor];
    self.titleLabel.font = FONT(11);
    return ;
}

@end

@interface QHTabbarButtonItem : QHTabbarButton

@end

@implementation QHTabbarButtonItem

+(instancetype)buttonWithType:(UIButtonType)buttonType {
    QHTabbarButtonItem* instance = [super buttonWithType:buttonType];
    [instance setExclusiveTouch:YES];
    
    return instance;
}

-(void)setHighlighted:(BOOL)highlighted {
    return [super setHighlighted:NO];
}

@end

@interface QHBaseTabBar ()

@property(nonatomic, strong) NSMutableArray* items;

@end

@implementation QHBaseTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _innerButton = [[QHTabbarButton alloc] init];
        _items = [NSMutableArray array];
        _selectedIndex = -1;
        
        [self addSubview:_innerButton];
    }
    return self;
}

-(void)addTabBarItem:(UITabBarItem *)tabBarItem {
    QHTabbarButtonItem* tabbarButtonItem = [QHTabbarButtonItem buttonWithType:UIButtonTypeCustom];
    [tabbarButtonItem setTitle:tabBarItem.title forState:UIControlStateNormal];
    [tabbarButtonItem setImage:tabBarItem.image forState:UIControlStateNormal];
    [tabbarButtonItem setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
    [tabbarButtonItem setTitleColor:MainColor forState:UIControlStateSelected];
    [tabbarButtonItem setTitleColor:BtnClickColor forState:UIControlStateNormal];
    [tabbarButtonItem.titleLabel setFont:FONT(11.0f)];
    [tabbarButtonItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    tabbarButtonItem.tag = _items.count + kBaseTag;
    [self addSubview:tabbarButtonItem];
    
    [tabBarItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:(__bridge void*)tabbarButtonItem];
    
    [_items addObject:tabBarItem];
    [self layoutIfNeeded];
    if(_selectedIndex == -1)
        [self itemSelected:tabbarButtonItem];
    return ;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    if(selectedIndex > _items.count)
        return ;
    
    _selectedIndex = selectedIndex;
    for (QHTabbarButtonItem* item in self.subviews) {
        item.selected = NO;
        if(item.tag == selectedIndex + kBaseTag) {
            item.selected = YES;
        }
    }
    
    UITabBarItem* tabbarItem = [_items objectAtIndex:selectedIndex];
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)])
        [self.delegate tabBar:self didSelectItem:tabbarItem];
    
    return ;
}

-(void)itemSelected:(QHTabbarButtonItem*)sender {
    for (QHTabbarButtonItem* item in self.subviews) {
        item.selected = NO;
        if([item isEqual:sender]) {
            item.selected = YES;
            _selectedIndex = sender.tag - kBaseTag;
        }
    }
    
    UITabBarItem* tabbarItem = [_items objectAtIndex:_selectedIndex];
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)])
        [self.delegate tabBar:self didSelectItem:tabbarItem];
    return ;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat tabItemWidth = self.bounds.size.width / self.items.count;
    NSInteger index = 0;
    
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:[QHTabbarButtonItem class]]) {
            subView.frame = CGRectMake(index * tabItemWidth, 0, tabItemWidth, self.bounds.size.height);
            index++;
        }
    }
}

-(void)setTitle:(NSString *)title forItemAtIndex:(NSInteger)index {
    UITabBarItem* tabbarItem = (UITabBarItem*)[_items objectAtIndex:index];
    tabbarItem.title = title;
    return ;
}

-(void)dealloc {
    for (UITabBarItem* item in _items)
        [item removeObserver:self forKeyPath:@"title"];
    return ;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    QHTabbarButtonItem* item = (__bridge QHTabbarButtonItem*)context;
    [item setTitle:change[NSKeyValueChangeNewKey] forState:UIControlStateNormal];
    return ;
}

@end
