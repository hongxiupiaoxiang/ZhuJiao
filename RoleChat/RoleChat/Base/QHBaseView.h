//
//  QHBaseView.h
//  RoleChat
//
//  Created by zfQiu on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^QHNoParamCallback)();
typedef void (^QHParamsCallback)(id params);

@interface QHBaseView : UIView

@property (nonatomic, copy) QHNoParamCallback noParamCallback;
@property (nonatomic, copy) QHParamsCallback paramsCallback;
@property (nonatomic, assign) BOOL enableBackgroundTap;

-(void)backgroundTapped;
-(void)setupView;
@end
