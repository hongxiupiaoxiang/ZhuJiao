//
//  UIImageView+QHImageViewExtension.h
//  藏宝商户版
//
//  Created by shaw on 16/11/30.
//  Copyright © 2016年 shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (QHImageViewExtension)

-(void)loadImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder;

-(void)loadPortraitWithUrl:(NSString *)url placeholder:(UIImage *)placeholder;

- (void)setImage: (UIImage *)image cornerRadius: (CGFloat)radius;

- (void)getImage: (UIImage *)image cornerRadius: (CGFloat)radius;

// 银行卡图标赋值
- (void)setImageWithBankName: (NSString *)bankName;
@end
