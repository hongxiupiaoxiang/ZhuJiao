//
//  NSString+WechatSign.h
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WechatSign)

+ (NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key;

@end
