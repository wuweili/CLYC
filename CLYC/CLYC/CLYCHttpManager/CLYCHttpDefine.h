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
 * 开发调试 com.yibaomd.YiBaomdPatientDevTest   极光 appKey: 8b09dcd165a8f21b02d25bbe
 *
 * 发布环境 com.yibaomd.YiBaomdPatient          极光 appKey: 1c6ce14f71a25ff58ad0cd10
 */


#define YB_HTTP_IDP_SERVER_LOACL_DEBUG    //注意：！！此宏打开表示用得是内网开发服务器




#if defined(YB_HTTP_IDP_SERVER_RELEASE)   //外网真实环境


#define YB_HTTP_SERVER                       @"http://210.73.152.201:8888/wsportal/doService"

#define BaiDuMap_AK   @"LivYgBlngmQdmqkUbzqgOZZs"




#elif defined(YB_HTTP_IDP_SERVER_LOACL_TEST) //内网测试


#define YB_HTTP_SERVER                       @"https://api.yibaomd-test.com/api-web/"

#define BaiDuMap_AK   @"LivYgBlngmQdmqkUbzqgOZZs"



#elif defined(YB_HTTP_IDP_SERVER_RELEASE_TEST) //外网测试


#define YB_HTTP_SERVER                       @"https://test.yibaomd.com/api-web/"

#define BaiDuMap_AK   @"LivYgBlngmQdmqkUbzqgOZZs"



#else //内网开发


#define YB_HTTP_SERVER                       @"http://210.73.152.201:7070/wsportal/doService?wsdl"

//webservice配置

#define BaiDuMap_AK   @"Kvyfr0qeGtHIn7cekBKVr8rR"




#endif


#define NAME_SPACE  @"http://service.skcl.com.cn/"

#define METHOD_NAME  @"doService"

#define SOAP_ACTION   @"http://service.skcl.com.cn/doService"


#define YB_HTTP_CODE_OK                        @"00000"





#endif
