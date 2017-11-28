//
//  QHBaseModel.m
//  RoleChat
//
//  Created by zfQiu on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseModel.h"

#define kLoginRequest   @"http://chilli.pigamegroup.com/user/applogin"
#define kLoginAuthority @"http://chilli.pigamegroup.com/user/authority"

@interface QHBaseModel()

@end
@implementation QHBaseModel

#pragma mark --网络请求
+(void)sendGETRequestWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params hudTitle:(NSString *)hudTitle beforeRequest:(RequestModifyBlock)modifyBlock  successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock {
    NSString * urlStr = nil;
    if(baseURL == nil)
        urlStr = [NSString stringWithFormat:@"%@/%@",QH_BASEURL,api];
    else
        urlStr = [NSString stringWithFormat:@"%@/%@",baseURL,api];
    
    [self sendRequestWithUrl:urlStr IsPost:NO isHud:YES hudTitle:nil params:params beforeRequest:^(AFHTTPSessionManager *manager) {
        if(modifyBlock){
            modifyBlock(manager);}
    } successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if(successBlock){
            successBlock(task , responseObject);}
    } failedBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if (failedBlock) {
            failedBlock(task,responseObject);
        }
    }];

}
+(void)sendGETRequestNoHudWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params  beforeRequest:(RequestModifyBlock)modifyBlock  successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock {
    NSString * urlStr = nil;
    if(baseURL == nil)
        urlStr = [NSString stringWithFormat:@"%@/%@",QH_BASEURL,api];
    else
        urlStr = [NSString stringWithFormat:@"%@/%@",baseURL,api];
    
    [self sendRequestWithUrl:urlStr IsPost:NO isHud:NO hudTitle:nil params:params beforeRequest:^(AFHTTPSessionManager *manager) {
        if(modifyBlock){
            modifyBlock(manager);}
    } successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if(successBlock){
            successBlock(task , responseObject);}
    } failedBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if (failedBlock) {
            failedBlock(task,responseObject);
        }
    }];
    
}
+(void)sendRequestWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params hudTitle:(NSString *)hudTitle beforeRequest:(RequestModifyBlock)modifyBlock successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock
{
    NSString * urlStr = nil;
    if(baseURL == nil)
        urlStr = [NSString stringWithFormat:@"%@/%@",QH_BASEURL,api];
    else
        urlStr = [NSString stringWithFormat:@"%@/%@",baseURL,api];
    
    [self sendRequestWithUrl:urlStr IsPost:YES isHud:YES hudTitle:nil params:params beforeRequest:^(AFHTTPSessionManager *manager) {
        if(modifyBlock){
            modifyBlock(manager);}
    } successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if(successBlock){
            successBlock(task , responseObject);}
    } failedBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if (failedBlock) {
            failedBlock(task,responseObject);
        }
    }];
    
}

+(void)sendPOSTRequestNoHudWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params  beforeRequest:(RequestModifyBlock)modifyBlock successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock
{
    NSString * urlStr = nil;
    if(baseURL == nil)
        urlStr = [NSString stringWithFormat:@"%@/%@",QH_BASEURL,api];
    else
        urlStr = [NSString stringWithFormat:@"%@/%@",baseURL,api];
    
    [self sendRequestWithUrl:urlStr IsPost:YES isHud:NO hudTitle:nil params:params beforeRequest:^(AFHTTPSessionManager *manager) {
        if(modifyBlock){
            modifyBlock(manager);}
    } successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if(successBlock){
            successBlock(task , responseObject);}
    } failedBlock:^(NSURLSessionDataTask *task, id responseObject) {
        if (failedBlock) {
            failedBlock(task,responseObject);
        }
    }];
    
}
+(void)sendRequestWithUrl:(NSString*)urlStr IsPost:(BOOL)isPost isHud:(BOOL)isHud hudTitle:(NSString *)hudTitle params:(NSDictionary *)params  beforeRequest:(RequestModifyBlock)modifyBlock successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock{
    WeakSelf
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer setValue:App_Delegate.uuidString forHTTPHeaderField:@"deviceId"];
    [manager.requestSerializer setValue:[QHLocalizable currentLocaleShort] forHTTPHeaderField:@"smallchilli-language"];
    if(modifyBlock){
        modifyBlock(manager);}
    if (isHud) {
       [self showHUDWithMode:MBProgressHUDModeIndeterminate title:hudTitle hideDelay:0];
    }
    if (isPost) {
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        DLog(@"%@",responseObject);
        if (isHud) {
            [weakSelf hideHUD];
        }
        if(QH_VALIDATE_REQUEST(responseObject)) {
            if(successBlock){
                successBlock(task , responseObject);}
        }
        else {
            NSString* resultCode = responseObject[@"resultCode"];
            NSString* msg = responseObject[@"msg"];
            if(resultCode) {
                if([resultCode isEqualToString:kNotLoggedinMsg] && ![urlStr isEqualToString:kLoginRequest] && ![urlStr isEqualToString:kLoginAuthority]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN_NOTI object:nil userInfo:@{@"resultCode" : resultCode, @"msg" : msg}];
                    return ;
                }
            }
            
            if(failedBlock)
                failedBlock(task, responseObject);
            if (isHud) {
                [weakSelf showHUDWithMode:MBProgressHUDModeText title:msg.length>0?msg:QHLocalizedString(@"请求服务器失败,请稍后!", nil) hideDelay:1.5f];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(task,error);
        }
        if (isHud) {
            [weakSelf hideHUD];
            [weakSelf showHUDWithMode:MBProgressHUDModeText title:error.localizedDescription.length>0?error.localizedDescription:QHLocalizedString(@"请求服务器失败,请稍后!", nil) hideDelay:1.5f];
        }
    }];
    }else{
        if(modifyBlock){
            modifyBlock(manager);}
        [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isHud) {
                 [weakSelf hideHUD];
            }
            //        DLog(@"%@",responseObject);
            if(QH_VALIDATE_REQUEST(responseObject)){
                if (successBlock) {
                    successBlock(task , responseObject);
                }
            }else {
                NSString* resultCode = responseObject[@"resultCode"];
                NSString* msg = responseObject[@"msg"];
                if(resultCode != nil && [resultCode isEqual: [NSNull null]] == NO) {
                    if([resultCode isEqualToString:kNotLoggedinMsg] || [resultCode isEqualToString:kTokenNotFoundMsg]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN_NOTI object:nil userInfo:@{@"resultCode" : resultCode, @"msg" : msg}];
                        return ;
                    }
                }
                if (isHud) {
                    [weakSelf showHUDWithMode:MBProgressHUDModeText title:msg.length>0?msg:QHLocalizedString(@"请求服务器失败,请稍后!", nil) hideDelay:1.5f];
                }
                if(failedBlock)
                    failedBlock(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failedBlock) {
                failedBlock(task,error);
            }
            if (isHud) {
                [weakSelf hideHUD];
                [weakSelf showHUDWithMode:MBProgressHUDModeText title:error.localizedDescription.length>0?error.localizedDescription:QHLocalizedString(@"请求服务器失败,请稍后!", nil) hideDelay:1.5f];
            }

        }];
    }
}
+(void)showHUDWithMode:(MBProgressHUDMode)mode title:(NSString *)title hideDelay:(NSTimeInterval)delay{
    MBProgressHUD *otherHud = [MBProgressHUD HUDForView:Kwindow];
    [otherHud hideAnimated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:Kwindow];
    hud.mode = mode;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    [Kwindow addSubview:hud];
    [hud showAnimated:YES];
    
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
}

+(void)hideHUD{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:Kwindow];
    [hud hideAnimated:YES];
}


@end
