//
//  QHChatModel.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/17.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHBaseModel.h"

@interface QHChatModel : QHBaseModel

@property (nonatomic, assign) BOOL showTime;
@property (nonatomic, assign) BOOL showNickname;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nickname;

@end
