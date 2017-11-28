//
//  Util.m
//  HKMember
//
//  Created by hua on 14-4-23.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "Util.h"
#import "QHGeneralMacro.h"

static MBProgressHUD* imageUploadProgressHUD = nil;

@implementation Util

 
//限制textField输入的文字
+(BOOL)limitTextFieldInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

//限制textField不能输入的字符
+(BOOL)limitTextFieldCanNotInputWord:(NSString *)string limitStr:(NSString *)limitStr
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return !canChange;
}
//只能输入整数
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//只能输入数字
+ (BOOL)validatefloat:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//保留2位小数
+(double)getTwoDecimalsDoubleValue:(double)number
{
    return round(number * 100.0)/100.0;
}


+(NSString *)getConcealPhoneNumber:(NSString *)phoneNum
{
    NSString *phoneStr=phoneNum;
    //    if (phoneStr!=nil && [phoneStr isMobile]) {
    //        phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    //    }
    return phoneStr;
}

//判断输入的字符长度 一个汉字算2个字符
+ (NSUInteger)unicodeLengthOfString:(NSString *)text {
    NSUInteger asciiLength = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

//字符串截到对应的长度包括中文 一个汉字算2个字符
+ (NSString *)subStringIncludeChinese:(NSString *)text ToLength:(NSUInteger)length{
    
    //    NSUInteger allLength=[self unicodeLengthOfString:text];
    //    if (text==nil  || length>allLength) {
    //        return text;
    //    }
    
    
    NSUInteger asciiLength = 0;
    NSUInteger location = 0;
    for(NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
        if (asciiLength==length) {
            location=i;
            break;
        }else if (asciiLength>length){
            location=i-1;
            break;
        }
        
    }
    
    NSString *finalStr=[text substringToIndex:location+1];
    
    return finalStr;
}

+(void)limitIncludeChineseTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    //NSLog(@"length is%ld",(unsigned long)length);
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式--[UITextInputMode currentInputMode] iOS 7.0以上会报警告
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textField.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textField.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
        }
    }
}


//限制UITextField输入的长度，不包括汉字
+(void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    if (toBeString.length > kMaxLength) {
        textField.text = [toBeString substringToIndex:kMaxLength];
        
    }
    
}

//用于限制UITextView的输入中英文限制
+(void)limitIncludeChineseTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    NSUInteger length = [self unicodeLengthOfString:toBeString];
    
    /*
     UITextView *textView = [[UITextView alloc] init];
     UITextInputMode *currentInputMode = textView.textInputMode;
     */
    NSString *lang = [textview.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textview markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textview positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (length > kMaxLength) {
                
                textview.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        
        if (length > kMaxLength) {
            textview.text = [self subStringIncludeChinese:toBeString ToLength:kMaxLength];
        }
    }
}

//限制UITextView输入的长度，不包括汉字
+(void)limitTextView:(UITextView *)textview Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textview.text;
    if (toBeString.length > kMaxLength) {
        textview.text = [toBeString substringToIndex:kMaxLength];
    }
    
}

//获得应用版本号
+(NSString *)getApplicationVersion
{
    //application version (use short version preferentially)
    NSString *applicationVersion=nil;
    applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if ([applicationVersion length] == 0)
    {
        applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    return applicationVersion;
}

+(NSString*)getApplicationBundleID {
    NSString* applicationBundleID = nil;
    applicationBundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    if([applicationBundleID length] == 0) {
        applicationBundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleIdentifierKey];
    }
    return applicationBundleID;
}

+(NSDictionary*)getApiKeyConfigurationDependsToBundleID {
    NSString* bundle = [Util getApplicationBundleID];
    NSArray* config = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apiKeyConfig" ofType:@"plist"]];
    if(config) {
        for (NSDictionary* dict in config) {
            if([[dict valueForKey:@"BundleID"] isEqualToString:bundle])
                return dict;
        }
    }
    
    return nil;
}

