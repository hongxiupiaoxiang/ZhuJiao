//
//  QHRealmBaseModel.m
//  RoleChat
//
//  Created by zfqiu on 2017/11/24.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHRealmBaseModel.h"

@implementation QHRealmBaseModel

+ (RLMResults *)getResultsWithPredict: (NSString *)pred {
    return [[self allObjectsInRealm:[QHRealmDatabaseManager currentRealm]] objectsWithPredicate:[NSPredicate predicateWithFormat:pred]];
}

@end
