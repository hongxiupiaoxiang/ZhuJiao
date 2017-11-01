//
//  NSDate+QHDateConvert.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/16.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (QHDateConvert)

-(NSUInteger)toTimeIntervalSince1970;
+(NSDate*)today;
+(NSDate*)yestoday;
+(NSDate*)tomorrow;
+(NSString*)timeToString:(NSTimeInterval)timeInterval;

-(NSString*)toString;
-(NSString*)toStringWithFormat:(NSString*)format;
-(NSString*)toStringWithFormat:(NSString *)format since1970:(NSTimeInterval)timeInterval;

@end
