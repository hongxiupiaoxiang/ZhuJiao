//
//  UIImageView+QHImageViewExtension.m
//  藏宝商户版
//
//  Created by shaw on 16/11/30.
//  Copyright © 2016年 shaw. All rights reserved.
//

#import "UIImage+QHImageCategory.h"
#import "UIImageView+QHImageViewExtension.h"

@interface UIImageView (QHImageExtension)

@end

@implementation UIImageView (QHImageViewExtension)

-(void)loadImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder{
    if([url hasPrefix:@"http"] || [url hasPrefix:@"https"]){
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
    }else{
        NSString *wholeUrl = [NSString stringWithFormat:@"%@%@", QINIU_IMAGE_PREFIX, url];
        
        [self sd_setImageWithURL:[NSURL URLWithString:wholeUrl] placeholderImage:placeholder];
    }
}

-(void)loadPortraitWithUrl:(NSString *)url placeholder:(UIImage *)placeholder{
    if(!placeholder){
        placeholder = IMAGENAMED(@"default_icon");
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@&type=user&size=2",QINIU_IMAGE_PREFIX, url];
    
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
    
}

// 耗GPU
- (void)setImage: (UIImage *)image cornerRadius: (CGFloat)radius {
    self.image = image;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:
                       self.bounds cornerRadius:radius].CGPath;
    self.layer.mask = shapeLayer;
}


- (void)getImage: (UIImage *)image cornerRadius: (CGFloat)radius {
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        CGContextAddPath(c, path.CGPath);
        CGContextClip(c);
        [image drawInRect:rect];
        CGContextDrawPath(c, kCGPathFillStroke);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.image = img;
        });
    });
}

-(void)setImageWithURLs:(NSArray *)imgURLs placeHolder:(UIImage *)placeHolder {
    const char* queueLabel = "ImageDownloader";
    
    __block NSMutableArray* imgsArr = [NSMutableArray array];
    for(int i = 0 ; i != imgURLs.count; ++i)
        [imgsArr addObject:placeHolder];
    [self setImage:[UIImage imageWithImages:imgsArr]];
    
    dispatch_group_t dgt = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(queueLabel, DISPATCH_QUEUE_CONCURRENT);
    
    for(int i = 0; i != imgURLs.count; ++i) {
        dispatch_group_async(dgt, queue, ^{
            NSData* imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[imgURLs objectAtIndex:i]]];
            if(imgData && imgData.length != 0) {
                @synchronized (self) {
                    UIImage* image = [UIImage imageWithData:imgData];
                    if(image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [imgsArr replaceObjectAtIndex:i withObject:image];
                            [self setImage:[UIImage imageWithImages:imgsArr]];
                        });
                    }
                }
            }
        });
    }
    
    return ;
}
+(UIImageView*)initIconImageView:(UIView*)view frame:(CGRect)frame{
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:frame];
    [view addSubview:iconImageView];
    iconImageView.frame = frame;
    iconImageView.image = IMAGENAMED(@"RN_Icon");
    [[QHTools toolsDefault] setLayerAndBezierPathCutCircularWithView:iconImageView cornerRedii:frame.size.height/2];
    return iconImageView;
}
@end
