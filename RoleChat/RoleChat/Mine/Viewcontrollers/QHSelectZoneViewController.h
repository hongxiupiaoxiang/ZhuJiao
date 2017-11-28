//
//  QHSelectZoneViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/28.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHDefaultTableViewController.h"
#import "QHZoneCodeModel.h"

@interface QHSelectZoneViewController : QHDefaultTableViewController

@property (nonatomic, copy) NSArray<QHZoneCodeModel *>* zoneCodesArray;

@end
