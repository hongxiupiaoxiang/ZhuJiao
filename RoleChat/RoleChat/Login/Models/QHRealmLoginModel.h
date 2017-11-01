//
//  QHRealmLoginModel.h
//  GoldWorld
//
//  Created by zfQiu on 2017/10/27.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "Realm.h"

@interface QHRealmLoginModel : RLMObject

@property(nonatomic, copy) NSString *userID;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *loginPassword;
@property(nonatomic, copy) NSString *appLoginToken;
@property(nonatomic, assign) NSInteger ipArea;

@end
