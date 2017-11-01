//
//  CoreArchive.h
//  Kwallet
//
//  Created by qhspeed on 16/7/11.
//  Copyright © 2016年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreArchive : NSObject
#pragma mark - 偏好类信息存储

/**
 *  保存普通字符串
 */
+(void)setStr:(NSString *)str key:(NSString *)key;

/**
 *  读取
 */
+(NSString *)strForKey:(NSString *)key;

/**
 *  删除
 */
+(void)removeStrForKey:(NSString *)key;


/**
 *  保存int
 */
+(void)setInt:(NSInteger)i key:(NSString *)key;

/**
 *  读取int
 */
+(NSInteger)intForKey:(NSString *)key;


/**
 *  保存bool
 */
+(void)setBool:(BOOL)boolValue key:(NSString *)key;

/**
 *  读取bool
 */
+(BOOL)boolForKey:(NSString *)key;

/*
 *保存数组
 */
//+(void)setArray:(NSArray*)arr key:(NSString*)key;

/*
 *读取数组
 */
//+(NSArray*)arrayForKey:(NSString*)key;


@end
