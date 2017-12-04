//
//  QHWithdrawViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/30.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewController.h"
#import "QHBankModel.h"

@interface QHWithdrawViewController : QHBaseViewController

@property (nonatomic, copy) NSString *usdBalance;
@property (nonatomic, copy) NSString *cnyBalance;
@property (nonatomic, strong) QHBankModel *model;

@end
