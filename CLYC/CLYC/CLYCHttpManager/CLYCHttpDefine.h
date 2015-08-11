//
//  CLYCHttpDefine.h
//  CLYC
//
//  Created by wuweiqing on 15/7/1.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#ifndef CLYC_CLYCHttpDefine_h
#define CLYC_CLYCHttpDefine_h

/**
 * YB_HTTP_IDP_SERVER_LOACL_DEBUG     外网真实环境
 *
 * YB_HTTP_IDP_SERVER_LOACL_TEST      内网测试
 *
 * YB_HTTP_IDP_SERVER_RELEASE_TEST    外网测试
 *
 * YB_HTTP_IDP_SERVER_LOACL_DEBUG     内网开发
 */

/**
 * 开发调试 com.yibaomd.YiBaomdPatientDevTest   com.clyc.skclycDevTest
 *
 * 发布环境 com.yibaomd.YiBaomdPatient          com.clyc.skclyc
 */


#define YB_HTTP_IDP_SERVER_LOACL_DEBUG    //注意：！！此宏打开表示用得是内网开发服务器


#if defined(YB_HTTP_IDP_SERVER_RELEASE)   //外网真实环境

#define YB_HTTP_SERVER                       @"http://210.73.152.201:7070/wsportal/doService?wsdl"

#define BaiDuMap_AK      @"yGlTK49KqpHNIzGt13dVZHsj"

#define kAppId           @"ziq9kaI5gw70gzZoIjJ7V9"
#define kAppKey          @"XcjP9Bx2Mb9BjDOIsFsFO"
#define kAppSecret       @"y5PinKJ70C7mkL0kfOKHC3"


#elif defined(YB_HTTP_IDP_SERVER_LOACL_TEST) //内网测试

#define YB_HTTP_SERVER                       @"http://210.73.152.201:7070/wsportal/doService?wsdl"

#define BaiDuMap_AK      @"yGlTK49KqpHNIzGt13dVZHsj"
#define kAppId           @"ziq9kaI5gw70gzZoIjJ7V9"
#define kAppKey          @"XcjP9Bx2Mb9BjDOIsFsFO"
#define kAppSecret       @"y5PinKJ70C7mkL0kfOKHC3"


#elif defined(YB_HTTP_IDP_SERVER_RELEASE_TEST) //外网测试


#define YB_HTTP_SERVER                       @"http://210.73.152.201:7070/wsportal/doService?wsdl"

#define BaiDuMap_AK                          @"yGlTK49KqpHNIzGt13dVZHsj"

#define kAppId           @"ziq9kaI5gw70gzZoIjJ7V9"
#define kAppKey          @"XcjP9Bx2Mb9BjDOIsFsFO"
#define kAppSecret       @"y5PinKJ70C7mkL0kfOKHC3"




#else //内网开发

#define YB_HTTP_SERVER     @"http://210.73.152.201:7070/wsportal/doService?wsdl"

#define BaiDuMap_AK      @"Nk8ss3LgqWOmNbDiv1K8wL0o"

#define kAppId           @"FueAs6RoeSAX1taNFUpQ6"
#define kAppKey          @"WyJf8LD9J274kSyyv5rrv7"
#define kAppSecret       @"WyJf8LD9J274kSyyv5rrv7"


#endif


#define NAME_SPACE  @"http://service.skcl.com.cn/"

#define METHOD_NAME  @"doService"

#define SOAP_ACTION   @"http://service.skcl.com.cn/doService"


#define YB_HTTP_CODE_OK                        @"00000"





#endif
