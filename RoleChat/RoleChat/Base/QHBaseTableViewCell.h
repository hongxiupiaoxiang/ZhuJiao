//
//  QHTableViewCell.h
//  RoleChat
//
//  Created by zfQiu on 2017/3/9.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cellCallBackBlock)(id prama);
@interface QHBaseTableViewCell : UITableViewCell
@property(copy , nonatomic) cellCallBackBlock callBackBlock;
-(void)setupCellUI;
+ (NSString *)reuseIdentifier;
@end
