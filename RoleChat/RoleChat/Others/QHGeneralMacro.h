//
//  Header.h
//  GoldWorld
//
//  Created by baijiang on 2017/3/6.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#ifndef QHGeneralMacro_h
#define QHGeneralMacro_h

#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES:NO)
#define isIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES:NO)
//window
#define Kwindow  [UIApplication sharedApplication].keyWindow
//UserDefaults
#define UserDefaults [NSUserDefaults standardUserDefaults]
#define hiddenMBPTime 2.0f
// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]
#define ICON_IMAGE               IMAGENAMED(@"RN_Icon")

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE ([UIScreen mainScreen].scale)

#define VERSION_APP_DISPLAY     [[[NSBundle mainBundle] infoDictionary] \
objectForKey:@"CFBundleShortVersionString"]

//#define QHLocalizedString(key, comment) \
//[[QHLocalizable bundle] localizedStringForKey:(key) value:@"" table:nil]

#define QHLocalizedString(key, comment) [QHLocalizable localizedStringWithKey:key]

#define WhiteColor [UIColor whiteColor]
#define MainColor UIColorFromRGB(0xff4c79)
#define RGBFF697A UIColorFromRGB(0xff697a)
#define BlackColor UIColorFromRGB(0x19191a)
#define RGBC8C9CC UIColorFromRGB(0xc8c9cc)
#define RGBF5F6FA UIColorFromRGB(0xf5f6fa)
#define RGB4A5970 UIColorFromRGB(0x4a5970)
#define RGB939EAE UIColorFromRGB(0X939eae)
#define RGB646466 UIColorFromRGB(0x646466)
#define RGB52627C UIColorFromRGB(0x52627c)

#define kMinimumPasswordLength 8
#define kMinimumUsernameLength 6
#define kMaximumPasswordLength 14

#define kPasswordFormatPattern [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"^(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%d,%d}$", kMinimumPasswordLength, kMaximumPasswordLength] options:NSRegularExpressionDotMatchesLineSeparators error:nil]
#define kUserNameFormatPattern [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%d,%d}$", kMinimumUsernameLength, kMaximumPasswordLength] options:NSRegularExpressionCaseInsensitive error:nil]
#define kPhoneNumberFormatPattern [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:nil]
#define CopyView(view) [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:view]]

#define kDefaultAnimationIntervalKey 0.25f
#define kUserLanguageKey @"UserLanguage"
#define kSystemLanguageKey @"AppleLanguages"
#define borderForView(view, color) do { \
    view.layer.borderColor = color.CGColor; \
    view.layer.borderWidth = 1.0f / SCREEN_SCALE; \
}while(0)
#define noBorderForView(view) do { \
    view.layer.borderColor = [UIColor clearColor].CGColor; \
    view.layer.borderWidth = 0.0f; \
}while(0)
#define kUserMoreInfoCookieKey @"moreInfoCookie"
#define kAppVersionKey @"appVersion"
#define kNotLoggedinMsg @"NOT_LOGGEDIN"
#define kTokenNotFoundMsg @"TOKEN_NOT_FOUND"
#define kAccountLockedKey @"ACCOUNT_LOCK"
#define kZonePhoneCode @"ZONE_CODE"
#define kZonePhoneCodeValue @"ZONE_VALUE"

#define PerformOnMainThread(CodeBlocks) do { \
    dispatch_async(dispatch_get_main_queue(), ^{ \
        CodeBlocks \
    }); \
}while(0)

#define PerformOnMainThreadDelay(delay, CodeBlocks) do { \
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
        CodeBlocks \
    }); \
}while(0)

#define PushViewController(controller) do { \
    if(controller != NULL) \
        [self.navigationController pushViewController:controller animated:YES]; \
}while(0)

#define PushViewControllerWithNavi(naviController, controller) [naviController pushViewController:controller animated:YES]
#define LoadNibNamed(nibName, index) [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:index]

#define ButtonAddTarget(button,s) [button addTarget:self action:@selector(s) forControlEvents:UIControlEventTouchUpInside];

#define App_Delegate ((AppDelegate*)[UIApplication sharedApplication].delegate)
//字体
#define FONT(F) [UIFont fontWithName:@"Arial" size:F]
#define FONT_BOLD(F) [UIFont fontWithName:@"Arial-BoldMT" size:F]
//本地化
//#define QHLocalizedString(key, comment) \
//[[QHLocalizable bundle] localizedStringForKey:(key) value:@"" table:nil]
#define WeakSelf __weak typeof(self) weakSelf = self;
#pragma mark - 打印到控制台
#if DEBUG
#define DLog(FORMAT, ...) fprintf(stderr,"\%s [第%d行] %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DLog(FORMAT, ...)
#endif

//通知
#define LANGUAGE_CHAGE_NOTI @"LanguageChangedNotification"
#define ZONECODE_CHANGE_NOTI @"ZoneCodeChangedNotification"
#define RELOGIN_NOTI @"UserMustBeReloginNotification"
#define INFO_CHANGE_NOTI @"infoChangedNofication"
#define WEIXIN_LOGIN @"weixinLogin"


#define ShowShieldAlert do { \
            [[[UIAlertView alloc] initWithTitle:QHLocalizedString(@"敬请期待", nil) message:nil delegate:nil cancelButtonTitle:QHLocalizedString(@"确定", nil) otherButtonTitles: nil] show]; \
    }while(0)


// socket
#define socketIsConnected ([QHSocketManager manager].socketStatus == QHSocketStatus_Received || [QHSocketManager manager].socketStatus == QHSocketStatus_Connected)

#endif /* QHGeneralMacro_h */

