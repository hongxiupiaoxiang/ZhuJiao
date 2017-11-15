//
//  QHUserInfo.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/13.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class QHUserInfo;
@interface QHPersonalInfo : NSObject

@property(nonatomic, strong) QHUserInfo *userInfo;
@property(nonatomic, assign) NSUInteger ipArea;
@property(nonatomic, copy) NSString *appLoginToken;
@property(nonatomic, assign) BOOL alreadLogin;

+(instancetype)sharedInstance;
+(void)clearInfo;

@end

@interface QHUserInfo : NSObject

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *loginPassword;
@property (nonatomic, copy) NSString *messagecall;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phoheCode;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *shockcall;
@property (nonatomic, copy) NSString *tradePassword;
@property (nonatomic, copy) NSString *userAddress;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *voicecall;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *isOpenAi;

@end
