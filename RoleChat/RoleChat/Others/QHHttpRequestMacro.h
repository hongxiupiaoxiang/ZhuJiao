//
//  QHHttpRequestMacro.h
//  GoldWorld
//
//  Created by baijiang on 2017/3/7.
//  Copyright © 2017年 qhspeed. All rights reserved.
//

#ifndef QHHttpRequestMacro_h
#define QHHttpRequestMacro_h
//-------------网络请求宏定义---------------
//1、正式 0测试
#if 0
#define QH_BASEURL          @""

#else

#define QH_BASEURL          @"http://chilli.pigamegroup.com/"

#endif

#define KURlGetimg @"" QH_BASEURL@"/file/img?id="
#define KURLQINIUGetImageTwo @"http://appimg.jsautodo.com/"
#define KURLQINIUOFFICIALACCOUNT @"http://officialaccount.srcwd.com/"
#define QH_REQUEST_SUCCESS @"success"
#define QH_VALIDATE_REQUEST(json) \
([json isKindOfClass:[NSDictionary class]] &&(![[json objectForKey:@"status"] isKindOfClass:[NSNull class]])&&[[json objectForKey:@"status"] isEqualToString:QH_REQUEST_SUCCESS])

#define QHPOST @"post"
#define QHGET  @"get"

#endif /* QHHttpRequestMacro_h */
