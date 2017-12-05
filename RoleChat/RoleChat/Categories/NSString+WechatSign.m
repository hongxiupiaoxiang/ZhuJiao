//
//  NSString+WechatSign.m
//  RoleChat
//
//  Created by zfqiu on 2017/12/5.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "NSString+WechatSign.h"

@implementation NSString (WechatSign)

+ (NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key {
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:noncestr_key forKey:@"noncestr"];//随机字符串
    [signParams setObject:package_key forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:partnerid_key forKey:@"partnerid"];//商户账号
    [signParams setObject:prepayid_key forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:[NSString stringWithFormat:@"%u",timestamp_key] forKey:@"timestamp"];//时间戳
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段  API 密钥
    [contentString appendString:@"key=Pepper"];
    NSString *result = [contentString md5String];//md5加密
    return [result uppercaseString];
}


@end
