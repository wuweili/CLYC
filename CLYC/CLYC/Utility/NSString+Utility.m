//
//  NSString+Utility.m
//  IOS-IM
//
//  Created by weili.wu on 13-10-16.
//  Copyright (c) 2013年 weihua. All rights reserved.
//

#import "NSString+Utility.h"
#import "HXOther.h"
#import "HXUserModel.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Utility)

+(NSString *)stringWithoutNil:(id)string
{
    NSString *tempStr = [NSString stringWithFormat:@"%@",string];
    
    return [NSString isBlankString:tempStr]?@"":tempStr;

}



+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL ) {
        
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([string isEqualToString:@"<null>"])
    {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    return NO;
}

/////////////////
+(BOOL)isBlankNSData:(NSData *)data
{
    if (data == nil || data == NULL) {
        
        return YES;
    }
    if ([data isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
   
    return NO;
}


//////////////////////////////////////////
//add by wuweili 这个判空不会处理空格的
+ (BOOL)isBlankStringButCanHaveSpace:(NSString *)string
{
    
    if (string == nil || string == NULL) {
        
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES; 
    }
    return NO;
}


//////////////////////////////////////////

+ (NSString *)urlWithNoExtension:(NSString *)imageUrl
{
    NSRange range = [imageUrl rangeOfString:@"."];
    NSString *resultString = imageUrl;
    
    if(range.location != NSNotFound)
    {
        resultString = [imageUrl substringToIndex:range.location];
    }
    
    return resultString;
}



+(NSString *)getAstroWithMonthDay:(NSString *)birthday
{
#define ASTRO_STAR_1   NSLocalizedString(@"魔蝎座", @"")
#define ASTRO_STAR_2   NSLocalizedString(@"水瓶座", @"")
#define ASTRO_STAR_3   NSLocalizedString(@"双鱼座", @"")
#define ASTRO_STAR_4   NSLocalizedString(@"白羊座", @"")
#define ASTRO_STAR_5   NSLocalizedString(@"金牛座", @"")
#define ASTRO_STAR_6   NSLocalizedString(@"双子座", @"")
#define ASTRO_STAR_7   NSLocalizedString(@"巨蟹座", @"")
#define ASTRO_STAR_8   NSLocalizedString(@"狮子座", @"")
#define ASTRO_STAR_9   NSLocalizedString(@"处女座", @"")
#define ASTRO_STAR_10  NSLocalizedString(@"天秤座", @"")
#define ASTRO_STAR_11  NSLocalizedString(@"天蝎座", @"")
#define ASTRO_STAR_12  NSLocalizedString(@"射手座", @"")

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDate = [dateFormat  dateFromString:birthday];
    if (!birthDate) {
        return nil;
    }
    NSString *rightBirthday = [dateFormat stringFromDate:birthDate];
    
    NSString *theMonth = [rightBirthday substringWithRange:NSMakeRange(5, 2)];
    int m = [theMonth intValue];
    
    NSString *theDay = [rightBirthday substringWithRange:NSMakeRange(8, 2)];
    int d = [theDay intValue];
    
    const NSArray * astroArray = [NSArray arrayWithObjects:ASTRO_STAR_1,ASTRO_STAR_2,ASTRO_STAR_3,ASTRO_STAR_4,ASTRO_STAR_5,ASTRO_STAR_6,ASTRO_STAR_7,ASTRO_STAR_8,ASTRO_STAR_9,ASTRO_STAR_10,ASTRO_STAR_11,ASTRO_STAR_12,ASTRO_STAR_1,nil];
    const NSString *astroFormat = @"102123444543";

    
    if (m<1||m>12||d<1||d>31){
        return nil;
    }
    
    if(m==2 && d>29)
    {
        return nil;
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return nil;
        }
    }
    NSUInteger index = m - (d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19));
    return astroArray[index];
}

+ (NSString *)getAge:(NSString *)bornStr
{
    NSInteger xage = 0;
    
    if([NSString isBlankString:bornStr])
    {
        return nil;
    }
    
    NSDateFormatter *formeatter=[[NSDateFormatter alloc] init];
    [formeatter setDateFormat:@"yyyy"];
    
    NSString *curYear = [[formeatter stringFromDate:[NSDate  date]] substringToIndex:4];
    xage = [curYear integerValue] - [[bornStr substringToIndex:4] integerValue];
    xage = (xage > 149) ? 150 : xage;
    xage = (xage < 0) ? 0 : xage;
        
    return [NSString stringWithFormat:@"%d",xage];
}

+ (NSString *)phonetic:(NSString *)sourceString
{
    NSMutableString *source = [sourceString mutableCopy];

     /*Transformation	                 Input	        Output
     *********************************************************
     CFString​Transform: wiki http://nshipster.com/cfstringtransform/
     kCFStringTransformMandarinLatin	中文	            zhōng wén 
     kCFStringTransformStripDiacritics  zhōng wén       zhong wen
     kCFStringTransformToLatin          中文 or chinese  zhōng wén or chinese
     */
    //string参数是要转换的string，比如要转换的中文，同时它是mutable的，因此也直接作为最终转换后的字符串。
    //range是要转换的范围，同时输出转换后改变的范围，如果为NULL，视为全部转换。
    //transform可以指定要进行什么样的转换，这里可以指定多种语言的拼写转换。
    //reverse指定该转换是否必须是可逆向转换的。如果转换成功就返回true，否则返回false
    Boolean isFinish = CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformToLatin, NO);
//    DDLogInfo(@"第一步转换%@:------>\n%@",isFinish?@"成功":@"失败",source);
    isFinish = CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
//    DDLogInfo(@"第二步转换%@:------>\n%@",isFinish?@"成功":@"失败",source);
    return source;
}

