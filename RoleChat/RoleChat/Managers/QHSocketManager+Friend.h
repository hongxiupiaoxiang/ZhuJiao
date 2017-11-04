//
//  QHSocketManager+Friend.h
//  RoleChat
//
//  Created by zfqiu on 2017/11/3.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#import "QHSocketManager.h"

@interface QHSocketManager (Friend)

- (void)queryUserWithUsername: (NSString *)username completion: (MessageCompletion)completion;

@end
