//
//  QHAddAccountViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDefaultTableViewController.h"
#import "QHBankModel.h"

@protocol QHWalletAddAccountDelegate<NSObject>

- (void)addBankAccount: (QHBankModel *)model;

@end

@interface QHWalletAddAccountViewController : QHDefaultTableViewController

@property (nonatomic, copy) NSString *accountNumber;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, assign) BOOL isFirstCard;
@property (nonatomic, assign) id<QHWalletAddAccountDelegate> delegate;

@end