//textView限制字数
+(void)textViewWithMaxLength:(NSInteger)maxLength textView:(UITextView*)textView{
    NSString * toBeString = textView.text;
    UITextRange * selectedRange = [textView markedTextRange];
    UITextPosition * position = [textView positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange)
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textView.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


+ (void)uploadImageWithImage: (UIImage *)image scaleImgSize: (CGSize)size progressHUD:(MBProgressHUD*)imageUploadProgressHUD  complete: (RequestCompletedBlock)success failure: (RequestCompletedBlock)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    NSData *scaleImgData = [NSData imageData:image];
    UIImage *originImg = [UIImage imageWithData:scaleImgData];
    UIImage *img = [UIImage scaleImage:originImg size:size];
    [manager POST:@"http://chilli.pigamegroup.com/filemanager/uploadFile" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(img) name:@"file" fileName:@"ZhuJiao.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(imageUploadProgressHUD != nil)
                imageUploadProgressHUD.progress = 1.0f*uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(QH_VALIDATE_REQUEST(responseObject)){
            if (success) {
                success(task , [responseObject[@"data"] mj_JSONObject]);
            }
        }else {
            NSString* resultCode = responseObject[@"resultCode"];
            NSString* msg = responseObject[@"msg"];
            if(resultCode != nil && [resultCode isEqual: [NSNull null]] == NO) {
                if([resultCode isEqualToString:kNotLoggedinMsg] || [resultCode isEqualToString:kTokenNotFoundMsg]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN_NOTI object:nil userInfo:@{@"resultCode" : resultCode, @"msg" : msg}];
                    return ;
                }
            }
            if(failure){failure(task, responseObject);return    ;}
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {failure(task, error); return ;}
    }];
}

+(void)uploadImages:(NSArray *)images imgSize: (CGSize)size inView:(UIView*)inView whenComplete:(QHParamsCallback)whenComplete whenFailure:(RequestCompletedBlock)failure {
    
#define kMinimumImageSize 100
    
    static NSString* imagesUploadList = @"";
    static NSInteger imageUploadCount = 0;
    
    if(images == nil || images.count == 0) {
        if(whenComplete)
            whenComplete(imagesUploadList);
        return ;
    }
    
    NSMutableArray* imgsArray = [images mutableCopy];
    
    for (int i = 0; i != imgsArray.count; ++i) {
        UIImage* originImage = (UIImage*)[imgsArray objectAtIndex:i];
        
        NSData* tmpData = UIImageJPEGRepresentation(originImage, 1.0f);
        CGFloat imgSize = tmpData.length / 1024;
        
        if(imgSize > kMinimumImageSize) {
            NSData* imgData = UIImageJPEGRepresentation(originImage, 0.5f);
            [imgsArray replaceObjectAtIndex:i withObject:[UIImage imageWithData:imgData]];
        }
        
    }
    
#undef kMinimumImageSize
    
    if(imageUploadProgressHUD == nil) {
        imageUploadProgressHUD = [[MBProgressHUD alloc] initWithView:inView];
        imageUploadProgressHUD.mode = MBProgressHUDModeAnnularDeterminate;
        imageUploadProgressHUD.label.numberOfLines = 0;
        imageUploadProgressHUD.dimBackground = YES;
        imageUploadProgressHUD.removeFromSuperViewOnHide = YES;
        imageUploadProgressHUD.minSize = CGSizeMake(100, 100);
        [inView addSubview:imageUploadProgressHUD];
        [imageUploadProgressHUD showAnimated:YES];
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        if(imageUploadProgressHUD != nil) {
            imageUploadProgressHUD.label.text = [NSString stringWithFormat:@"%ld / %lu", (imageUploadCount + 1), (unsigned long)images.count];
            imageUploadProgressHUD.progress = 0.0f;
        }
//    });
    
    [Util uploadImageWithImage:[imgsArray objectAtIndex:imageUploadCount] scaleImgSize:size progressHUD:imageUploadProgressHUD complete:^(NSURLSessionDataTask *task, id responseObject) {
        if(imageUploadCount == 0)
            imagesUploadList = (NSString*)(responseObject[@"key"]);
        else
            imagesUploadList = [imagesUploadList stringByAppendingString:[NSString stringWithFormat:@",%@", (NSString *)(responseObject[@"key"])]];
        
        ++imageUploadCount;
        if(imageUploadCount != images.count) {
            [self uploadImages:images imgSize:size inView:inView whenComplete:whenComplete whenFailure:failure];
        }else {
            [imageUploadProgressHUD hideAnimated:YES];
            imageUploadProgressHUD = nil;
            
            imageUploadCount = 0;
            
            if(whenComplete)
                whenComplete(imagesUploadList);
            
            imagesUploadList = @"";
            
        }
    } failure:^(NSURLSessionDataTask *task, id responseObject) {
        [imageUploadProgressHUD hideAnimated:YES];
        imageUploadProgressHUD = nil;
        if (failure) {
            failure(task,responseObject);
        }
    }];
    
    return ;
}

@end
