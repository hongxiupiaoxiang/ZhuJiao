//
//  QHUserRegistError.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/10.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#ifndef QHError_h
#define QHError_h

@class NSString;
typedef NS_ENUM(NSUInteger, USER_REGIST_ERROR) {
    USER_REGIST_ERROR_NONE,
    USER_REGIST_ERROR_VERIFYCODE_EMPTY,
    USER_REGIST_ERROR_USERNAME_INVALID,
    USER_REGIST_ERROR_USERNAME_EMPTY,
    USER_REGIST_ERROR_NICKNAME_EMPTY,
    USER_REGIST_ERROR_USERNAME_INUSED,
    USER_REGIST_ERROR_PASSWORD_EMPTY,
    USER_REGIST_ERROR_PASSWORD_INVALID,
    USER_REGIST_ERROR_PASSWORD_DIFFER,
    USER_REGIST_ERROR_PASSWORD_AGAGIN,
    USER_REGIST_ERROR_PASSWORD_SAMEWITH_OLD,
    USER_REGIST_ERROR_PAY_PASSWORD_EMPTY,
    USER_REGIST_ERROR_PAY_PASSWORD_INVALID,
    USER_REGIST_ERROR_PHONENUMBER_EMPTY,
    USER_REGIST_ERROR_PHONENUMBER_INVALID,
    USER_REGIST_ERROR_VERIFYCODE_ERROR,
    USER_REGIST_ERROR_SOCIAL_ACCOUNT_EMPTY,
    USER_REGIST_ERROR_PAYPASS_SAME_WITH_LOGINPASS,
};

NSString* errorMsg(USER_REGIST_ERROR);

#endif /* QHError_h */
