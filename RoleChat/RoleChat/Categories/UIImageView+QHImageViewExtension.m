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

- (void)setImageWithBankName: (NSString *)bankName {
    if ([bankName containsString:@"农业银行"]) {
        self.image = IMAGENAMED(@"ABC");
    } else if ([bankName containsString:@"中国建设银行"]) {
        self.image = IMAGENAMED(@"CCB");
    } else if ([bankName containsString:@"招商银行"]) {
        self.image = IMAGENAMED(@"CMBC");
    } else if ([bankName containsString:@"中国银行"]) {
        self.image = IMAGENAMED(@"BC");
    } else if ([bankName containsString:@"工商银行"]) {
        self.image = IMAGENAMED(@"ICBC");
    } else if ([bankName containsString:@"交通银行"]) {
        self.image = IMAGENAMED(@"BCM");
    } else if ([bankName containsString:@"平安银行"]) {
        self.image = IMAGENAMED(@"PABC");
    } else if ([bankName containsString:@"浦发银行"]) {
        self.image = IMAGENAMED(@"SPDB");
    } else if ([bankName containsString:@"邮政储蓄银行"]) {
        self.image = IMAGENAMED(@"PSBC");
    } else if ([bankName containsString:@"华夏银行"]) {
        self.image = IMAGENAMED(@"HXB");
    } else if ([bankName containsString:@"杭州银行"]) {
        self.image = IMAGENAMED(@"HZB");
    } else if ([bankName containsString:@"大连银行"]) {
        self.image = IMAGENAMED(@"DLB");
    } else if ([bankName containsString:@"北京银行"])  {
        self.image = IMAGENAMED(@"BJB");
    } else if ([bankName containsString:@"民生银行"]) {
        self.image = IMAGENAMED(@"CMBC-1");
    } else if ([bankName containsString:@"中信银行"]) {
        self.image = IMAGENAMED(@"CCB-1");
    } else if ([bankName containsString:@"光大银行"]) {
        self.image = IMAGENAMED(@"CEB");
    } else if ([bankName containsString:@"兴业银行"]) {
        self.image = IMAGENAMED(@"HSBC");
    } else if ([bankName containsString:@"泰隆商业银行"]) {
        self.image = IMAGENAMED(@"ZJB");
    } else if ([bankName containsString:@"天津银行"]) {
        self.image = IMAGENAMED(@"TJB");
    } else if ([bankName containsString:@"发展银行"]) {
        self.image = IMAGENAMED(@"SJB");
    } else if ([bankName containsString:@"上海银行"]) {
        self.image = IMAGENAMED(@"SHB");
    } else if ([bankName containsString:@"农商银行"]) {
        self.image = IMAGENAMED(@"SRCB");
    }
}

@end
