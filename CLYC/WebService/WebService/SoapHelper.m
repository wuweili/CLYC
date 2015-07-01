//
//  SoapHelper.m
//  HttpRequest
/****
 //SOAP Envelope
 GDataXMLElement *envelope = [GDataXMLElement elementWithName:@"soap:Envelope"];
 
 GDataXMLNode *soapNS = [GDataXMLNode namespaceWithName:@"soap" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"];
 GDataXMLNode *xsiNS = [GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"];
 GDataXMLNode *xsdNS = [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"];
 GDataXMLNode *defaultNS = [GDataXMLNode namespaceWithName:@"" stringValue:@"http://60.251.51.217/ElandMC.Admin/WebServices/"];
 
 NSArray *namespaces = [NSArray arrayWithObjects:xsiNS, xsdNS, soapNS, nil];
 [envelope setNamespaces:namespaces];
 
 //SOAP Body
 GDataXMLElement *body = [GDataXMLElement elementWithName:@"soap:Body"];
 
 //SOAP Value
 GDataXMLElement *value = [GDataXMLElement elementWithName:@"getProductAd"];
 [value addNamespace:defaultNS];
 [body addChild:value];
 
 [envelope addChild:body];
 
 //SOAP Document
 GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithRootElement:envelope];
 [doc setCharacterEncoding:@"utf-8"];
 
 NSLog(@"doc = %@", [NSString stringWithCString:(const char *)[[doc XMLData] bytes] encoding:NSUTF8StringEncoding]);
 [doc release];
 ****/

//  Created by rang on 12-10-27.
//
//

#import "SoapHelper.h"
@implementation SoapHelper
+(NSString*)defaultSoapMesage{
   NSString *soapBody=@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
    "<soap:Body>%@</soap:Body></soap:Envelope>";
    return soapBody;
}
+(NSString*)methodSoapMessage:(NSString*)methodName{
    NSMutableString *soap=[NSMutableString stringWithFormat:@"<%@ xmlns=\"%@\">",methodName,defaultWebServiceNameSpace];
    [soap appendString:@"%@"];
    [soap appendFormat:@"</%@>",methodName];
    return [NSString stringWithFormat:[self defaultSoapMesage],soap];
}
+(NSString*)nameSpaceSoapMessage:(NSString*)space methodName:(NSString*)methodName{
    NSMutableString *soap=[NSMutableString stringWithFormat:@"<%@ xmlns=\"%@\">",methodName,space];
    [soap appendString:@"%@"];
    [soap appendFormat:@"</%@>",methodName];
    return [NSString stringWithFormat:[self defaultSoapMesage],soap];
}
+(NSString*)arrayToDefaultSoapMessage:(NSArray*)arr methodName:(NSString*)methodName{
    if ([arr count]==0||arr==nil) {
        return [NSString stringWithFormat:[self methodSoapMessage:methodName],@""];
    }
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    for (NSDictionary *item in arr) {
        NSString *key=[[item allKeys] objectAtIndex:0];
        [msg appendFormat:@"<%@>",key];
        [msg appendString:[item objectForKey:key]];
        [msg appendFormat:@"</%@>",key];
    }
    return [NSString stringWithFormat:[self methodSoapMessage:methodName],msg];
}
+(NSString*)arrayToNameSpaceSoapMessage:(NSString*)space params:(NSArray*)arr methodName:(NSString*)methodName{
    if ([arr count]==0||arr==nil) {
        return [NSString stringWithFormat:[self nameSpaceSoapMessage:space methodName:methodName],@""];
    }
    NSMutableString *msg=[NSMutableString stringWithFormat:@""];
    for (NSDictionary *item in arr) {
        NSString *key=[[item allKeys] objectAtIndex:0];
        [msg appendFormat:@"<%@>",key];
        [msg appendString:[item objectForKey:key]];
        [msg appendFormat:@"</%@>",key];
    }
    return [NSString stringWithFormat:[self nameSpaceSoapMessage:space methodName:methodName],msg];
}
@end
