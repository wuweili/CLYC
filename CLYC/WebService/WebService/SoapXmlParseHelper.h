//
//  XmlParseHelper.h
//  HttpRequest
//
//  Created by rang on 12-11-10.
//
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
@interface SoapXmlParseHelper : NSObject
/******************************webservice调用返回的xml处理*****************************************/
/****
   **获取webservice调用返回的xml内容
   **data:为NSData或NSString
   **methodName:调用的webservice方法名
 ***/
+(NSString*)SoapMessageResultXml:(id)xml ServiceMethodName:(NSString*)methodName;
/******************************xml转换成数组处理**************************************************/
/*****
   **xml转换成Array
   **xml:NSData或NSString
 *****/
+(NSMutableArray*)XmlToArray:(id)xml;
/*****
   **xml节点转换成Array
 *****/
+(NSMutableArray*)nodeChilds:(GDataXMLNode*)node;
/******************************xml节点查询处理**************************************************/
/*****
   **查找指定节点保存到数组中
   **data:NSData或NSString
   **name:节点名称
 *****/
+(NSMutableArray*)SearchNodeToArray:(id)data nodeName:(NSString*)name;
/*****
   **查找指定节点保存到数组中
   **data:NSData或NSString
   **name:节点名称
   **className:对象名称
 *****/
+(NSMutableArray*)SearchNodeToObject:(id)data nodeName:(NSString*)name objectName:(NSString*)className;
/******************************xml操作辅助方法**************************************************/
/*****
   **获取当前节点下的所有子节点保存到字典中
 *****/
+(NSMutableDictionary*)ChildsNodeToDictionary:(GDataXMLNode*)node;
/*****
   **获取当前节点下的所有子节点保存到对象中
 *****/
+(id)ChildsNodeToObject:(GDataXMLNode*)node objectName:(NSString*)className;
/******************************xml根节点操作**************************************************/
//获取根节点下的子节点
+(NSMutableDictionary*)rootNodeToArray:(id)data;
+(id)rootNodeToObject:(id)data objectName:(NSString*)className;
@end
