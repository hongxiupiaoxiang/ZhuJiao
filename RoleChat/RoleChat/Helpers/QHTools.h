//
//  QHTools.h
//  GoldWorld
//
//  Created by baijiang on 2017/3/8.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^QHTollsBlock)(id prama);
@interface QHTools : NSObject
@property(copy ,nonatomic)QHTollsBlock toolsBlock;
+(QHTools *)toolsDefault;
//圆角
- (void)setLayerAndBezierPathCutCircularWithView:(UIView *)view cornerRedii:(CGFloat)cornerRedii;
//上下文圆角
-(void)setContexCornered:(UIImageView *)view cornerRedii:(CGFloat)cornerRedii;
//添加线
-(UIView*)addLineView:(UIView *)view :(CGRect)fram;
//添加粗灰线
-(UIView*)addlightGrayBoldLineView:(UIView *)view :(CGRect)fram;
//添加粗黑透明线
-(UIView*)addBoldLineView:(UIView *)view :(CGRect)fram;
//添加箭头
-(UIButton *)addArrowButton:(UIView *)view :(CGRect)fram;
//序列化cookie
-(void)serializeCookieForResponse:(NSHTTPURLResponse*)response;
//二维码生成
-(UIImage*)generateQRCodeWithString:(NSString*)string;
//生成背景scrollView
-(UIScrollView*)addBGScrollView:(UIView*)view;
//添加右箭头
-(UIImageView*)addCellRightView:(UIView*)view point: (CGPoint)point;

//获取当前第一响应控制器
- (QHBaseViewController *)getCurrentVCWithView: (UIView *)view;
-(void)inputPasswordTimes:(id)responseObject buyType:(NSInteger)buyType viewController:(UIViewController *)viewController successBloc:(QHTollsBlock)successBloc failBlock:(QHTollsBlock)failBlock;
//发送验证码
-(BOOL)getCode;
//hud
-(void)showHUDWithMode:(MBProgressHUDMode)mode title:(NSString *)title hideDelay:(NSTimeInterval)delay;
-(void)hideHUD;
//自适应宽高
-(CGFloat)getFitWidth:(NSString*)title height:(CGFloat)height font:(CGFloat)font;
-(CGFloat)getFitHeight:(NSString*)title width:(CGFloat)width font:(CGFloat)font;
// 网络请求失败回调
- (void)showFailureMsgWithResponseObject: (id)responseObject;
//自适应宽高
+(CGSize)getFitSizeWithString:(NSString*)string font:(CGFloat)font height:(CGFloat)height width:(CGFloat)width;
@end
