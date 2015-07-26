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


static NSString * LogonId = @"ios";

static NSString * Pwd = @"sj@ios";

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
        return [NSString stringWithFormat:@"{}"] ;;
}








//+(void)setLogonId:(NSString *)logonId
//{
//    if (![NSString isBlankString:logonId])
//    {
//        LogonId = logonId;
//    }
//}
//
//+(NSString *)getLogonId
//{
//    return LogonId;
//}
//
//
//+(void)setPwd:(NSString *)pwd
//{
//    if (![NSString isBlankString:pwd])
//    {
//        Pwd = pwd;
//    }
//}
//
//+(NSString *)getPwd
//{
//    return Pwd;
//}





@end


@implementation CLYCCoreBizHttpRequest

+(void)loginYBUserWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
//    NSString *  path= [NSString stringWithFormat:@"%@%@",YB_HTTP_SERVER,@"UserLoginService"];
//    http://localhost:8080/wsportal/doService?wsdl
    
    NSString *  path= YB_HTTP_SERVER;
    
    
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"UserLoginService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            [HXUserModel shareInstance].userId = [NSString stringWithoutNil:returnDic[@"userId"]];
            
            [HXUserModel shareInstance].loginId = [NSString stringWithoutNil:returnDic[@"loginId"]];
            
            [HXUserModel shareInstance].userName = [NSString stringWithoutNil:returnDic[@"userName"]];
            
            [HXUserModel shareInstance].sex = [NSString stringWithoutNil:returnDic[@"sex"]];
            
            [HXUserModel shareInstance].email = [NSString stringWithoutNil:returnDic[@"email"]];
            
            [HXUserModel shareInstance].telphone = [NSString stringWithoutNil:returnDic[@"telephone"]];
            
            [HXUserModel shareInstance].roleNo = [NSString stringWithoutNil:returnDic[@"roleNo"]];
            
            [HXUserModel shareInstance].deptId = [NSString stringWithoutNil:returnDic[@"deptId"]];
            
            [HXUserModel shareInstance].deptName = [NSString stringWithoutNil:returnDic[@"deptName"]];
            
            if ([[HXUserModel shareInstance].roleNo isEqualToString:@"1"])
            {
                IS_DefaultUser = YES;
            }
            else
            {
                IS_DefaultUser = NO;
            }
            
            
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
        
        
        
    }];
   
}

+(void)selectCarInfoListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *,NSString *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;

    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarQueryPageListService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
          
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            
            NSArray *carListArray = [returnDic objectForKey:@"carList"];
            
            NSString *totalNum = [NSString stringWithoutNil:returnDic[@"totalNum"]];
            
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in carListArray)
                {
                    
                    SelectCarInfoModel *model = [[SelectCarInfoModel alloc]init];
                    
                    model.carCode = [NSString stringWithoutNil:dic[@"carCode"]];
                    
                    model.carId = [NSString stringWithoutNil:dic[@"carId"]];
                    
                    model.carModel = [NSString stringWithoutNil:dic[@"carModel"]];
                    
                    model.carModelId = [NSString stringWithoutNil:dic[@"carModelId"]];
                    
                    model.carType = [NSString stringWithoutNil:dic[@"carType"]];
                    
                    model.driver = [NSString stringWithoutNil:dic[@"driver"]];
                    
                    model.driverId = [NSString stringWithoutNil:dic[@"driverId"]];
                    
                    model.driverTel = [NSString stringWithoutNil:dic[@"driverTel"]];
                    
                    model.price = [NSString stringWithoutNil:dic[@"price"]];
                    
                    [mutabArray addObject:model];
                    
                    
                    
                }
            }
            
            
            
            
            
            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error,totalNum);
            }
            
  
            
            
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error,nil);
            }
        }
        
        
        
    }];
  
}

+(void)obtainApplyCarHistorWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *, NSString *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppByUserService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            
            NSArray *carListArray = [returnDic objectForKey:@"carAppList"];
            
            NSString *totalNum = [NSString stringWithoutNil:returnDic[@"totalNum"]];
            
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in carListArray)
                {
                    
                    ApplyCarDetailModel *model = [[ApplyCarDetailModel alloc]init];
                    
                    model.appId = [NSString stringWithoutNil:dic[@"appId"]];
                    
                    model.deptModel.deptId = [NSString stringWithoutNil:dic[@"carAppDeptId"]];
                    
                    model.projectModel.projectName = [NSString stringWithoutNil:dic[@"projectName"]];
                    
                    model.selectedCarModel.carCode = [NSString stringWithoutNil:dic[@"carCode"]];
                    
                    model.beginTime = [NSString stringWithoutNil:dic[@"beginTime"]];
                    
                    model.endTime = [NSString stringWithoutNil:dic[@"endTime"]];
                    
                    model.carAppUserName = [NSString stringWithoutNil:dic[@"carAppUserName"]];
                    
                    model.driver = [NSString stringWithoutNil:dic[@"driver"]];
                    
                    model.driverTel = [NSString stringWithoutNil:dic[@"driverTel"]];
                    
                    model.totalMil = [NSString stringWithoutNil:dic[@"totalMil"]];
                    
                    model.status = [NSString stringWithoutNil:dic[@"status"]];
                    
                    [mutabArray addObject:model];
                    
                    
                    
                }
            }
            
            
            
            
            
            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error,totalNum);
            }
            
            
            
            
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error,nil);
            }
        }
        
        
        
    }];
}


