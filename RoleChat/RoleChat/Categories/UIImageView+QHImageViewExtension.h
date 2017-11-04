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

-(void)setImageWithURLs:(NSArray*)imgURLs placeHolder:(UIImage*)placeHolder;
+(UIImageView*)initIconImageView:(UIView*)view frame:(CGRect)frame;
@end