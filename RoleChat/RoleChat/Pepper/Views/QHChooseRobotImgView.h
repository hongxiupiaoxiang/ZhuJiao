//
//  QHChooseRobotImgView.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/8.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

@interface QHChooseRobotImgView : QHBaseView

@property (nonatomic, assign) BOOL isCurrentImage;
@property (nonatomic, assign) BOOL isSelectImage;

- (instancetype)initWithImgStr: (NSString *)imgStr title: (NSString *)title imageCallback: (QHParamsCallback)callback;

@end
