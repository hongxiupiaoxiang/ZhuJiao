//
//  CoreArchive.m
//  Kwallet
//
//  Created by qhspeed on 16/7/11.
//  Copyright © 2016年 qhspeed. All rights reserved.
//

#import "CoreArchive.h"

@implementation CoreArchive

#pragma mark - 偏好类信息存储
//保存普通对象
+(void)setStr:(NSString *)str key:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setObject:str forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}

//读取
+(NSString *)strForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSString *str=(NSString *)[defaults objectForKey:key];
    
    return str;
    
}

//删除
+(void)removeStrForKey:(NSString *)key{
    
    [self setStr:nil key:key];
    
}

//保存int
+(void)setInt:(NSInteger)i key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setInteger:i forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}

//读取
+(NSInteger)intForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSInteger i=[defaults integerForKey:key];
    
    return i;
}

//保存bool
+(void)setBool:(BOOL)boolValue key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setBool:boolValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(BOOL)boolForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    BOOL boolValue=[defaults boolForKey:key];
    
    return boolValue;
}


#pragma mark 暂未协调用户登录模型
//+(void)setArray:(NSArray *)arr key:(NSString *)key{
//    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
//    NSString *path = [pathArr objectAtIndex:0];
//    NSString *pStr = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",key]];
//
//    
//    QHLoginModel * model =[CoreArchive arrayForKey:CurrentLoginModel][0];
//    QHUserInfoModel * userModel =model.user;
//    NSString *unreadkey = [NSString stringWithFormat:@"%@%@",UnreadCount,userModel.address];
//    NSString *unreadNamekey = [NSString stringWithFormat:@"%@%@",UnreadCountName,userModel.address];
//    
//    if ([key isEqualToString:unreadkey] || [key isEqualToString:unreadNamekey]) {
//
//        NSData *data =[NSKeyedArchiver archivedDataWithRootObject:arr];
//        [data writeToFile:pStr atomically:YES];
//    }else{
//        NSArray *array = [self distinctUnionOfObjects:arr];
//        
//        
//        NSData *data =[NSKeyedArchiver archivedDataWithRootObject:array];
//        [data writeToFile:pStr atomically:YES];
//    }
//   
//}
//
//+ (NSArray *)distinctUnionOfObjects:(NSArray *)array
//{
//    
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
//    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:1];
//    for (QHLoginModel * model in array) {
//        if ([arr indexOfObject:model.user.username] != NSNotFound) {
//            
//            break;
//        }else{
//            [arr addObject:model.user.username];
//            [resultArray addObject:model];
//        }
//        
//    }
//    return resultArray;
//}
//
//+(NSArray*)arrayForKey:(NSString *)key{
//  
//    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
//    NSString *path = [pathArr objectAtIndex:0];
//    NSString *pStr = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",key]];
//    
//    NSData *data1 = [NSData dataWithContentsOfFile:pStr];
//    NSArray *array ;
//    if (data1) {
//        array = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
//    }
//    
//    return array;
//}

@end
