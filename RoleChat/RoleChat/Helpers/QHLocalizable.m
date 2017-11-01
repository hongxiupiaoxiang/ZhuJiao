//
//  QHLocalizable.m
//  TestWorld
//
//  Created by 王落凡 on 16/6/30.
//  Copyright © 2016年 qhspeed. All rights reserved.
//

#import "QHLocalizable.h"

static NSDictionary* langShortDict = nil;
@implementation QHLocalizable

+(NSDictionary*)localeInfoDict {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        langShortDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Locale" ofType:@"plist"]];
    });
    
    return langShortDict;
}

+(NSString*)localeForIndex:(NSUInteger)index {
    NSDictionary* localeInfoDict = [QHLocalizable localeInfoDict];
    NSString* str = [[localeInfoDict valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]] valueForKey:@"locale"];
    
    if([str isEqualToString:@"FollowSystem"]) {
        str = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
        for (NSDictionary* localeInfo in localeInfoDict.allValues) {
            if([str containsString:[localeInfo valueForKey:@"locale"]])
                return [localeInfo valueForKey:@"locale"];
        }
        
        str = @"en-GB";
    }
    
    return str;
}

+(NSString*)currentLocaleString {
    NSString* locale = [QHLocalizable userLanguage];
    
    for (NSString* key in langShortDict.allKeys) {
        if([langShortDict[key][@"locale"] hasPrefix:locale] || [locale hasPrefix:langShortDict[key][@"locale"]])
        {
            locale = langShortDict[key][@"locale"];
            break;
        }
    }
    
    return locale;
}

+(NSString *)currentLocaleShort {
    NSString* locale = [QHLocalizable userLanguage];
    
    for (NSString* key in langShortDict.allKeys) {
        if([langShortDict[key][@"locale"] hasPrefix:locale] || [locale hasPrefix:langShortDict[key][@"locale"]])
        {
            locale = langShortDict[key][@"short"];
            break;
        }
    }
    
    return locale;
}

+(NSBundle*)localizedBundle {
    NSUInteger langIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:kUserLanguageKey] unsignedIntegerValue];
    NSString* language = [QHLocalizable localeForIndex:langIndex];
    NSBundle* langBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
    return langBundle;
}

+(NSString *)localizedStringWithKey:(NSString *)key {
    NSBundle* langBundle = [QHLocalizable localizedBundle];
    NSString* string = [langBundle localizedStringForKey:key value:@"" table:nil];
    return string;
}

+(NSString *)userLanguage {
    NSUInteger langIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:kUserLanguageKey] unsignedIntegerValue];
    return [QHLocalizable localeForIndex:langIndex];
}

@end
