//
//  QHAccountCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/14.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"

typedef NS_ENUM(NSInteger, BgImg) {
    BgImg_Green,
    BgImg_Blue,
    BgImg_Red
};

@interface QHAccountCell : QHBaseTableViewCell

@property (nonatomic, assign) BgImg imgColor;

@end
