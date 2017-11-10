//
//  NSObject+timeStamp.m
//  SocialWallet
//
//  Created by qhspeed on 16/5/24.
//  Copyright © 2016年 前海. All rights reserved.
//

#import "NSObject+timeStamp.h"

@implementation NSObject (timeStamp)

+(NSString*)timechange:(NSString*)timeStr {
    NSString* format = @"";
    if([[QHLocalizable currentLocaleShort] isEqualToString:@"en"])
        format = @"HH:mm MM/dd/YYYY";
    else
        format = @"YYYY-MM-dd HH:mm";
    
    return [NSObject timechange:timeStr withFormat:format];
}
//带秒
+(NSString*)secondTimechange:(NSString*)timeStr {
    NSString* format = @"";
    if([[QHLocalizable currentLocaleShort] isEqualToString:@"en"])
        format = @"HH:mm:ss MM/dd/YYYY";
    else
        format = @"YYYY-MM-dd HH:mm:ss";
    
    return [NSObject timechange:timeStr withFormat:format];
}
//时间戳转时间
+ (NSString *)timechange:(NSString *)timeStr withFormat:(NSString *)format
{
    //这个判断别删，要不跟之前写的冲突
    if (format == nil || format.length == 0) {
        if([[QHLocalizable currentLocaleShort] isEqualToString:@"en"])
            format = @"HH:mm MM/dd/YYYY";
        else
            format = @"YYYY-MM-dd HH:mm";
    }
    NSTimeInterval time;
    if (timeStr.length>9) {
        time  =[[timeStr substringToIndex:10] doubleValue];
    }else {
        time =[timeStr  doubleValue];
    }
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)distanceTimeWithBeforeTime:(double)beTime {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - beTime / 1000.0;
    NSString *distanceStr;
    
    NSDate *beDate = [NSDate dateWithTimeIntervalSince1970:beTime / 1000.0];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString *timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString *nowDay = [df stringFromDate:[NSDate date]];
    NSString *lastDay = [df stringFromDate:beDate];
    
    if(distanceTime < 24*60*60 && [nowDay integerValue] == [lastDay integerValue]){
        distanceStr = [NSString stringWithFormat:@"%@",timeStr];
    }
    else if(distanceTime< 24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [QHLocalizedString(@"昨天 ", nil) stringByAppendingString:timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
    }
    else if(distanceTime < 24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

//获得当前时间
+(NSString *)getCurrentDataString:(NSString *)stringForrmate;
{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:stringForrmate];
    NSString * dateTime = [formatter stringFromDate:date];
    return dateTime;
}
// 获取13位时间戳
+(NSString *)getNowTimeTimestamp{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    
//    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970] * 1000];
    return timeSp;
}
//比较两个日期的大小
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //        相等  aa=0
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    return aa;
}

+(NSMutableAttributedString * )initCurrencyString:(NSString*)Str{
    NSMutableAttributedString * mutStr = [[NSMutableAttributedString alloc] initWithString:Str];
    [mutStr setAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x47c45c) range:NSMakeRange(Str.length-1, 1)];
    [mutStr setAttribute:NSForegroundColorAttributeName value:BlackColor range:NSMakeRange(0, Str.length-1)];
    
    return mutStr;
}
//时间加减
+(NSString*)dateAddwithTime:(NSString*)time day:(NSInteger)day stringFormatter:(NSString*)stringFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:stringFormatter];
    NSDate *Date0 = [dateFormatter dateFromString:time];
    NSTimeInterval interval = 24*60 * 60 * day;
    NSString *titleString = [dateFormatter stringFromDate:[Date0 initWithTimeInterval:interval sinceDate:Date0]];
    
    return titleString;
}

// 获取时间间隔日期
+(NSString *)getCurrentTimeWithIntervalDay: (NSInteger)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval interval = 24*60 * 60 * day;
    NSString *titleString = [dateFormatter stringFromDate:[[NSDate date] initWithTimeInterval:interval sinceDate:[NSDate date]]];
    return titleString;
}

// 时间格式转换
+(NSString *)transferTimeStr: (NSString *)timeStr oldFormat: (NSString *)oldFormat withNewFormat: (NSString *)newFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:oldFormat];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    [dateFormatter setDateFormat:newFormat];
    return [dateFormatter stringFromDate:date];
}

@end
