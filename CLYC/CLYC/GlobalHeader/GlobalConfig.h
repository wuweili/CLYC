//
//  GlobalConfig.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#ifndef BJXH_patient_GlobalConfig_h
#define BJXH_patient_GlobalConfig_h


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
#define  PROJECT_MODE 0x1 //设置此处
#elif
#warning "PROJECT_MODE already defined in other files."
#endif

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
#define CONSOLE_LOG_OFF
#define FILE_LOG_OFF                     //打印日志到本地 FILE_LOG_ON   FILE_LOG_OFF
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

#endif
