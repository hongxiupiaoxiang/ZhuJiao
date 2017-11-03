//
//  QHSearchFriendModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHSearchFriendModel : QHBaseModel

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phonenumber;
@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, copy) NSString *isFriend;

@end
