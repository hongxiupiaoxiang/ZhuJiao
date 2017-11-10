//
//  NSObject+timeStamp.h
//  SocialWallet
//
//  Created by qhspeed on 16/5/24.
//  Copyright © 2016年 前海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (timeStamp)

+(NSString*)timechange:(NSString*)timeStr;
+ (NSString *)timechange:(NSString *)timeStr withFormat:(NSString *)format;
//带秒
+(NSString*)secondTimechange:(NSString*)timeStr;
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;
//获得当前时间
+(NSString *)getCurrentDataString:(NSString *)stringForrmate;

// 获取13位时间戳
+(NSString *)getNowTimeTimestamp;
//时间比较
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
//加货币单位富文本
+(NSMutableAttributedString * )initCurrencyString:(NSString*)Str;
//时间加减
+(NSString*)dateAddwithTime:(NSString*)time day:(NSInteger)day stringFormatter:(NSString*)stringFormatter;
+(NSString *)getCurrentTimeWithIntervalDay: (NSInteger)day;

// 时间格式转换
+(NSString *)transferTimeStr: (NSString *)timeStr oldFormat: (NSString *)oldFormat withNewFormat: (NSString *)newFormat;
@end