+(void)obtainDeptListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"DeptListService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            NSArray *deptListArray = [returnDic objectForKey:@"deptList"];

            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in deptListArray)
                {
                    
                    DeptListModel *model = [[DeptListModel alloc]init];
                    
                    model.deptId = [NSString stringWithoutNil:dic[@"deptId"]];
                    model.deptName =[NSString stringWithoutNil:dic[@"deptName"]];

                    [mutabArray addObject:model];
     
                }
            }

            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error);
            }
            
            
            
            
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error);
            }
        }
        
        
        
    }];
    
}

+(void)obtainProjectListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *, NSString *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"ProjectListService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            
            NSArray *projectListArray = [returnDic objectForKey:@"projectList"];
            
            NSString *totalNum = [NSString stringWithoutNil:returnDic[@"totalNum"]];
            
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in projectListArray)
                {
                    
                    ProjectListModel *model = [[ProjectListModel alloc]init];
                    
                    model.projectId =[NSString stringWithoutNil:dic[@"projectId"]];
                    
                    model.projectName =[NSString stringWithoutNil:dic[@"projectName"]];
                    
                    model.projectNo =[NSString stringWithoutNil:dic[@"projectNo"]];
                   
                    
                    [mutabArray addObject:model];
                    
                    
                    
                }
            }

            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error,totalNum);
            }
   
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error,nil);
            }
        }
        
        
        
    }];
}


+(void)saveApplyCarWithBlock:(void (^)(NSString *, NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppSaveNewService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
 
            NSString *appid = [NSString stringWithoutNil:returnDic[@"appId"]];
    
            if (block)
            {
                block(appid,retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,error);
            }
        }
        
        
        
    }];
}

+(void)obtainApplyCarDetailWithBlock:(void (^)(ApplyCarDetailModel *, NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppEditService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            ApplyCarDetailModel *model = [[ApplyCarDetailModel alloc]init];
            
            model.appId = [NSString stringWithoutNil:dic[@"appId"]];
            
            model.deptModel.deptId = [NSString stringWithoutNil:dic[@"carAppDeptId"]];
            model.deptModel.deptName = [NSString stringWithoutNil:dic[@"carAppDeptName"]];
            
            model.projectModel.projectId = [NSString stringWithoutNil:dic[@"projectId"]];
            model.projectModel.projectName = [NSString stringWithoutNil:dic[@"projectName"]];
            model.projectModel.projectNo = [NSString stringWithoutNil:dic[@"projectNo"]];
            
            model.selectedCarModel.carId = [NSString stringWithoutNil:dic[@"carId"]];
            model.selectedCarModel.carCode = [NSString stringWithoutNil:dic[@"carCode"]];
            
            model.beginAdrr = [NSString stringWithoutNil:dic[@"beginAdrr"]];
            model.endAdrr = [NSString stringWithoutNil:dic[@"endAdrr"]];

            model.beginTime = [NSString stringWithoutNil:dic[@"beginTime"]];
            
            model.endTime = [NSString stringWithoutNil:dic[@"endTime"]];
            
            model.carAppUserId = [NSString stringWithoutNil:dic[@"carAppUserId"]];
            model.carAppUserName = [NSString stringWithoutNil:dic[@"carAppUserName"]];
            
            model.carUse = [NSString stringWithoutNil:dic[@"carUse"]];

            model.status = [NSString stringWithoutNil:dic[@"status"]];
            
            model.appTime = [NSString stringWithoutNil:dic[@"appTime"]];

            model.appUserId = [NSString stringWithoutNil:dic[@"appUserId"]];
            model.appUserName = [NSString stringWithoutNil:dic[@"appUserName"]];

            model.applyDeptModel.deptId = [NSString stringWithoutNil:dic[@"appDeptId"]];
            model.applyDeptModel.deptName = [NSString stringWithoutNil:dic[@"appDeptName"]];
            
            
            model.beginMil = [NSString stringWithoutNil:dic[@"beginMil"]];

            model.beginMilStatus = [NSString stringWithoutNil:dic[@"beginMilStatus"]];

            model.beginMilRemark = [NSString stringWithoutNil:dic[@"beginMilRemark"]];

            model.finishMil = [NSString stringWithoutNil:dic[@"finishMil"]];

            model.addMil = [NSString stringWithoutNil:dic[@"addMil"]];

            model.finishMilStatus = [NSString stringWithoutNil:dic[@"finishMilStatus"]];

            model.finishMilRemark = [NSString stringWithoutNil:dic[@"finishMilRemark"]];

            if (block)
            {
                block(model,retCode,retMessage,error);
            }
    
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,error);
            }
        }
  
    }];
}

+(void)editApplyCarWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppSaveEditService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
        
        
        
    }];
}

+(void)commitApplyCarWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppUpdateStautsService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
        
        
        
    }];
}

