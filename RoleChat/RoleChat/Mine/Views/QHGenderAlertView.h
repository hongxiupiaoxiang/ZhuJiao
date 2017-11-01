//
//  QHGenderAlertView.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/31.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseView.h"

@interface QHGenderAlertView : QHBaseView

- (instancetype)initWithGender: (NSString *)gender callbackBlock: (QHNoParamCallback)callBack;

- (void)show;

@end
