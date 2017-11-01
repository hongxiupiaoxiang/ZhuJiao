//
//  UIApplication+QHLogout.m
//  ShareMedianet
//
//  Created by 王落凡 on 2017/8/18.
//  Copyright © 2017年 qhsj. All rights reserved.
//

#import "UIApplication+QHLogout.h"

@implementation UIApplication (QHLogout)

-(void)logoutWithSuccess:(RequestCompletedBlock)success failure:(RequestCompletedBlock)failure
{
    [App_Delegate.window showHUD];
//    [[[QHLoginRequest alloc] init] logoutWithSuccess:^(NSURLSessionTask *task, id responseObject) {
//        [QHPushServices services].alias = nil;
//        [[QHPushServices services] unRegistAllDelegate];
//        
//        [App_Delegate.window hideHUD];
//        if(success)
//            success();
//        return ;
//    } Failure:^(NSURLSessionTask *task, NSError *error) {
//        [App_Delegate.window hideHUD];
//        if(failure)
//            failure();
//    }];
}

@end
