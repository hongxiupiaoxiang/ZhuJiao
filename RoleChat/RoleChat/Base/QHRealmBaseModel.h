//
//  QHRealmBaseModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/24.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Realm/Realm.h>

@interface QHRealmBaseModel : RLMObject

+ (RLMResults *)getResultsWithPredict: (NSString *)pred;

@end