+(void)deleteApplyCarWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppDelService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
        
        
        
    }];
}

+(void)obtainMileOrderConfirmListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *, NSString *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"QueryMilConfirmByUserService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            
            NSArray *carListArray = [returnDic objectForKey:@"carAppList"];
            
            NSString *totalNum = [NSString stringWithoutNil:returnDic[@"totalNum"]];
            
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in carListArray)
                {
                    
                    ApplyCarDetailModel *model = [[ApplyCarDetailModel alloc]init];
                    
                    model.appId = [NSString stringWithoutNil:dic[@"appId"]];
                    
                    model.deptModel.deptName = [NSString stringWithoutNil:dic[@"carAppDeptName"]];
                    
                    model.projectModel.projectName = [NSString stringWithoutNil:dic[@"projectName"]];
                    
                    model.selectedCarModel.carCode = [NSString stringWithoutNil:dic[@"carCode"]];
                    
                    model.beginTime = [NSString stringWithoutNil:dic[@"beginTime"]];
                    
                    model.endTime = [NSString stringWithoutNil:dic[@"endTime"]];
                    
                    model.carAppUserName = [NSString stringWithoutNil:dic[@"carAppUserName"]];
                    
                    model.driver = [NSString stringWithoutNil:dic[@"driver"]];
                    
                    model.driverTel = [NSString stringWithoutNil:dic[@"driverTel"]];
                    
                    model.beginAdrr = [NSString stringWithoutNil:dic[@"beginAdrr"]];
                    model.endAdrr = [NSString stringWithoutNil:dic[@"endAdrr"]];
                    
                    model.status = [NSString stringWithoutNil:dic[@"status"]];
                    
                    [mutabArray addObject:model];
         
                }
            }
 
            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error,totalNum);
            }
     
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error,nil);
            }
        }
 
    }];

}

+(void)userConfirmBeginMileWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppBeginMilCheckService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
    }];
}

+(void)userConfirmFinishMileWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppFinishMilCheckService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
    }];
}

+(void)driverObtainCarApplyListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *, NSString *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppByDriverService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            
            NSArray *carListArray = [returnDic objectForKey:@"carAppList"];
            
            NSString *totalNum = [NSString stringWithoutNil:returnDic[@"totalNum"]];
            
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in carListArray)
                {
                    
                    ApplyCarDetailModel *model = [[ApplyCarDetailModel alloc]init];
                    
                    model.appId = [NSString stringWithoutNil:dic[@"appId"]];
                    
                    model.deptModel.deptId = [NSString stringWithoutNil:dic[@"carAppDeptId"]];
                    
                    model.projectModel.projectName = [NSString stringWithoutNil:dic[@"projectName"]];
                    
                    model.selectedCarModel.carCode = [NSString stringWithoutNil:dic[@"carCode"]];
                    
                    model.beginTime = [NSString stringWithoutNil:dic[@"beginTime"]];
                    
                    model.endTime = [NSString stringWithoutNil:dic[@"endTime"]];
                    
                    model.carAppUserName = [NSString stringWithoutNil:dic[@"carAppUserName"]];
    
                    model.carAppUserTel =[NSString stringWithoutNil:dic[@"carAppUserTel"]];
                    
                    model.beginAdrr = [NSString stringWithoutNil:dic[@"beginAdrr"]];
                    
                    model.endAdrr =[NSString stringWithoutNil:dic[@"endAdrr"]];
                    
                    
                    model.status = [NSString stringWithoutNil:dic[@"status"]];
                
                    [mutabArray addObject:model];
           
                }
            }
    
            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error,totalNum);
            }
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error,nil);
            }
        }
    }];

}


+(void)driverCommitBeginMileWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppBeginMilService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
    }];
}


+(void)driverCommitFinishMileWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarAppFinishMilService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
    }];
}


+(void)driverUploadGPSWithBlock:(void (^)(NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"GpsUploadService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,error);
            }
        }
    }];
}


+(void)driverCarTrajectoryWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    NSString *  path= YB_HTTP_SERVER;
    
    [BaseHttpRequest basePostRequestWithPath:path keyArray:keyArray valueArray:valueArray methodName:@"CarTrajectoryQueryService" withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            NSDictionary *returnDic = (NSDictionary *)responseObject;
            
            
            NSArray *trajectoryListArray = [returnDic objectForKey:@"trajectoryList"];
                        
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            @autoreleasepool {
                for (NSDictionary *dic in trajectoryListArray)
                {
                    
                    TrajectoryListModel *model = [[TrajectoryListModel alloc]init];
                    
                    model.receiveTime = [NSString stringWithoutNil:dic[@"receiveTime"]];
                    
                    model.latitude = [NSString stringWithoutNil:dic[@"latitude"]];
                    
                    model.longitude = [NSString stringWithoutNil:dic[@"longitude"]];
                    
                    model.direction = [NSString stringWithoutNil:dic[@"direction"]];
                    
                    [mutabArray addObject:model];
                    
                }
            }
            
            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,error);
            }
        }
        else
        {
            if (block)
            {
                block([NSMutableArray array],retCode,retMessage,error);
            }
        }
    }];
}

@end
