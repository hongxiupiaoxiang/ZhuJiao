//
//  UIImage+GIF.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/29.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "UIImage+QHImageCategory.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (QHImageCategory)

+(instancetype)gifImageWithPath:(NSString *)path {
    
    NSData* gifData = [NSData dataWithContentsOfFile:path];
    if(gifData == nil)
        return nil;
    
    CGImageSourceRef gifSrc = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    size_t frameCount = CGImageSourceGetCount(gifSrc);
    
    if(frameCount <= 1) {
        CGImageRef img = CGImageSourceCreateImageAtIndex(gifSrc, 0, NULL);
        UIImage* staticImg = [UIImage imageWithCGImage:img];
        
        CGImageRelease(img);
        CFRelease(gifSrc);
        
        return staticImg;
    }
    
    NSMutableArray* imagesArray = [NSMutableArray arrayWithCapacity:frameCount];
    NSTimeInterval duration = 1.0f / 10.0f * frameCount;
    for(int i = 0 ; i != frameCount; ++i) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(gifSrc, i, NULL);
        [imagesArray addObject:[UIImage imageWithCGImage:image]];
        CGImageRelease(image);
    }
    
    CFRelease(gifSrc);
    return [UIImage animatedImageWithImages:imagesArray duration:duration];
}

+(UIImage*)imageWithImages:(NSArray *)images {
    
#define kGapInterImage 2
#define kImagesPerLine 2
    
    int imagesPerLine = images.count < kImagesPerLine ? (int)images.count : kImagesPerLine;
    CGSize imageSize = CGSizeMake(kGapInterImage * (imagesPerLine - 1), kGapInterImage * ((images.count - 1) / kImagesPerLine));
    CGFloat avgWidth = 0.0f, avgHeight = 0.0f;
    
    for (UIImage* image in images)
        avgWidth += image.size.width, avgHeight += image.size.height;
    imageSize.width += (avgWidth /= images.count, avgWidth * imagesPerLine); imageSize.height += (avgHeight /= images.count, avgHeight * (((images.count - 1) / imagesPerLine) + 1));
    
    UIGraphicsBeginImageContext(imageSize);
    
    for(int i = 0; i < images.count; ++i)
    {
        UIImage* image = (UIImage*)[images objectAtIndex:i];
        CGSize preSize = CGSizeZero;
        
        int preH = 0, preV = 0;
        for(int j = (i / imagesPerLine) * imagesPerLine; j < i; ++j)
            preSize.width += avgWidth, ++preH;
        for(int j = i % imagesPerLine; j < i; j += imagesPerLine)
            preSize.height += avgHeight, ++preV;
        
        [image drawInRect:CGRectMake(preSize.width + preH * kGapInterImage, preSize.height + preV * kGapInterImage, avgWidth, avgHeight)];
    }
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+(UIImage*)imageWithImageTitles:(NSArray *)imageTitles {
    NSMutableArray* imagesArr = [NSMutableArray array];
    for (NSString* imageTitle in imageTitles) {
        UIImage* image = [UIImage imageNamed:imageTitle];
        [imagesArr addObject:image];
    }
    return [UIImage imageWithImages:imagesArr];
}

+(UIImage*)imageNamed:(NSString *)name inBundle:(NSString *)inBundle withLocale:(NSString *)locale {
    NSString* path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle/%@", inBundle, locale]];
    UIImage* image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:name]];
    
    if(image == nil) {
        NSString* path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle/%@", inBundle, @"en"]];
        image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:name]];
    }
    
    return image;
}

+(UIImage *)scaleImage:(UIImage *)image size: (CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size,NO,SCREEN_SCALE);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
