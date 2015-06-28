//
//  NSString+Base64.m
//  HealthNews
//
//  Created by Zhang Cheng on 12-1-22.
//  Copyright (c) 2012年 freewolf.me. All rights reserved.
//

#import "NSString+Additional.h"

@implementation NSString(Additional)
#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))
static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static char decodingTable[128];

+ (void) base64Initialize 
{
    memset(decodingTable, 0, ArrayLength(decodingTable));
    for (NSInteger i = 0; i < ArrayLength(encodingTable); i++) 
    {
        decodingTable[encodingTable[i]]
        = i;
    }
}

+(NSString*) base64EncodeString:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return  [self base64Encode:data];
}
+ (NSString*) base64Encode:(const uint8_t*) input length:(NSInteger) length {
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
	
    for (NSInteger i = 0; i < length; i += 3)
    {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) 
        {
            value <<= 8;
			
            if (j < length) 
            {
                value |= (0xFF & input[j]);
            }
        }
		
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    encodingTable[(value >> 18) & 0x3F];
        output[index + 1] =                    encodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[[NSString alloc] initWithData:data
                                  encoding:NSASCIIStringEncoding] autorelease];
}


+ (NSString*) base64Encode:(NSData*) rawBytes 
{
    return [self base64Encode:(const uint8_t*) rawBytes.bytes length:rawBytes.length];
}


+ (NSData*) base64Decode:(const char*) string length:(NSInteger) inputLength 
{
	if ((string == NULL) || (inputLength % 4 != 0)) 
    {
		return nil;
	}
	
	while (inputLength > 0 && string[inputLength - 1] == '=')
    {
		inputLength--;
	}
	
	NSInteger outputLength = inputLength * 3 / 4;
	NSMutableData* data = [NSMutableData dataWithLength:outputLength];
	uint8_t* output = data.mutableBytes;
	
	NSInteger inputPoint = 0;
	NSInteger outputPoint = 0;
	while (inputPoint < inputLength) 
    {
		char i0 = string[inputPoint++];
		char i1 = string[inputPoint++];
		char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A'; /* 'A' will decode to \0 */
		char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';
		
		output[outputPoint++] = (decodingTable[i0] << 2) | (decodingTable[i1] >> 4);
		if (outputPoint < outputLength) 
        {
			output[outputPoint++] = ((decodingTable[i1] & 0xf) << 4) | (decodingTable[i2] >> 2);
		}
		if (outputPoint < outputLength) 
        {
			output[outputPoint++] = ((decodingTable[i2] & 0x3) << 6) | decodingTable[i3];
		}
	}
	
	return data;
}


+ (NSData*) base64DecodeToData:(NSString*) string 
{
	return [self base64Decode:[string cStringUsingEncoding:NSASCIIStringEncoding] length:string.length];
}

+ (NSString*) base64DecodeToString:(NSString*) string
{
    NSData *data = [self base64DecodeToData:string];
    return  [[[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding] autorelease];
}

+ (NSString*)removeStringSpace:(NSString*)input
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *output = [input stringByTrimmingCharactersInSet:whitespace];
    return output;
}
@end
