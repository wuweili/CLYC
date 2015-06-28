//
//  NSString+Base64.h
//  HealthNews
//
//  Created by Zhang Cheng on 12-1-22.
//  Copyright (c) 2012年 freewolf.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Additional)
+ (void) base64Initialize;
+(NSString*) base64EncodeString:(NSString*)input;
+ (NSString*) base64Encode:(const uint8_t*) input length:(NSInteger) length;
+ (NSString*) base64Encode:(NSData*) rawBytes;
+ (NSData*) base64Decode:(const char*) string length:(NSInteger) inputLength;
+ (NSData*) base64DecodeToData:(NSString*) string;
+ (NSString*) base64DecodeToString:(NSString*) string;
+ (NSString*) removeStringSpace:(NSString*)input;
@end
