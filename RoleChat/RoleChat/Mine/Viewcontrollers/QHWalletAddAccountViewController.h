//
//  QHAddAccountViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewController.h"

typedef NS_ENUM(NSInteger,Step) {
    Step_One,
    Step_Two
};

@interface QHWalletAddAccountViewController : QHBaseViewController

@property (nonatomic, assign) Step step;

@end
