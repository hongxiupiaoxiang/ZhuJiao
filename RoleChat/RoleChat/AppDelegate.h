//
//  AppDelegate.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QHAppUpdateModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) QHAppUpdateModel* updateModel;
@property(nonatomic, copy) NSString *uuidString;

@end

