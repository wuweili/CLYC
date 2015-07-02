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

+(void)basePostRequestWithPath:(NSString *)path parmDic:(NSDictionary *)paramDic methodName:(NSString *)methodName withBlock:(void (^)(NSString *, NSString *, id, NSError *))block
{
    
    NSString *soapMessage = [[self class] getSoapMessageWithParamSender:paramDic methodName:methodName];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: path]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 30];
    
    
    [request addValue:@"text/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         /**
             
          Printing description of response:
          <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:doServiceResponse xmlns:ns2="http://service.skcl.com.cn/"><String>eyJzdGF0dXNDb2RlIjoiMTAwMDUiLCJkZXNjcmlwdGlvbiI6Iuivt+axguaVsOaNruWMheS9k+ea&#xD;
          hOacieaViOaAp+mqjOivgemUmeivr++8gSIsImJvZHkiOnsiZXJyb3JDbGFzcyI6ImNuLmNvbS5z&#xD;
          a2NsLmNvbW1vbi5leGNlcHRpb24uSW52YWxpZERhdGFFeGNlcHRpb24ifSwic2lnbiI6IiJ9</String></ns2:doServiceResponse></soap:Body></soap:Envelope>
          
          **/

         
         NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"%@, %@", operation, response);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
         NSLog(@"%@, %@", operation, error);(error);
         
     }];
    
    [operation start];
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



+(NSString *)getSoapMessageWithParamSender:(id)paramSender methodName:(NSString *)methodName
{
    NSString *paramsStr = [[self class] getUserCenterRequestSendDataWithParamSender:paramSender];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:methodName,@"serverName", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:paramsStr,@"params", nil]];

    NSString *soapMsg = [[self class ] initSoapMessageWithNameSpaceSoapMessage:NAME_SPACE paramSenderArray:arr];
    
    return soapMsg;
  
}


+(NSString *)initSoapMessageWithNameSpaceSoapMessage:(NSString*)space paramSenderArray:(NSArray *)array
{
    
    NSString *doServiceSoapStr = [[self class] paramsSendToDefaultSoapMessageBoby:array];
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"%@\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "%@"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",space,doServiceSoapStr
                             ];
    
    return soapMessage;
    
   
    
}

+(NSString *)paramsSendToDefaultSoapMessageBoby:(NSArray *)array
{
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    
    if (array && [array count]>0 )
    {
        for (NSDictionary *item in array)
        {
            NSString *key=[[item allKeys] objectAtIndex:0];
            [msg appendFormat:@"<%@>",key];
            [msg appendString:[item objectForKey:key]];
            [msg appendFormat:@"</%@>",key];
        }
    }
    
    NSMutableString *soap=[NSMutableString stringWithFormat:@"<ser:doService>\n"];
    [soap appendString:msg];
    [soap appendFormat:@"</ser:doService>"];
    
    return soap;
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





@end


@implementation CLYCCoreBizHttpRequest

+(void)loginYBUserWithBlock:(void (^)(NSString *, NSString *, NSError *))block paramDic:(NSDictionary *)paramDic password:(NSString *)password logonId:(NSString *)logonId
{
//    NSString *  path= [NSString stringWithFormat:@"%@%@",YB_HTTP_SERVER,@"UserLoginService"];
//    http://localhost:8080/wsportal/doService?wsdl
    
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest setLogonId:logonId];
    
    [BaseHttpRequest setPwd:password];
    
    [BaseHttpRequest basePostRequestWithPath:path parmDic:paramDic methodName:@"UserLoginService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
    }];
    
    
    
    
    
}


@end
