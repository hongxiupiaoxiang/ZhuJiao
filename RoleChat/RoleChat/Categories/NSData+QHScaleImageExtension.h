//
//  NSData+QHScaleImageExtension.h
//  GoldWorld
//
//  Created by zfqiu on 2017/5/15.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (QHScaleImageExtension)

// 聊天图片压处理
+ (NSData *)imageData:(UIImage *)myimage;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
@end
