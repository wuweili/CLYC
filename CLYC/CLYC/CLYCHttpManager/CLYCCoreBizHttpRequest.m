//
//  CLYCCoreBizHttpRequest.m
//  CLYC
//
//  Created by wuweiqing on 15/6/30.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CLYCCoreBizHttpRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "CLYCHttpDefine.h"
#import "SoapHelper.h"



static NSString * LogonId = @"";

static NSString * Pwd = @"";

static NSString * License = @"7c4887a7ff0b4f665b7b3c64264a27d7";

#define Str_RespondErrorOrFailedDefaultInfo       NSLocalizedString(@"操作失败，请稍后重试", @"")

#define Str_Cannot_connectedToInternet            NSLocalizedString(@"网络连接错误，请检查网络", @"")

NSString * const KNetWorkNotConnectedErrorDomain = @"com.clyc.error.networkNotConnected";

@implementation BaseHttpRequest

+(void)basePostRequestWithPath:(NSString *)path parmDic:(NSDictionary *)paramDic withBlock:(void (^)(NSString *, NSString *, id, NSError *))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
     [manager.requestSerializer setValue: @"http://service.skcl.com.cn/doService" forHTTPHeaderField:@"SOAPAction"];
    
    NSString *sendStr = [[self class] getUserCenterRequestSendDataWithParamSender:paramDic];

    [manager POST:path parameters:sendStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@, %@", operation, response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        NSLog(@"%@, %@", operation, error);
    }];
}

+(NSString *)getUserCenterRequestSendDataWithParamSender:(id)paramSender
{
    NSString *resultStr = @"";
    
    NSString *sign = [[self class] getSignWithWithParamSender:paramSender];
    
    NSDictionary *secretDic = @{@"logonId":LogonId,@"pwd":Pwd};
    
    NSDictionary *sendDic = @{@"secret":secretDic,@"body":paramSender,@"sign":sign};
    
    NSError *error = nil;
    
    NSData *paramDicToData = [NSJSONSerialization dataWithJSONObject:sendDic options:(NSJSONWritingOptions)0 error:&error];
    
    resultStr = [paramDicToData base64EncodedStringWithOptions:0];
    
    return resultStr;
}

+(NSString *)getSignWithWithParamSender:(id)paramSendObject
{
    NSString *resultStr = @"";
    
    if ([paramSendObject isKindOfClass:[NSString class]])
    {
        resultStr = paramSendObject;
    }
    else if ([paramSendObject isKindOfClass:[NSDictionary class]])
    {
        NSError *error = nil;
        resultStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:paramSendObject options:(NSJSONWritingOptions)0 error:&error] encoding:NSUTF8StringEncoding];
    }
    
    
    resultStr = [resultStr stringByAppendingString:License];
    
    resultStr = [NSString getMD5_16_Str:resultStr];
    
    
    return resultStr;

}

+(void)setLogonId:(NSString *)logonId
{
    if (![NSString isBlankString:logonId])
    {
        LogonId = logonId;
    }
}

+(NSString *)getLogonId
{
    return LogonId;
}


+(void)setPwd:(NSString *)pwd
{
    if (![NSString isBlankString:pwd])
    {
        Pwd = pwd;
    }
}

+(NSString *)getPwd
{
    return Pwd;
}

+(NSString *)getSoapMessageWithParamSender:(id)paramSender methodName:(NSString *)methodName
{
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"params",paramSender, nil]];
    
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"GetWebNewsByType"];
  
}





@end


@implementation CLYCCoreBizHttpRequest

+(void)loginYBUserWithBlock:(void (^)(NSString *, NSString *, NSError *))block paramDic:(NSDictionary *)paramDic password:(NSString *)password logonId:(NSString *)logonId
{
//    NSString *  path= [NSString stringWithFormat:@"%@%@",YB_HTTP_SERVER,@"UserLoginService"];
//    http://localhost:8080/wsportal/doService?wsdl
    
    NSString *  path= @"http://210.73.152.201:7070/wsportal/doService?wsdl/UserLoginService";
    
    [BaseHttpRequest setLogonId:logonId];
    
    [BaseHttpRequest setPwd:password];
    
    [BaseHttpRequest basePostRequestWithPath:path parmDic:paramDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
    }];
    
    
}


@end
