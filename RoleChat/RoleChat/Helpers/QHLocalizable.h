//
//  QHLocalizable.h
//  TestWorld
//
//  Created by qhspeed on 16/6/30.
//  Copyright © 2016年 qhspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QHLocalizable: NSObject

+(NSDictionary*)localeInfoDict;
+(NSString*)localizedStringWithKey:(NSString*)key;
+(NSString*)userLanguage;
+(NSString*)currentLocaleShort;
+(NSString*)currentLocaleString;

@end
