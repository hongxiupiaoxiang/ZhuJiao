//
//  QHPersonInfoViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/22.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDefaultTableViewController.h"
#import "QHRealmContactModel.h"

@interface QHPersonInfoViewController : QHDefaultTableViewController

@property (nonatomic, strong) QHRealmContactModel *contactModel;

@end
