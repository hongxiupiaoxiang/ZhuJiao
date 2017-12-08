//
//  QHBaseViewController.h
//  RoleChat
//
//  Created by zfQiu on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BaseVCBlock)(id prama) ;
@interface QHBaseViewController : UIViewController
@property(nonatomic,copy) BaseVCBlock baseVCBlock;
@property(nonatomic,assign) NSInteger basePage;
@property(nonatomic,strong) NSMutableArray * baseDataArray;
-(void)addLeftItem:(UIBarButtonItem *)barButtonItem complete:(void (^)(UIBarButtonItem *item))complete;
-(void)addRightItem:(UIBarButtonItem *)barButtonItem complete:(void (^)(UIBarButtonItem *item))complete;
-(void)addRightTitleItem:(NSString*)title sendBlock:(BaseVCBlock)sendBlock;
- (void)addRightTitleItem:(NSString *)title color:(UIColor *)color sendBlock:(BaseVCBlock)sendBlock;
-(void)addSubview:(UIView *)subview insets:(UIEdgeInsets)insets;

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions complete:(void (^)(NSInteger selIndex))complete;

-(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray *)actions complete:(void (^)(NSInteger selIndex))complete;
-(void)keyboardWillShow:(NSDictionary*)keyboardFrameInfo;
-(void)keyboardWillHide:(NSDictionary*)keyboardFrameInfo;
-(void)gotoBack;
@end
