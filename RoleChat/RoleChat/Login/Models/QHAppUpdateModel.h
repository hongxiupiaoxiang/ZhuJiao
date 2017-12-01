//
//  QHAppUpdateModel.h
//  GoldWorld
//
//  Created by 王落凡 on 2017/3/17.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHAppUpdateModel : QHBaseModel

@property(nonatomic, assign) BOOL mustUpdate;
@property(nonatomic, copy) NSString* url;
@property(nonatomic, copy) NSString* version;
@property(nonatomic, assign) NSInteger versionCode;

@end
