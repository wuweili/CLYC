//
//  XmlParseHelper.m
//  HttpRequest
//
//  Created by rang on 12-11-10.
//
//

#import "SoapXmlParseHelper.h"
#import "GDataXMLNode.h"

@implementation SoapXmlParseHelper
#pragma mark -
#pragma mark 获取methodName+Result里面的内容
/****
   **获取webservice调用返回的xml内容
   **data:为NSData或NSString
   **methodName:调用的webservice方法名
 ***/
+(NSString*)SoapMessageResultXml:(id)data ServiceMethodName:(NSString*)methodName{
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([data isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
    }else{
        document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    }
    if (error) {
        [document release];
        return @"";
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSString *searchStr=[NSString stringWithFormat:@"%@Result",methodName];
    NSString *MsgResult=@"";
    NSArray *result=[rootNode children];
    while ([result count]>0) {
        NSString *nodeName=[[result objectAtIndex:0] name];
        if ([nodeName isEqualToString: searchStr]) {
            MsgResult=[[result objectAtIndex:0] stringValue];
            break;
        }
        result=[[result objectAtIndex:0] children];
    }
    [document release];
    return MsgResult;
}
#pragma mark -
#pragma mark 将xml转换成数组
/*****
 **xml转换成Array
 **xml:NSData或NSString
 *****/
+(NSMutableArray*)XmlToArray:(id)xml{
    NSMutableArray *arr=[NSMutableArray array];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([xml isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
    }
    else
       document=[[GDataXMLDocument alloc] initWithData:xml options:0 error:&error];
    if (error) {
        [document release];
        return arr;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *node in rootChilds) {
        NSString *nodeName=node.name;
        if ([node.children count]>0) {
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[self nodeChilds:node],nodeName, nil]];
        }else{
            [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[node stringValue],nodeName, nil]];
        }
    }
    [document release];
    return arr;
}
+(NSMutableArray*)nodeChilds:(GDataXMLNode*)node{
    NSMutableArray *arr=[NSMutableArray array];
    NSArray *childs=[node children];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for (GDataXMLNode* child in childs){
        NSString *nodeName=child.name;//获取节点名称
        NSArray  *childNode=[child children];
        if ([childNode count]>0) {//存在子节点
            [dic setValue:[self nodeChilds:child] forKey:nodeName];
        }else{
            [dic setValue:[child stringValue] forKey:nodeName];
        }
    }
    [arr addObject:dic];
    return arr;
}
#pragma mark -
#pragma mark xml查询处理
/*****
   **查找指定节点保存到数组中
   **data:NSData或NSString
   **name:节点名称
 *****/
+(NSMutableArray*)SearchNodeToArray:(id)data nodeName:(NSString*)nodeName{
    NSMutableArray *array=[NSMutableArray array];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([data isKindOfClass:[NSString class]]) {
        data=[data stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"xmlns=\"%@\"",nodeName] withString:@""];
        document=[[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
    }else{
        document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    }
    if (error) {
        [document release];
        return array;
    }
    NSString *searchStr=[NSString stringWithFormat:@"//%@",nodeName];
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *childs=[rootNode nodesForXPath:searchStr error:nil];
    for (GDataXMLNode *item in childs){
        [array addObject:[self ChildsNodeToDictionary:item]];
    }
    [document release];
    return array;
}
/*****
 **查找指定节点保存到数组中
 **data:NSData或NSString
 **name:节点名称
 **className:对象名称
 *****/
+(NSMutableArray*)SearchNodeToObject:(id)data nodeName:(NSString*)name objectName:(NSString*)className{
    NSMutableArray *array=[NSMutableArray array];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([data isKindOfClass:[NSString class]]) {
        data=[data stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"xmlns=\"%@\"",name] withString:@""];
        document=[[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
    }else{
        document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    }
    if (error) {
        [document release];
        return array;
    }
    NSString *searchStr=[NSString stringWithFormat:@"//%@",name];
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *childs=[rootNode nodesForXPath:searchStr error:nil];
    for (GDataXMLNode *item in childs){
        [array addObject:[self ChildsNodeToObject:item objectName:className]];
    }
    [document release];
    return array;
}
#pragma mark -
#pragma mark xml操作辅助方法
+(NSMutableDictionary*)ChildsNodeToDictionary:(GDataXMLNode*)node{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSArray *childs=[node children];
    for (GDataXMLNode *item in childs) {
        [dic setValue:[item stringValue] forKey:item.name];
    }
    return dic;
}
+(id)ChildsNodeToObject:(GDataXMLNode*)node objectName:(NSString*)className{
    id obj=[[NSClassFromString(className) alloc] init];
    NSArray *childs=[node children];
    for (GDataXMLNode *item in childs){
        SEL sel=NSSelectorFromString(item.name);
        if ([obj respondsToSelector:sel]) {
            [obj setValue:[item stringValue] forKey:item.name];
        }
    }
    return [obj autorelease];
}
#pragma mark -
#pragma mark 对于xml只有一个根节点的处理
+(NSMutableDictionary*)rootNodeToArray:(id)data{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([data isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
    }else{
        document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    }
    if (error) {
        [document release];
        return dic;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *item in rootChilds){
        [dic setValue:[item stringValue] forKey:item.name];
    }
    [document release];
    return dic;
}
+(id)rootNodeToObject:(id)data objectName:(NSString*)className{
    id obj=[NSClassFromString(className) new];
    NSError *error=nil;
    GDataXMLDocument *document;
    if ([data isKindOfClass:[NSString class]]) {
        document=[[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
    }else{
        document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    }
    if (error) {
        [document release];
        return obj;
    }
    GDataXMLElement* rootNode = [document rootElement];
    NSArray *rootChilds=[rootNode children];
    for (GDataXMLNode *item in rootChilds){
        SEL sel=NSSelectorFromString(item.name);
        if ([obj respondsToSelector:sel]) {
            [obj setValue:[item stringValue] forKey:item.name];
        }

    }
    [document release];
    return obj;
}
@end
