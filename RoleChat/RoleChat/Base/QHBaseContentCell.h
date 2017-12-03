//
//  QHBaseContentCell.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/18.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseTableViewCell.h"

typedef NS_ENUM(NSInteger,ContentAliment) {
    ContentAliment_Left,
    ContentAliment_Right
};

@interface QHBaseContentCell : QHBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) ContentAliment aliment;

@end
