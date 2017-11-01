//
//  QHBaseModel.h
//  RoleChat
//
//  Created by zfQiu on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

//#if NS_BLOCKS_AVAILABLE
typedef void(^RequestCompletedBlock)( NSURLSessionDataTask * task,id responseObject);
typedef void(^RequestModifyBlock)(AFHTTPSessionManager* manager);
//#endif

@interface QHBaseModel : NSObject


#pragma mark --网络请求
+ (void)sendRequestWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params hudTitle:(NSString *)hudTitle beforeRequest:(RequestModifyBlock)modifyBlock successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock;
+(void)sendGETRequestNoHudWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params  beforeRequest:(RequestModifyBlock)modifyBlock  successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock;
+(void)sendGETRequestWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params hudTitle:(NSString *)hudTitle beforeRequest:(RequestModifyBlock)modifyBlock successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock;
+(void)sendPOSTRequestNoHudWithAPI:(NSString *)api baseURL:(NSString*)baseURL params:(NSDictionary *)params  beforeRequest:(RequestModifyBlock)modifyBlock successBlock:(RequestCompletedBlock)successBlock failedBlock:(RequestCompletedBlock)failedBlock;

@end
