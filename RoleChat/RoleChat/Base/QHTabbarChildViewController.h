//
//  QHTabbarChildViewController.h
//  GoldWorld
//
//  Created by zfQiu on 2017/3/15.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseViewController.h"

@interface QHTabbarChildViewController : QHBaseViewController

-(void)willUpdateData;
-(void)setupUI;

@end

@interface QHTabbarChildViewController ()

@property(nonatomic, copy) NSString* tabTitleKey;

@end
