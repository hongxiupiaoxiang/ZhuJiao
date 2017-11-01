//
//  UIImage+GIF.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/29.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QHImageCategory)

+(instancetype)gifImageWithPath:(NSString*)path;
+(UIImage*)imageWithImageTitles:(NSArray*)imageTitles;
+(UIImage*)imageWithImages:(NSArray *)images;
+(UIImage*)imageNamed:(NSString *)name inBundle:(NSString*)inBundle withLocale:(NSString*)locale;

// 聊天图片缩处理
+(UIImage *)scaleImage:(UIImage *)image size: (CGSize)size;

@end
