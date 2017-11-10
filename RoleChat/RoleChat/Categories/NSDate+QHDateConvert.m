//
//  NSDate+QHDateConvert.m
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/16.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "NSDate+QHDateConvert.h"

#define kDefaultDateFormat @"YYYY/MM/dd HH:mm"
@implementation NSDate (QHDateConvert)

-(NSUInteger)toTimeIntervalSince1970 {
    return (NSUInteger)([self timeIntervalSince1970] * 1000);
}

+(NSDate*)today {
    return [NSDate date];
}

+(NSDate*)yestoday {
    return [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
}

+(NSDate*)tomorrow {
    return [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60];
}

+(NSString*)timeToString:(NSTimeInterval)timeInterfval {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSInteger calendarUnit =   NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents* components = [calendar components:calendarUnit fromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:timeInterfval] options:0];
    
    NSString* timeStr = @"";
    if(components.month != 0)
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%ld%@", components.day, QHLocalizedString(@"天", nil)]];
    if(components.month != 0)
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%ld%@", components.hour, QHLocalizedString(@"时", nil)]];
    if(components.month != 0)
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%ld%@", components.minute, QHLocalizedString(@"分", nil)]];
    
    return timeStr;
}

-(NSString *)toString {
    return [self toStringWithFormat:kDefaultDateFormat];
}

-(NSString *)toStringWithFormat:(NSString *)format {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

-(NSString*)toStringWithFormat:(NSString *)format since1970:(NSTimeInterval)timeInterval {
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [date toStringWithFormat:format];
}

@end
