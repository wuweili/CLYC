//
//  ServiceHelper.m
//  HttpRequest
//
//  Created by aJia on 2012/10/27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceHelper.h"
#import "SoapXmlParseHelper.h"

@implementation ServiceHelper
@synthesize delegate,httpRequest;
#pragma mark -
#pragma mark 初始化操作
-(id)initWithDelegate:(id<ServiceHelperDelegate>)theDelegate
{
	if (self=[super init]) {
		self.delegate=theDelegate;
        networkQueue=[[ASINetworkQueue alloc] init];
	}
	return self;
}
#pragma mark -
#pragma mark 获取公有请求的ASIHTTPRequest
-(ASIHTTPRequest*)commonServiceRequestUrl:(NSString*)url serviceNameSpace:(NSString*)nameSapce serviceMethodName:(NSString*)methosName soapMessage:(NSString*)soapMsg{
    NSURL *webUrl=[NSURL URLWithString:url];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:webUrl];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[request addRequestHeader:@"Host" value:[webUrl host]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[request addRequestHeader:@"Content-Length" value:msgLength];
    [request addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",nameSapce,methosName]];
    [request setRequestMethod:@"POST"];
    //设置用户信息
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:methosName,@"name", nil]];
	//传soap信息
    [request appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30.0];//表示30秒请求超时
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    return request;
}
+(ASIHTTPRequest*)commonSharedServiceRequestUrl:(NSString*)url serviceNameSpace:(NSString*)nameSapce serviceMethodName:(NSString*)methosName soapMessage:(NSString*)soapMsg{
    NSURL *webUrl=[NSURL URLWithString:url];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:webUrl];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[request addRequestHeader:@"Host" value:[webUrl host]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[request addRequestHeader:@"Content-Length" value:msgLength];
    [request addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",nameSapce,methosName]];
    [request setRequestMethod:@"POST"];
    //设置用户信息
    //[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:methosName,@"name", nil]];
	//传soap信息
    [request appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30.0];//表示30秒请超时
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    return request;

}
+(ASIHTTPRequest*)commonSharedRequestMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg{
    return [self commonSharedServiceRequestUrl:defaultWebServiceUrl serviceNameSpace:defaultWebServiceNameSpace serviceMethodName:methodName soapMessage:soapMsg];
}
#pragma mark -
#pragma mark 同步请求
-(NSString*)syncServiceRequestUrl:(NSString*)url serviceNameSpace:(NSString*)nameSapce serviceMethodName:(NSString*)methodName soapMessage:(NSString*)soapMsg{
    if (self.httpRequest.delegate) {
        [self.httpRequest setDelegate:nil];
    }
    [self.httpRequest cancel];
    NSURL *webUrl=[NSURL URLWithString:url];
    [self setHttpRequest:[ASIHTTPRequest requestWithURL:webUrl]];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[self.httpRequest addRequestHeader:@"Host" value:[webUrl host]];
    [self.httpRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[self.httpRequest addRequestHeader:@"Content-Length" value:msgLength];
    [self.httpRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",nameSapce,methodName]];
    [self.httpRequest setRequestMethod:@"POST"];
    //设置用户信息
    [self.httpRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:methodName,@"name", nil]];
	//传soap信息
    [self.httpRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [self.httpRequest setValidatesSecureCertificate:NO];
    [self.httpRequest setTimeOutSeconds:30.0];//表示30秒请求超时
    [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    
    /***
    ASIHTTPRequest *request=[self commonServiceRequestUrl:url ServiceNameSpace:nameSapce ServiceMethodName:methodName SoapMessage:soapMsg];
     ***/
    //设置同步
    [self.httpRequest startSynchronous];
    //处理返回的结果
    return [self soapMessageResult:self.httpRequest];
}
-(NSString*)syncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg{
    return [self syncServiceRequestUrl:defaultWebServiceUrl serviceNameSpace:defaultWebServiceNameSpace serviceMethodName:methodName soapMessage:soapMsg];
}
#pragma mark -
#pragma mark 异步请求
-(void)asynServiceRequestUrl:(NSString*)url serviceNameSpace:(NSString*)nameSapce serviceMethodName:(NSString*)methodName soapMessage:(NSString*)soapMsg{
     NSURL *webUrl=[NSURL URLWithString:url];
    [self.httpRequest setDelegate:nil];
    [self.httpRequest cancel];
    [self setHttpRequest:[ASIHTTPRequest requestWithURL:webUrl]];
   

    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
	
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
	[self.httpRequest addRequestHeader:@"Host" value:[webUrl host]];
    [self.httpRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[self.httpRequest addRequestHeader:@"Content-Length" value:msgLength];
    [self.httpRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",nameSapce,methodName]];
    [self.httpRequest setRequestMethod:@"POST"];
    //设置用户信息
    [self.httpRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:methodName,@"name", nil]];
	//传soap信息
    [self.httpRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [self.httpRequest setValidatesSecureCertificate:NO];
    [self.httpRequest setTimeOutSeconds:30.0];//表示30秒请求超时
    [self.httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [self.httpRequest setDelegate:self];
    //异步请求
	[self.httpRequest startAsynchronous];
}
-(void)asynServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg{
    [self asynServiceRequestUrl:defaultWebServiceUrl serviceNameSpace:defaultWebServiceNameSpace serviceMethodName:methodName soapMessage:soapMsg];
}
#pragma mark -
#pragma mark ASIHTTPRequest delegate Methods
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *result=[self soapMessageResult:request];
	[self.delegate finishSuccessRequest:result];
	
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	[self.delegate finishFailRequest:error];
}
#pragma mark -
#pragma mark 队列请求
//开始排列
-(void)resetQueue{
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue reset];
    //表示队列操作完成
    [networkQueue setQueueDidFinishSelector:@selector(queueFetchComplete:)];
    [networkQueue setRequestDidFinishSelector:@selector(requestFetchComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(requestFetchFailed:)];
    [networkQueue setDelegate:self];
}
-(void)startQueue{
    [networkQueue go];
}
//添加队列
-(void)addRequestQueue:(ASIHTTPRequest*)request{
    [networkQueue addOperation:request];
}
//队列请求处理
-(void)queueFetchComplete:(ASIHTTPRequest*)request{
    [self.delegate finishQueueComplete];
}
-(void)requestFetchComplete:(ASIHTTPRequest*)request{
   
	NSString *result=[self soapMessageResult:request];
    [self.delegate finishSingleRequestSuccess:result userInfo:[request userInfo]];
    
}
-(void)requestFetchFailed:(ASIHTTPRequest*)request{
    [self.delegate finishSingleRequestFailed:[request error] userInfo:[request userInfo]];
}
#pragma mark -
#pragma mark 对于返回soap信息的处理
/********对于返回soap信息的处理**********/
-(NSString*)soapMessageResult:(ASIHTTPRequest*)request{
    int statusCode = [request responseStatusCode];
    NSError *error=[request error];
    //如果发生错误，就返回空
    if (error||statusCode!=200) {
        return @"";
    }
	NSString *soapAction=[[request requestHeaders] objectForKey:@"SOAPAction"];
    NSString *methodName=@"";
    NSRange range = [soapAction  rangeOfString:@"/" options:NSBackwardsSearch];
    if(range.location!=NSNotFound){
        int pos=range.location;
        methodName=[soapAction stringByReplacingCharactersInRange:NSMakeRange(0, pos+1) withString:@""];
    }
	// Use when fetching text data
	NSString *responseString = [request responseString];
	NSString *result=[SoapXmlParseHelper SoapMessageResultXml:responseString ServiceMethodName:methodName];

    return result;
}
-(void)dealloc{
    [httpRequest setDelegate:nil];
    [httpRequest cancel];
    [httpRequest release];
    if (networkQueue) {
        [networkQueue reset];
        [networkQueue release];
    }
	[super dealloc];
}
@end
