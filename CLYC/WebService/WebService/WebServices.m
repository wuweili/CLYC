//
//  WebServices.m
//  HttpRequest
//
//  Created by aJia on 12/11/9.
//
//

#import "WebServices.h"
#import "SoapXmlParseHelper.h"
@implementation WebServices
@synthesize delegate;
@synthesize receivedData;
-(id)initWithDelegate:(id<WebServiceDelegate>)thedelegate{
    if (self=[super init]) {
        self.delegate=thedelegate;
    }
    return self;
}
-(NSMutableURLRequest*)commonRequestUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg{
    

    NSURL *url=[NSURL URLWithString:wsUrl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    NSString *soapAction=[NSString stringWithFormat:@"%@%@",space,methodname];
    //头部设置
    NSDictionary *headField=[NSDictionary dictionaryWithObjectsAndKeys:[url host],@"Host",
                             @"text/xml; charset=utf-8",@"Content-Type",
                             msgLength,@"Content-Length",
                             soapAction,@"SOAPAction",nil];
    [request setAllHTTPHeaderFields:headField];
    //超时设置
    [request setTimeoutInterval: 30 ];
    //访问方式
    [request setHTTPMethod:@"POST"];
    //body内容
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
     
}
+(NSMutableURLRequest*)commonSharedRequestUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg{
    NSURL *url=[NSURL URLWithString:wsUrl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
  
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    NSString *soapAction=[NSString stringWithFormat:@"%@%@",space,methodname];
    //头部设置
    NSDictionary *headField=[NSDictionary dictionaryWithObjectsAndKeys:[url host],@"Host",
                             @"text/xml; charset=utf-8",@"Content-Type",
                             msgLength,@"Content-Length",
                             soapAction,@"SOAPAction",nil];
    [request setAllHTTPHeaderFields:headField];
    //超时设置
    [request setTimeoutInterval: 30 ];
    //访问方式
    [request setHTTPMethod:@"POST"];
    //body内容
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}
#pragma -
#pragma 同步调用
-(NSString*)syncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg{
      
    NSMutableURLRequest *request=[self commonRequestUrl:wsUrl nameSpace:space methodName:methodname soapMessage:soapMsg];
    NSError *err=nil;
    NSHTTPURLResponse *urlResponse = nil; 
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&err];
    if (err||urlResponse.statusCode!=200) {
        return @"";
    }
    return [SoapXmlParseHelper SoapMessageResultXml:data ServiceMethodName:methodname];
}
-(NSString*)syncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg{
    return [self syncServiceUrl:defaultWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:methodName soapMessage:soapMsg];
}
#pragma -
#pragma 异步调用
-(void)asyncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg{
    NSMutableURLRequest *request =[self commonRequestUrl:wsUrl nameSpace:space methodName:methodname soapMessage:soapMsg];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if(conn ){
        self.receivedData = [NSMutableData data];
    }
}
-(void)asyncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg{
    [self asyncServiceUrl:defaultWebServiceUrl nameSpace:defaultWebServiceNameSpace methodName:methodName soapMessage:soapMsg];
}
#pragma mark -
#pragma mark NSURLConnection delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    connection = nil;
    self.receivedData = nil;
    [self.delegate requestFailedMessage:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   NSDictionary *dic=connection.currentRequest.allHTTPHeaderFields;
    NSString *soapAction=[dic objectForKey:@"SOAPAction"];
	NSString *methodName=[soapAction stringByReplacingOccurrencesOfString:defaultWebServiceNameSpace withString:@""];
   [self.delegate requestFinishedMessage:[SoapXmlParseHelper SoapMessageResultXml:self.receivedData ServiceMethodName:methodName]];
    
    connection = nil;
}
-(void)dealloc{
    [super dealloc];
    [receivedData release];
}
@end
