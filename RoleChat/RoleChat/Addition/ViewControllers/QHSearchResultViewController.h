//
//  QHSearchResultViewController.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewController.h"
#import "QHRealmContactModel.h"

@interface QHSearchResultViewController : QHBaseViewController

@property (nonatomic, copy) NSString *searchContent;
@property (nonatomic, strong) NSArray<QHRealmContactModel *> *models;

@end
