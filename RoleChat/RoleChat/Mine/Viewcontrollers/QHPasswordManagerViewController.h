//
//  QHPasswordManagerViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/1.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewController.h"

typedef NS_ENUM(NSInteger) {
    Password_Login,
    Password_Pay
} Password;

@interface QHPasswordManagerViewController : QHBaseViewController

@property (nonatomic, assign) Password passwordType;

@end
