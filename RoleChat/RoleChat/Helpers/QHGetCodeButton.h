//
//  QHGetCodeButton.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/9.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^GetCodeAction)(void);
@interface QHGetCodeButton : UIButton

@property(nonatomic, copy) GetCodeAction action;

-(instancetype)init;
-(instancetype)initWithTimeInterval:(NSUInteger)timeInterval;
-(instancetype)initWithTimeInterval:(NSUInteger)timeInterval withAction:(GetCodeAction)action;

@end
