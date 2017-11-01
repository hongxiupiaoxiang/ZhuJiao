//
//  QHRealmDatabaseManager.m
//  PWallet
//
//  Created by shaw on 16/11/5.
//
//

#import "QHRealmDatabaseManager.h"

@implementation QHRealmDatabaseManager

+(instancetype)manager{
    static QHRealmDatabaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QHRealmDatabaseManager alloc]init];
    });
    
    return manager;
}

+(RLMRealm *)currentRealm{
//    NSString *currentUser = [QHPersonalInfo sharedInstance].userInfo.username;
    NSString *currentUser = @"test";
    return [self realmWithUserName:currentUser];
}

+(RLMRealm *)defaultRealm{
    return [self realmWithUserName:nil];
}

+(RLMRealm *)realmWithUserName:(NSString *)userName{
    RLMRealmConfiguration *configuration = [[self class] realmConfiguration];
    
    if(userName){
        NSURL *defaultUrl = configuration.fileURL;
        NSString *userPath = [[defaultUrl.path stringByDeletingLastPathComponent]
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.realm", userName]];
        configuration.fileURL = [NSURL fileURLWithPath:userPath];
    }

    
//    configuration.schemaVersion = 1.0;
////
////    // 版本库升级
//    configuration.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion){
//        [migration enumerateObjects:[QHRealmShipModel className] block:^(RLMObject*  _Nullable oldObject, RLMObject*  _Nullable newObject) {
//            if (oldSchemaVersion < 1.0) {
//                newObject[@"otherPhoneCode"] = @"";
//                newObject[@"otherPhoneCode"] = @"";
//                
//            }
//        }];
//    };

    
    return [RLMRealm realmWithConfiguration:configuration error:nil];
}

+(RLMRealmConfiguration *)realmConfiguration{
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
//    configuration.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion){
//        [migration enumerateObjects:[QHDiscoverModel className] block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
//            if(oldSchemaVersion < 1){
//                newObject[@"cellRefresh"] = [NSString stringWithFormat:@"%zd",NO];
//            }
//        }];
//    };
    
    return configuration;
}

#pragma mark -数据库记录操作..
+(void)insertRecords:(NSArray<RLMObject *> *)records{
    RLMRealm *realm = [self currentRealm];
    [realm transactionWithBlock:^{
        [realm addObjects:records];
    }];
}

+(void)insertRecord:(RLMObject *)record{
    RLMRealm *realm = [self currentRealm];
    [realm transactionWithBlock:^{
        [realm addObject:record];
    }];
}

+(void)updateRecord:(RLMObject *)record{
    RLMRealm *realm = [self currentRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:record];
    }];
}

+(void)deleteRecords:(id)records{
    RLMRealm *realm = [self currentRealm];
    [realm transactionWithBlock:^{
        [realm deleteObjects:records];
    }];
}

+(void)deleteRecord:(RLMObject *)record{
    RLMRealm *realm = [self currentRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:record];
    }];
}
//例如 RLMResults *tanDogs = [Dog objectsWhere:@"color = '棕黄色' AND name BEGINSWITH '大'"];
+(RLMResults *)searchRecord:(RLMObject *)model SerchString:(NSString *)serchString{
    RLMResults * searchResults = [RLMObject objectsWhere:serchString];
    return searchResults;
}
@end