-(BOOL)searchResult:(NSString *)searchStr
{
	NSComparisonResult result = [self compare:searchStr options:NSCaseInsensitiveSearch
											   range:NSMakeRange(0, searchStr.length)];
	if (result == NSOrderedSame)
		return YES;
	else
		return NO;
}

+ (CGSize) sizeForString:(NSString *)value
                    font:(UIFont *)font
           textAlignment:(NSTextAlignment)alignment
                andWidth:(float)width
           lineBreakMode:(NSInteger)lineMode
{
    NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = lineMode;
    paragraph.alignment = alignment;
    
    NSAttributedString *attributeText=[[NSAttributedString alloc] initWithString:value attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph}];
    //options 有多个参数，详见苹果官方解释
    CGSize sizeToFit =[attributeText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return sizeToFit;
}


- (NSString *)trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



#pragma mark ------- NSString   MD5  ------

/**
 * MD5    获得16位 主要给文件命名
 */
+ (NSString *)getMD5_16_StrWithData:(NSData *)data
{
    unsigned char result[32];
    CC_MD5(data.bytes, data.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * MD5    获得16位 主要给密码加密
 */
+(NSString *)getMD5_16_Str:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

/**
 * MD5    获得前2位 主要获取文件名的HASH后的数值
 */

+(NSString *)getMD5_2_Str:(NSString *)str
{
    
    if ([NSString isBlankString:str])
    {
        return @"defaultPath";
    }
    
    
    // Create pointer to the string as UTF8
    const char *ptr = [str UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return [output substringToIndex:2];
}


/**
 * 通过时间后三位生成一个加密密钥
 */

+ (NSString *)encryptWithTime:(NSString *)time
{
    if (time) {
        NSString *keyStr = [time substringFromIndex:time.length - 3];
        int appendStr = 16 - (int)keyStr.length;
        
        for (int i = 0; i < appendStr; i ++)
        {
            keyStr = [keyStr stringByAppendingString:[NSString stringWithFormat:@"%x",appendStr]];
        }
        return keyStr;
    }
    return nil;
}

/**
 * MD5    16 位 大写
 */
+(NSString *)getMD5_16_UppercaseStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return  [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}






#pragma mark -- end   ---


- (NSString *)trim
{
    return
    [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)containOfString:(NSString *)aString
{
    return [self rangeOfString:aString].length > 0;
}

#pragma mark -

+ (NSString *)stringWithWeekday:(int)weekday
{
    if (weekday == 2){
        return STR_MONDAY;
    } else if (weekday == 3) {
        return STR_TUESDAY;
    } else if (weekday == 4) {
        return STR_WEDNESDAY;
    } else if (weekday == 5) {
        return STR_THURSDAY;
    } else if (weekday == 6) {
        return STR_FRIDAY;
    } else if (weekday == 7) {
        return STR_SATURDAY;
    } else if (weekday == 1) {
        return STR_SUNDAY;
    } else{
        return @"";
    }
}

+ (NSString *)stringWithMonth:(int)month
{
    if (month == 1){
        return STR_JANUARY;
    } else if (month == 2) {
        return STR_FEBRUARY;
    } else if (month == 3) {
        return STR_MARCH;
    } else if (month == 4) {
        return STR_APRIL;
    } else if (month == 5) {
        return STR_MAY;
    } else if (month == 6) {
        return STR_JUNE;
    } else if (month == 7) {
        return STR_JULY;
    } else if (month == 8) {
        return STR_AUGUST;
    } else if (month == 9) {
        return STR_SEPTEMBER;
    } else if (month == 10) {
        return STR_OCTOBER;
    } else if (month == 11) {
        return STR_NOVEMBER;
    } else if (month == 12) {
        return STR_DECEMBER;
    } else{
        return @"";
    }
}

- (NSDate *)stringWithDateFormatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:self];
    return date;
}

- (CGFloat)heightForWidth:(CGFloat)width withFont:(UIFont*)font
{
    NSAssert(font, @"heightForWidth:方法必须传进font参数");
    
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(size.height);
}

- (CGSize)sizeForWidth:(CGFloat)width withFont:(UIFont*)font
{
    NSAssert(font, @"heightForWidth:方法必须传进font参数");
    
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    size.height = ceilf(size.height);
    size.width = ceilf(size.width);
    return size;
}

- (CGFloat)singleWidthWithMaxWidth:(CGFloat)width withFont:(UIFont*)font
{
    NSAssert(font, @"singleWidthWithMaxWidth:方法必须传进font参数");
    
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return ceilf(size.width);
}

- (CGFloat)singleHeightWithFont:(UIFont*)font
{
    NSAssert(font, @"singleHeightWithFont:方法必须传进font参数");
    
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return ceilf(size.height);
}

- (CGSize)singleSizeWithFont:(UIFont*)font
{
    NSAssert(font, @"singleHeightWithFont:方法必须传进font参数");
    
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    size.height = ceilf(size.height);
    size.width = ceilf(size.width);
    
    return size;
}


@end
