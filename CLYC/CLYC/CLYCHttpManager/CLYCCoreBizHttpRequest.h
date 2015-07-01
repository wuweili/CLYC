//
//  CLYCCoreBizHttpRequest.h
//  CLYC
//
//  Created by wuweiqing on 15/6/30.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseHttpRequest : NSObject

/**
 * 加密请求 post 不带附件
 */
+(void)basePostRequestWithPath:(NSString *)path parmDic:(NSDictionary *)paramDic methodName:(NSString *)methodName withBlock:(void (^)( NSString *retCode, NSString *retMessage, id responseObject, NSError *error))block;

/**
 * 得到最终发送给服务器的字典
 */
+(NSString *)getUserCenterRequestSendDataWithParamSender:(id )paramSender;


/**
 * 设置加密密钥的值
 */

+(void)setLogonId:(NSString *)logonId;

/**
 * 获取加密密钥的值
 */
+(NSString *)getLogonId;

/**
 * 设置加密密钥的值
 */

+(void)setPwd:(NSString *)pwd;

/**
 * 获取加密密钥的值
 */
+(NSString *)getPwd;


@end




@interface CLYCCoreBizHttpRequest : NSObject

/**
 * 登录
 */
+(void)loginYBUserWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block paramDic:(NSDictionary *)paramDic password:(NSString *)password logonId:(NSString *)logonId;

@end
