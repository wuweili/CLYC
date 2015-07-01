//
//  WebServices.h
//  HttpRequest
//
//  Created by aJia on 12/11/9.
//
//

#import <Foundation/Foundation.h>

//异步调用完成的协议
@protocol WebServiceDelegate <NSObject>
@optional
-(void)requestFinishedMessage:(NSString*)xml;
-(void)requestFailedMessage:(NSError*)error;
@end

@interface WebServices : NSObject

@property(nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,assign) id<WebServiceDelegate> delegate;
-(id)initWithDelegate:(id<WebServiceDelegate>)thedelegate;

//公有方法
-(NSMutableURLRequest*)commonRequestUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
+(NSMutableURLRequest*)commonSharedRequestUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
//同步调用
-(NSString*)syncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
-(NSString*)syncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg;
//异步调用
-(void)asyncServiceUrl:(NSString*)wsUrl nameSpace:(NSString*)space methodName:(NSString*)methodname soapMessage:(NSString*)soapMsg;
-(void)asyncServiceMethod:(NSString*)methodName soapMessage:(NSString*)soapMsg;

@end
