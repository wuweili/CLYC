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
#import "SoapXmlParseHelper.h"
#import "GTMBase64.h"


static NSString * LogonId = @"";

static NSString * Pwd = @"";

static NSString * License = @"7c4887a7ff0b4f665b7b3c64264a27d7";




#define Str_RespondErrorOrFailedDefaultInfo       NSLocalizedString(@"操作失败，请稍后重试", @"")

#define Str_Cannot_connectedToInternet            NSLocalizedString(@"网络连接错误，请检查网络", @"")

NSString * const KNetWorkNotConnectedErrorDomain = @"com.clyc.error.networkNotConnected";

@implementation BaseHttpRequest

+(void)basePostRequestWithPath:(NSString *)path keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray methodName:(NSString *)methodName withBlock:(void (^)(NSString *, NSString *, id, NSError *))block
{

    NSString *sendParamStr = [[self class] getOrderJsonStrWithKeyArray:keyArray valueArray:valueArray];
    
    
    NSString *soapMessage = [[self class] getSoapMessageWithParamSender:sendParamStr methodName:methodName];

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
          <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
          <soap:Body>
          <ns2:doServiceResponse xmlns:ns2="http://service.skcl.com.cn/">
          <String>eyJzdGF0dXNDb2RlIjoiMTAwMDUiLCJkZXNjcmlwdGlvbiI6Iuivt+axguaVsOaNruWMheS9k+ea&#xD;
          hOacieaViOaAp+mqjOivgemUmeivr++8gSIsImJvZHkiOnsiZXJyb3JDbGFzcyI6ImNuLmNvbS5z&#xD;
          a2NsLmNvbW1vbi5leGNlcHRpb24uSW52YWxpZERhdGFFeGNlcHRpb24ifSwic2lnbiI6IiJ9</String>
          </ns2:doServiceResponse>
          </soap:Body>
          </soap:Envelope>
          
          **/

         NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
         
         
         NSString *resultStr =  [SoapXmlParseHelper SoapMessageResultXml:responseObject ServiceMethodName:@"doService"];
         
         NSData* decodeData = [GTMBase64 decodeString:resultStr];
         
         NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:decodeData options:0 error:nil];
         
         NSString *statuscode = [NSString stringWithoutNil:[resultDic valueForKeyPath:@"statusCode"]];
         NSString *retmessage = [NSString stringWithoutNil:[resultDic valueForKeyPath:@"description"]];
         
         NSString *retSign = [NSString stringWithoutNil:[resultDic valueForKeyPath:@"sign"]];
         if (![NSString isBlankString:retSign])
         {
             [HXUserModel shareInstance].sign = retSign;
         }
         
         

         id body = [resultDic valueForKeyPath:@"body"];

         if (block)
         {
             block(statuscode,retmessage,body,nil);
         }
         
         DDLogInfo(@"%@, %@  %@", operation, response,resultDic);

         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
         DDLogInfo(@"%@, %@", operation, error);(error);
         
         if (block)
         {
             block(nil,nil,nil,error);
         }
         
     }];
    
    [operation start];
}

+(NSString *)getUserCenterRequestSendDataWithParamSender:(id)paramSender
{
    
    NSString *sign = [[self class] getSignWithWithParamSender:paramSender];
    
    NSDictionary *secretDic = @{@"logonId":LogonId,@"pwd":Pwd};
  
    
    NSError *error = nil;
  
    NSString *secretJsonStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:secretDic options:(NSJSONWritingOptions)0 error:&error] encoding:NSUTF8StringEncoding];
    
    
    NSString *bodyJsonStr = @"";
    
    if ([paramSender isKindOfClass:[NSString class]])
        
    {
        bodyJsonStr = paramSender;
    }
    else
    {
        bodyJsonStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:paramSender options:(NSJSONWritingOptions)0 error:&error] encoding:NSUTF8StringEncoding];
    }
    
    NSString *signJsonStr = sign;
    
    if ([sign isKindOfClass:[NSString class]])
    {
        signJsonStr = sign;
    }
    else
    {
        signJsonStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:sign options:(NSJSONWritingOptions)0 error:&error] encoding:NSUTF8StringEncoding];
    }
 
    NSString *sendResultStr = [NSString stringWithFormat:@"{\"secret\":%@,\"body\":%@,\"sign\":\"%@\"}",secretJsonStr,bodyJsonStr,signJsonStr];
    
    DDLogInfo(@"发送的数据 ：%@",sendResultStr);

    NSData *sendUnBase64Data = [sendResultStr dataUsingEncoding:NSUTF8StringEncoding];
 
    NSString *tempResultStr  =   [[NSString alloc] initWithData:[GTMBase64 encodeData:sendUnBase64Data] encoding:NSUTF8StringEncoding];
    
    DDLogInfo(@"发送的数据经过base64后 ：%@",tempResultStr);
    
    return tempResultStr;
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


/**
 * 得到按加入顺序的JSON
 */
+(NSString *)getOrderJsonStrWithKeyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    if (keyArray && valueArray && [keyArray count] == [valueArray count] && [keyArray count]>0)
    {
        NSString *jsonStr = [NSString stringWithFormat:@"{\"%@\":\"%@\"",keyArray[0],valueArray[0]] ;
        
        for (NSInteger i = 1; i< [keyArray count]; i++)
        {
            
            jsonStr = [jsonStr stringByAppendingString:[NSString stringWithFormat:@",\"%@\":\"%@\"",keyArray[i],valueArray[i]]];
            
        }
        
        jsonStr = [jsonStr stringByAppendingString:@"}"];
        
        return jsonStr;
    }
    
    else
        return @"";
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

+(void)loginYBUserWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray password:(NSString *)password logonId:(NSString *)logonId
{
//    NSString *  path= [NSString stringWithFormat:@"%@%@",YB_HTTP_SERVER,@"UserLoginService"];
//    http://localhost:8080/wsportal/doService?wsdl
    
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest setLogonId:logonId];
    
    [BaseHttpRequest setPwd:password];
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"UserLoginService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            [HXUserModel shareInstance].userId = [NSString stringWithoutNil:returnDic[@"userId"]];
            
            [HXUserModel shareInstance].loginId = [NSString stringWithoutNil:returnDic[@"loginId"]];
            
            [HXUserModel shareInstance].userName = [NSString stringWithoutNil:returnDic[@"userName"]];
            
            [HXUserModel shareInstance].sex = [NSString stringWithoutNil:returnDic[@"sex"]];
            
            [HXUserModel shareInstance].email = [NSString stringWithoutNil:returnDic[@"email"]];
            
            [HXUserModel shareInstance].telphone = [NSString stringWithoutNil:returnDic[@"telphone"]];
            
            [HXUserModel shareInstance].roleNo = [NSString stringWithoutNil:returnDic[@"roleNo"]];
            
            [HXUserModel shareInstance].deptId = [NSString stringWithoutNil:returnDic[@"deptId"]];
            
            [HXUserModel shareInstance].deptName = [NSString stringWithoutNil:returnDic[@"deptName"]];
            
        }
        else
        {
            
        }
        
        
        
    }];
   
}


@end
