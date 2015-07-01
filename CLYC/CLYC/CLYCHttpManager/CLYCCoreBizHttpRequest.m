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
//    NSString *sopeMessage = [[self class] getSoapMessageWithParamSender:paramDic methodName:methodName];
    
//    NSData *sendData = [sopeMessage dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    //测试1
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//                             "<soap:Body>\n"
//                             "<getOffesetUTCTime xmlns=\"http://www.Nanonull.com/TimeService/\">\n"
//                             "<hoursOffset>%@</hoursOffset>\n"
//                             "</getOffesetUTCTime>\n"
//                             "</soap:Body>\n"
//                             "</soap:Envelope>\n",@"5"
//                             ];
    //测试2
    
    /**
     *<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.skcl.com.cn/">
     <soapenv:Header/>
     <soapenv:Body>
     <ser:doService>
     <serverName>UserLoginService</serverName>
     <params>eyJib2R5Ijp7InBhc3N3b3JkIjoic2pAaW9zIiwibG9naW5JZCI6ImlvcyIsImNJZCI6IjIzNDU2Nzg5IiwibW9ibGllVHlwZSI6IjIifSwic2lnbiI6IjVkYWRhMzBhNzA2OTI3NjdiMTQ5MDIzYWJlNmVjODFiIiwic2VjcmV0Ijp7ImxvZ29uSWQiOiJpb3MiLCJwd2QiOiJzakBpb3MifX0=</params>
     </ser:doService>
     </soapenv:Body>
     </soapenv:Envelope>
     */
    
    
    
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.skcl.com.cn/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<ser:doService>\n"
                             "<serverName>%@</serverName>\n"
                             "<params>%@</params>\n"
                             "</ser:doService>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",@"UserLoginService",@"eyJib2R5Ijp7InBhc3N3b3JkIjoic2pAaW9zIiwibG9naW5JZCI6ImlvcyIsImNJZCI6IjIzNDU2Nzg5IiwibW9ibGllVHlwZSI6IjIifSwic2lnbiI6IjVkYWRhMzBhNzA2OTI3NjdiMTQ5MDIzYWJlNmVjODFiIiwic2VjcmV0Ijp7ImxvZ29uSWQiOiJpb3MiLCJwd2QiOiJzakBpb3MifX0="
                             ];
    
    
    //测试3
//    NSString *soapMessage =@"<?xml version=\"1.0\" encoding=\"utf-8\"?> \n"
//    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//    "<soap12:Body>"
//    "<getSupportCity xmlns=\"http://WebXml.com.cn/\">"
//    "<byProvinceName>ALL</byProvinceName>"
//    "</getSupportCity>"
//    "</soap12:Body>"
//    "</soap12:Envelope>";
    
    //测试3
//    NSString *soapMessage  = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                                                "<soap12:Envelope "
//                                                "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
//                                                "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
//                                                "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//                                                "<soap12:Body>"
//                                                "<getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">"
//                                                "<mobileCode>%@</mobileCode>"
//                                                "<userID>%@</userID>"
//                                                "</getMobileCodeInfo>"
//                                                "</soap12:Body>"
//                                                "</soap12:Envelope>", @"15062232055", @""];;
    
    

    // 实例化NSMutableURLRequest，并进行参数配置
    
//    NSString *urlString = @"http://www.nanonull.com/TimeService/TimeService.asmx";
    
    NSString *urlString =   @"http://210.73.152.201:7070/wsportal/doService?wsdl";
    
//    NSString *urlString = @"http://www.webxml.com.cn/WebServices/WeatherWebService.asmx";

//    NSString *urlString = @"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx";
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 30];
    
//     [request addValue: @"http://WebXml.com.cn/getMobileCodeInfo" forHTTPHeaderField:@"SOAPAction"];
    
    [request addValue: @"http://service.skcl.com.cn/doService" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
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
    NSString *paramsStr = [[self class] getUserCenterRequestSendDataWithParamSender:paramSender];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:methodName,@"serverName", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:paramsStr,@"params", nil]];
    
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:methodName];
    
    return soapMsg;
  
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
