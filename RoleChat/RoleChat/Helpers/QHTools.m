//
//  QHTools.m
//  GoldWorld
//
//  Created by baijiang on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "QHTools.h"
#import "QHZoneCodeModel.h"

#define kDefaultExpireDate 15


@interface QHTools()

@property (nonatomic, copy) NSArray *zoneCodesArray;
@property (nonatomic, copy) NSString *zone;

@end

@implementation QHTools

+(QHTools *)toolsDefault{
    QHTools * tools =[[QHTools alloc] init];
    return tools;
}
//圆角
- (void)setLayerAndBezierPathCutCircularWithView:(UIView *)view cornerRedii:(CGFloat)cornerRedii
{
    //方式一
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRedii, cornerRedii)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;

}
//上下文圆角 
-(void)setContexCornered:(UIImageView *)view cornerRedii:(CGFloat)cornerRedii{
        //方式二
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
        [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRedii] addClip];
        [view drawRect:view.bounds];
        view.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
}
//添加线
-(UIView*)addLineView:(UIView *)view :(CGRect)fram
{
    UIView * lineView = [[UIView alloc] initWithFrame:fram];
    lineView.backgroundColor = UIColorFromRGB(0xf0f1f5);
    [view addSubview:lineView];
    
    return lineView;
}

//添加箭头
-(UIButton *)addArrowButton:(UIView *)view :(CGRect)fram{
    
    UIButton * arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(fram.origin.x, fram.origin.y, 8, 12)];
    [view addSubview:arrowBtn];
    [arrowBtn setImage:IMAGENAMED(@"common_arrow") forState:UIControlStateNormal];
    arrowBtn.userInteractionEnabled = NO;
     return arrowBtn;
}

//序列化cookie
-(void)serializeCookieForResponse:(NSHTTPURLResponse*)response {
    NSDictionary* headerFields = [response allHeaderFields];
    NSArray* cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:headerFields forURL:response.URL];
    NSDictionary* requestFields=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:[requestFields objectForKey:@"Cookie"] forKey:kUserMoreInfoCookieKey];
    
    return ;
}

//生成二维码
-(UIImage*)generateQRCodeWithString:(NSString *)string {
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    
    return [UIImage imageWithCIImage:[filter outputImage]];
}


- (QHBaseViewController *)getCurrentVCWithView: (UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[QHBaseViewController class]]) {
            return (QHBaseViewController *)nextResponder;
        }
    }
    return nil;
}

//hud
-(void)showHUDWithMode:(MBProgressHUDMode)mode title:(NSString *)title hideDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:Kwindow];
    hud.mode = mode;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.offset = CGPointMake(0, 0);
    [Kwindow addSubview:hud];
    [hud showAnimated:YES];
    
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
}
//添加右箭头
-(UIImageView*)addCellRightView:(UIView*)view point: (CGPoint)point {
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, 8, 13)];
    rightView.image = IMAGENAMED(@"common_arrow");
    [view addSubview:rightView];
    return rightView;
}

-(void)hideHUD{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:Kwindow];
    [hud hideAnimated:YES];
}
-(CGFloat)getFitWidth:(NSString*)title height:(CGFloat)height font:(CGFloat)font{
    CGSize fitSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT(font)} context:nil].size;
    return ceilf(fitSize.width);
}
-(CGFloat)getFitHeight:(NSString*)title width:(CGFloat)width font:(CGFloat)font{
    CGSize fitSize = [title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT(font)} context:nil].size;
    return ceilf(fitSize.height);
}

- (void)showFailureMsgWithResponseObject: (id)responseObject {
    NSString *msg;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        msg = responseObject[@"msg"];
        if (msg == nil) {
            msg = responseObject[@"data"];
        }
    } else if ([responseObject isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)responseObject;
        msg = error.localizedDescription;
    } else {
        msg = QHLocalizedString(@"接口请求失败,请重试", nil);
    }
    [[QHTools toolsDefault] showHUDWithMode:MBProgressHUDModeText title:msg hideDelay:1.5];
}
+(CGSize)getFitSizeWithString:(NSString*)string font:(CGFloat)font height:(CGFloat)height width:(CGFloat)width{
    CGFloat fit_width = [[QHTools toolsDefault] getFitWidth:string height:height font:font];
    if (fit_width > width) {
        CGFloat fit_height = [[QHTools toolsDefault] getFitHeight:string width:width font:font];
        return CGSizeMake(width, fit_height);
    }else{
        return CGSizeMake(fit_width, height);
    }
}


- (void)getZoneCodeWithCallback: (QHParamsCallback)callback {
    if([self loadZoneCode] == NO) {
        WeakSelf
        [QHZoneCodeModel getGlobalParamWithGroup:Group_PhoneCode lastUpdateDate:[NSString stringWithFormat:@"%lu",(unsigned long)[[NSDate date] toTimeIntervalSince1970]] successBlock:^(NSURLSessionDataTask *task, id responseObject) {
            weakSelf.zoneCodesArray = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[responseObject[@"data"] valueForKey:[QHLocalizable currentLocaleShort]]];
            [weakSelf cacheZoneCode];
            if (callback) {
                callback(weakSelf.zone);
            }
        } failure:^(NSURLSessionDataTask *task, id responseObject) {
            if (callback) {
                callback(weakSelf.zone);
            }
        }];
    } else {
        if (callback) {
            callback(self.zone);
        }
    }
}

-(BOOL)loadZoneCode {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"zoneCode_%@", [QHLocalizable currentLocaleShort]]];
    
    if([fileManager fileExistsAtPath:filePath] == YES) {
        NSDate* expireDate = (NSDate*)[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"expireDate_%@", [QHLocalizable currentLocaleShort]]];
        CGFloat expireTime = ABS([[NSDate date] timeIntervalSinceDate:expireDate]) / (24 * 60 * 60);
        if(expireTime <= kDefaultExpireDate) {
            NSArray *zoneArr = [NSArray modelArrayWithClass:[QHZoneCodeModel class] json:[NSArray arrayWithContentsOfFile:filePath]];
            for (QHZoneCodeModel *model in zoneArr) {
                NSLog(@"%@",model.code);
                if ([model.code isEqualToString:[QHPersonalInfo sharedInstance].userInfo.phoheCode]) {
                    self.zone = [[model.value componentsSeparatedByString:@")"] lastObject];
                    break;
                }
            }
            return YES;
        }
        else
            [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

-(void)cacheZoneCode {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"zoneCode_%@", [QHLocalizable currentLocaleShort]]];
    if([fileManager fileExistsAtPath:filePath] == NO) {
        NSMutableArray *dictArr = [[NSMutableArray alloc] init];
        for (QHZoneCodeModel *model in self.zoneCodesArray) {
            NSDictionary *dict = [model modelToJSONObject];
            [dictArr addObject:dict];
            if ([model.code isEqualToString:[QHPersonalInfo sharedInstance].userInfo.phoheCode]) {
                self.zone = [[model.value componentsSeparatedByString:@")"] lastObject];
            }
        }
        
        [dictArr writeToFile:filePath atomically:YES];
        //过期时间
        [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:[NSString stringWithFormat:@"expireDate_%@", [QHLocalizable currentLocaleShort]]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
