//
//  UIApplication+QHLogout.h
//  ShareMedianet
//
//  Created by 王落凡 on 2017/8/18.
//  Copyright © 2017年 qhsj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (QHLogout)

-(void)logoutWithSuccess:(RequestCompletedBlock)success failure:(RequestCompletedBlock)failure;

@end
