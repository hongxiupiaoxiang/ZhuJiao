//
//  QHHttpRequestMacro.h
//  RoleChat
//
//  Created by zfqiu on 2017/10/13.
//  Copyright © 2017年 QHCHAT. All rights reserved.
//

#ifndef QHHttpRequestMacro_h
#define QHHttpRequestMacro_h

//1、正式 0测试
#if 0
#define QH_BASEURL          @""

#else

#define QH_BASEURL          @"http://chilli.pigamegroup.com"

#endif

//ws://im.sygqb.com:3000/websocket
//ws://20.168.3.102:3000/websocket  // 测试域
//ws://20.168.3.64:3000/websocket   // 测试域
#define IM_BASEURL @"ws://im.sygqb.com:3000/websocket"
#define WEIXIN_APPID @"wxfe7d5d6ed5fcf088"
#define QQ_APPID @"101439446"
#define UMENG_APPID @"5a221015f43e48710b000052"
#define QINIU_IMAGE_PREFIX @"http://ofydu65mj.bkt.clouddn.com/"

#define QH_REQUEST_SUCCESS @"success"
#define QH_VALIDATE_REQUEST(json) \
([json isKindOfClass:[NSDictionary class]] &&(![[json objectForKey:@"status"] isKindOfClass:[NSNull class]])&&[[json objectForKey:@"status"] isEqualToString:QH_REQUEST_SUCCESS]) || ([[json objectForKey:@"result_code"] isEqualToString:@"SUCCESS"] && [[json objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] && [[json objectForKey:@"return_msg"] isEqualToString:@"OK"])

#define QHPOST @"post"
#define QHGET  @"get"

#endif /* QHHttpRequestMacro_h */
