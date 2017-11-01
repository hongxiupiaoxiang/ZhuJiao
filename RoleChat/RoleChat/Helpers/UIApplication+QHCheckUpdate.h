//
//  UIApplication+QHCheckUpdate.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/14.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

@interface UIApplication (QHCheckUpdate)

-(void)checkUpdateWithSuccess:(RequestCompletedBlock)success Failure:(RequestCompletedBlock)Failure;

@end
