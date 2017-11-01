//
//  Util.h
//  HKMember
//
//  Created by hua on 14-4-23.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject
//限制RCLabel长度
//+(NSString *)limitRCLabelLength:(NSUInteger)limitLength string:(NSString *)str;

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr;

//保留2位小数
+(double)getTwoDecimalsDoubleValue:(double)number;

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text;

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length;

//限制UITextField输入的长度，包括汉字  一个汉字算2个字符
+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength;
//只能输入整数
+ (BOOL)validateNumber:(NSString*)number;
//只能输入数字
+ (BOOL)validatefloat:(NSString*)number;
//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength;

//限制UITextView输入的长度，包括汉字  一个汉字算2个字符
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength;

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength;

//电话号码转换
+(NSString *)getConcealPhoneNumber:(NSString *)phoneNum;

//获得应用版本号
+(NSString *)getApplicationVersion;

//获得BundleID
+(NSString*)getApplicationBundleID;

//获取配置
+(NSDictionary*)getApiKeyConfigurationDependsToBundleID;

//textView限制字数
+(void)textViewWithMaxLength:(NSInteger)maxLength textView:(UITextView*)textView;
@end
