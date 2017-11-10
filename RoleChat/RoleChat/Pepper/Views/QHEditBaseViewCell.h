//
//  QHEditBaseViewCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/9.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseViewCell.h"

@interface QHEditBaseViewCell : QHBaseViewCell

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, copy) QHParamsCallback callback;

@end
