//
//  QHModeSelectedView.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/10.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHModeSelectedView.h"

#define BASE_TAG 666

@interface QHModeSelectedView ()

@end

@implementation QHModeSelectedView {
    NSString *_title;
    NSString *_keyword;
    NSArray *_contentTitles;
    NSArray *_detailTitles;
    QHParamsCallback _selectedCallback;
    UILabel *_titleLabel;
    UIButton *_showBtn;
    NSInteger _lastSelectIndex;
}

- (instancetype)initWithTitle: (NSString *)title contentTitles: (NSArray *)contentTitles  detailTitles: (NSArray *)detailTitles keyword: (NSString *)keyword selectedCallback: (QHParamsCallback)selectedCallback selectedIndex: (NSInteger)selectedIndex {
    if (self = [super init]) {
        _title = title;
        _keyword = keyword;
        _contentTitles = contentTitles;
        _detailTitles = detailTitles;
        _lastSelectIndex = 0;
        self.selectedIndex = selectedIndex;
        _selectedCallback = selectedCallback;
        [self defalutConfig];
        [self setupUI];
    }
    return self;
}

- (void)defalutConfig {
    self.titleFont = 15;
    self.showBtnFont = 14;
    self.contentTitleFont = 15;
    self.detailTitleFont = 12;
    self.titleHeight = 60;
    self.contentHeight = 70;
}

- (BOOL)isShow {
    return _showBtn.isSelected;
}

- (void)showOfFolder {
    [_showBtn sendActionsForControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setupUI {
    _titleLabel = [UILabel labelWithFont:self.titleFont color:RGB52627C];
    _titleLabel.text = _title;
    [self addSubview:_titleLabel];
    
    _showBtn = [[UIButton alloc] init];
    [_showBtn addTarget:self action:@selector(showMenu:) forControlEvents:(UIControlEventTouchUpInside)];
    _showBtn.titleLabel.font = FONT(self.showBtnFont);
    [_showBtn setTitleColor:RGB939EAE forState:(UIControlStateNormal)];
    [_showBtn setTitle:QHLocalizedString(@"展开", nil) forState:(UIControlStateNormal)];
    [_showBtn setTitle:QHLocalizedString(@"收起", nil) forState:(UIControlStateSelected)];
    [_showBtn setImage:IMAGENAMED(@"Arrow_down") forState:(UIControlStateNormal)];
    [_showBtn setImage:IMAGENAMED(@"Arrow_up") forState:(UIControlStateSelected)];
    [_showBtn sizeToFit];
    
    [self addSubview:_showBtn];
    
    for (NSInteger i = 0; i < _contentTitles.count; i++) {
        UIButton *selectBtn = [[UIButton alloc] init];
        [selectBtn setImage:IMAGENAMED(@"Auto_selected") forState:(UIControlStateSelected)];
        [selectBtn setImage:IMAGENAMED(@"Auto_unselected") forState:(UIControlStateNormal)];
        selectBtn.tag = BASE_TAG+i*4+0;
        [self addSubview:selectBtn];
        
        
        UILabel *contentTitleLabel = [UILabel labelWithFont:self.contentTitleFont color:RGB52627C];
        contentTitleLabel.text = _contentTitles[i];
        contentTitleLabel.tag = BASE_TAG+i*4+1;
        [self addSubview:contentTitleLabel];
        
        UILabel *contentDetailLabel = [UILabel labelWithFont:self.detailTitleFont color:RGB939EAE];
        NSString *orignText = _detailTitles[i];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:orignText];
        [attr addAttribute:NSForegroundColorAttributeName value:MainColor range:[orignText rangeOfString:_keyword]];
        contentDetailLabel.attributedText = attr;
        contentDetailLabel.tag = BASE_TAG+i*4+2;
        [self addSubview:contentDetailLabel];
        
        UIButton *cellBtn = [[UIButton alloc] init];
        cellBtn.tag = BASE_TAG+i*4+3;
        [cellBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cellBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:cellBtn];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    // 非初始化赋值
    if (selectedIndex > 0) {
        if (selectedIndex == _lastSelectIndex) {
            UIButton *selectedBtn = [self viewWithTag:BASE_TAG+(selectedIndex-1)*4];
            selectedBtn.selected = !selectedBtn.isSelected;
            
            if (_selectedCallback) {
                _selectedCallback(selectedBtn.isSelected ? @(selectedIndex) : 0);
            }
        } else {
            if (_lastSelectIndex > 0) {
                UIButton *lastBtn = [self viewWithTag:BASE_TAG+(_lastSelectIndex-1)*4];
                lastBtn.selected = NO;
            }
            
            UIButton *currentBtn = [self viewWithTag:BASE_TAG+(selectedIndex-1)*4];
            currentBtn.selected = YES;
            if (_selectedCallback) {
                _selectedCallback(@(selectedIndex));
            }
        }
        _lastSelectIndex = selectedIndex;
    } else {
        for (NSInteger i = 0; i < _contentTitles.count; i++) {
            UIButton *btn = [self viewWithTag:BASE_TAG+i*4+0];
            btn.selected = NO;
        }
    }
}

- (void)btnClick: (UIButton *)sender {
    self.selectedIndex = (sender.tag-3-BASE_TAG)/4+1;
}

- (void)showMenu: (UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    CGRect frame = self.frame;
    if (sender.isSelected) {
        frame.size.height = self.titleHeight+_contentTitles.count*self.contentHeight;
    } else {
        frame.size.height = self.titleHeight;
    }
    self.frame = frame;
    if (self.folderBlock) {
        self.folderBlock();
    }
}

- (void)drawRect:(CGRect)rect {
    _titleLabel.font = FONT(self.titleFont);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(15);
        make.centerY.equalTo(self.mas_top).mas_offset(self.titleHeight*0.5);
    }];
    
    _showBtn.titleLabel.font = FONT(self.showBtnFont);
    _showBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _showBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_showBtn.currentImage.size.width-2.5, 0, _showBtn.currentImage.size.width+2.5);
    _showBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _showBtn.titleLabel.size.width+2.5, 0, -_showBtn.titleLabel.size.width-2.5);
    
    [_showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-15);
        make.centerY.equalTo(self.mas_top).mas_offset(self.titleHeight*0.5);
    }];
    
    for (NSInteger i = 0; i < _contentTitles.count; i++) {
        
        CGFloat percentage = self.contentHeight*1.0/70;
        
        UIButton *checkBtn = [self viewWithTag:BASE_TAG+4*i+0];
        [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(15);
            make.top.equalTo(self).mas_offset(self.titleHeight+i*self.contentHeight+18*percentage);
        }];
        
        UILabel *contentLabel = [self viewWithTag:BASE_TAG+4*i+1];
        contentLabel.font = FONT(self.contentTitleFont);
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(checkBtn.mas_right).mas_offset(15);
            make.top.equalTo(self).mas_offset(self.titleHeight+i*self.contentHeight+20*percentage);
        }];
        
        UILabel *detailLabel = [self viewWithTag:BASE_TAG+4*i+2];
        detailLabel.font = FONT(self.detailTitleFont);
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentLabel);
            make.top.equalTo(contentLabel.mas_bottom).mas_offset(7*percentage);
        }];
        
        UIButton *cellBtn = [self viewWithTag:BASE_TAG+4*i+3];
        [cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(self.titleHeight+i*self.contentHeight);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(self.contentHeight);
        }];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
