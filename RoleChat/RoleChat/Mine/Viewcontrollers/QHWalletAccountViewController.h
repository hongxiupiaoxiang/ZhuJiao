//
//  QHWalletAccountViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDefaultTableViewController.h"

typedef NS_ENUM(NSInteger,WalletType) {
    WalletType_Show,    // 展示银行卡
    WalletType_Choose   // 选择银行卡
};

@interface QHWalletAccountViewController : QHDefaultTableViewController

@property (nonatomic, assign) WalletType type;

@end
