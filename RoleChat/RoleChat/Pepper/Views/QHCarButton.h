//
//  QHCarButton.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHCarButton : UIButton

@property (nonatomic, assign) NSInteger shopCount;

- (void)addShopCount;
- (void)decreaseCount;

@end
