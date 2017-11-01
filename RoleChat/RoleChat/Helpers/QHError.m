//
//  QHUserRegistError.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/10.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "QHError.h"

NSString* errorMsg(USER_REGIST_ERROR errorCode)
{
    switch (errorCode) {
        case USER_REGIST_ERROR_USERNAME_EMPTY:
            return QHLocalizedString(@"用户名不能为空", nil);
        case USER_REGIST_ERROR_PASSWORD_EMPTY:
            return QHLocalizedString(@"密码不能为空", nil);
        case USER_REGIST_ERROR_PASSWORD_INVALID:
            return QHLocalizedString(@"密码必须8-14位,同时包含大小写字母和数字", nil);
        case USER_REGIST_ERROR_PAY_PASSWORD_INVALID:
            return QHLocalizedString(@"支付密码必须8位以上,同时包含大小写字母和数字", nil);
        case USER_REGIST_ERROR_PASSWORD_DIFFER:
            return QHLocalizedString(@"两次输入的密码不一致", nil);
        case USER_REGIST_ERROR_PHONENUMBER_EMPTY:
            return QHLocalizedString(@"手机号码不能为空", nil);
        case USER_REGIST_ERROR_PHONENUMBER_INVALID:
            return QHLocalizedString(@"手机号码格式不正确", nil);
        case USER_REGIST_ERROR_USERNAME_INUSED:
            return QHLocalizedString(@"此用户名正在使用", nil);
        case USER_REGIST_ERROR_VERIFYCODE_ERROR:
            return QHLocalizedString(@"验证码不正确", nil);
        case USER_REGIST_ERROR_PAY_PASSWORD_EMPTY:
            return QHLocalizedString(@"支付密码不能为空", nil);
        case USER_REGIST_ERROR_SOCIAL_ACCOUNT_EMPTY:
            return QHLocalizedString(@"请填写您的社交帐号", nil);
        case USER_REGIST_ERROR_NICKNAME_EMPTY:
            return QHLocalizedString(@"昵称不能为空", nil);
        case USER_REGIST_ERROR_PASSWORD_SAMEWITH_OLD:
            return QHLocalizedString(@"新密码不能与旧密码相同", nil);
        case USER_REGIST_ERROR_PAYPASS_SAME_WITH_LOGINPASS:
            return QHLocalizedString(@"登录密码不能与支付密码一样", nil);
        case USER_REGIST_ERROR_VERIFYCODE_EMPTY:
            return QHLocalizedString(@"请填写手机验证码", nil);
        case USER_REGIST_ERROR_USERNAME_INVALID:
            return QHLocalizedString(@"昵称必须2-10个字符", nil);
        case USER_REGIST_ERROR_PASSWORD_AGAGIN:
            return QHLocalizedString(@"请再次输入密码", nil);
        default:
            break;
    }
    return NULL;
}
