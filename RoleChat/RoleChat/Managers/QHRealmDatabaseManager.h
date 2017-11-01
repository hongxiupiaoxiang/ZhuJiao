//
//  QHRealmDatabaseManager.h
//  PWallet
//
//  Created by shaw on 16/11/5.
//
//

#import <Foundation/Foundation.h>

@interface QHRealmDatabaseManager : NSObject

+(instancetype)manager;

/**
 * 当前用户的数据库
 */
+(RLMRealm *)currentRealm;

+(RLMRealm *)defaultRealm;

/**
 * 新增多条记录
 */
+(void)insertRecords:(NSArray <RLMObject *> *)records;

/**
 * 新增一条记录
 */
+(void)insertRecord:(RLMObject *)record;

/**
 * 修改一条记录
 */
+(void)updateRecord:(RLMObject *)record;

/**
 * 删除多条记录
 */
+(void)deleteRecords:(id)records;

/**
 * 删除一条记录
 */
+(void)deleteRecord:(RLMObject *)record;
//数据库查询
+(RLMResults *)searchRecord:(RLMObject *)model SerchString:(NSString *)serchString;

@end
