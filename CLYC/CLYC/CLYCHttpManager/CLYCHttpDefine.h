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

// ******************************  此段不需设置 ********************************** //
#pragma mark --  Base parameters
typedef enum ProjectMode
{
    DEBUG_MODE = 0x1,           // 开发调试模式，平时调试使用
    
    LOCAL_TEST_MODEL = 0x10,    // 内网测试环境
    
    RELEASE_MODE = 0x100,       // 发布模式，外网真实环境
    
    RELEASE_TEST_MODE = 0x1000  // 外网测试环境
    
}IM_PROJECT_MODE;


// ******************************  以下为各种控制开关 ********************************** //
#pragma mark --  Developer Settings


/******************************
 * 默认工程模式，由开发者调试时候设置
 *******************************/

#ifndef PROJECT_MODE
#define  PROJECT_MODE    0x100   //设置此处,平时调试、发布版本时设置此处
#elif
#warning "PROJECT_MODE already defined in other files."
#endif


/******************************
 * 下面是各种不同模式下对应开关
 *******************************/


/**
 *	开发调试模式，平时调试使用
 */

#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x1
#define CONSOLE_LOG_ON
#define FILE_LOG_ON                     //打印日志到本地 FILE_LOG_ON   FILE_LOG_OFF
#define YB_HTTP_IDP_SERVER_LOACL_DEBUG  //内网开发
#endif
#endif

/**
 *	内网测试环境
 */
#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x10
#define CONSOLE_LOG_ON
#define FILE_LOG_ON                     //打印日志到本地 FILE_LOG_ON   FILE_LOG_OFF
#define YB_HTTP_IDP_SERVER_LOACL_TEST   //内网测试
#endif
#endif


/**
 *	发布模式，外网真实环境
 */
#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x100
#define CONSOLE_LOG_OFF      //发布版本的时候关闭consolelog
#define FILE_LOG_OFF         //打印日志到本地 FILE_LOG_ON   FILE_LOG_OFF
#define YB_HTTP_IDP_SERVER_RELEASE   //发布模式，外网真实环境
#endif
#endif


/**
 *	外网测试环境
 */
#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x1000
#define CONSOLE_LOG_OFF
#define FILE_LOG_OFF
#define YB_HTTP_IDP_SERVER_RELEASE_TEST   //外网测试环境
#endif
#endif



#if defined(YB_HTTP_IDP_SERVER_RELEASE)   //外网真实环境

#define YB_HTTP_SERVER   @"http://210.73.152.199:20088/wsportal/doService?wsdl"

#define BaiDuMap_AK      @"yGlTK49KqpHNIzGt13dVZHsj"

#define kAppId           @"ziq9kaI5gw70gzZoIjJ7V9"
#define kAppKey          @"XcjP9Bx2Mb9BjDOIsFsFO"
#define kAppSecret       @"y5PinKJ70C7mkL0kfOKHC3"


#elif defined(YB_HTTP_IDP_SERVER_LOACL_TEST) //内网测试

#define YB_HTTP_SERVER   @"http://210.73.152.199:20088/wsportaltest/doService?wsdl"

#define BaiDuMap_AK      @"yGlTK49KqpHNIzGt13dVZHsj"  //@"Nk8ss3LgqWOmNbDiv1K8wL0o"

#define kAppId           @"ziq9kaI5gw70gzZoIjJ7V9"
#define kAppKey          @"XcjP9Bx2Mb9BjDOIsFsFO"
#define kAppSecret       @"y5PinKJ70C7mkL0kfOKHC3"


#elif defined(YB_HTTP_IDP_SERVER_RELEASE_TEST) //外网测试


#define YB_HTTP_SERVER   @"http://210.73.152.199:20088/wsportal/doService?wsdl"

#define BaiDuMap_AK       @"3UiCTeyHILdNhioR1WeNXSaU" //  @"Nk8ss3LgqWOmNbDiv1K8wL0o"

#define kAppId           @"ziq9kaI5gw70gzZoIjJ7V9"
#define kAppKey          @"XcjP9Bx2Mb9BjDOIsFsFO"
#define kAppSecret       @"y5PinKJ70C7mkL0kfOKHC3"


#else //内网开发

#define YB_HTTP_SERVER     @"http://210.73.152.199:20088/wsportaltest/doService?wsdl"

#define BaiDuMap_AK      @"Nk8ss3LgqWOmNbDiv1K8wL0o"

//#define kAppId           @"FueAs6RoeSAX1taNFUpQ6"
//#define kAppKey          @"WyJf8LD9J274kSyyv5rrv7"
//#define kAppSecret       @"WyJf8LD9J274kSyyv5rrv7"


#define kAppId           @"RW3Kr2lktA7eso2o5O87H4"
#define kAppKey          @"W0xTHI825y9eSd1KoCEe63"
#define kAppSecret       @"bS0dznFnKC9zwEgFIWnWk1"


#endif


#define NAME_SPACE  @"http://service.skcl.com.cn/"

#define METHOD_NAME  @"doService"

#define SOAP_ACTION   @"http://service.skcl.com.cn/doService"


#define YB_HTTP_CODE_OK                        @"00000"





#endif
