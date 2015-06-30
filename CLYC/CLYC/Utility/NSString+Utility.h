//
//  NSString+Utility.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)


+(NSString *)stringWithoutNil:(id)string;

//判断TextField等控件输入字符串是否为空——空指针或者空字符
+ (BOOL)isBlankString:(NSString *)string;

/**
 * 去除图片url后缀  如xxxx.jpg--->xxxx
 */
+ (NSString *)urlWithNoExtension:(NSString *)imageUrl;

//获取星座
+(NSString *)getAstroWithMonthDay:(NSString *)birthday;
//获取年龄
+ (NSString *)getAge:(NSString *)bornStr;

//汉子转字母
+ (NSString *)phonetic:(NSString *)sourceString;

//是否与searchT相等
-(BOOL)searchResult:(NSString *)searchStr;

+ (BOOL)isBlankStringButCanHaveSpace:(NSString *)string;

+ (CGSize) sizeForString:(NSString *)value
                    font:(UIFont *)font
           textAlignment:(NSTextAlignment)alignment
                andWidth:(float)width
           lineBreakMode:(NSInteger)lineMode;


//判断NSDATA是否为空
+ (BOOL)isBlankNSData:(NSData *)data;

/**
 * MD5    获得16位 主要给资源文件命名
 */
+ (NSString *)getMD5_16_StrWithData:(NSData *)data;

/**
 * MD5    获得16位 主要给密码加密  
 */
+(NSString *)getMD5_16_Str:(NSString *)str;

/**
 * MD5    获得前2位 主要获取文件名的HASH后的数值
 */

+(NSString *)getMD5_2_Str:(NSString *)str;

/**
 * 通过时间后三位生成一个加密密钥
 */

+ (NSString *)encryptWithTime:(NSString *)time;


/**
 * MD5    16 位 大写
 */
+(NSString *)getMD5_16_UppercaseStr:(NSString *)str;


- (NSString *)trimWhitespace;



- (NSString *)trim;


- (BOOL)containOfString:(NSString *)aString;

/**
 @brief 获取星期
 */
+ (NSString *)stringWithWeekday:(int)weekday;

/**
 @brief 获取月份
 */
+ (NSString *)stringWithMonth:(int)month;


/**
 *  @brief  根据字符串获取时间
 */
- (NSDate *)stringWithDateFormatter:(NSString *)formatter;

//计算label高度
- (CGFloat)heightForWidth:(CGFloat)width withFont:(UIFont*)font;

- (CGSize)sizeForWidth:(CGFloat)width withFont:(UIFont*)font;

- (CGFloat)singleWidthWithMaxWidth:(CGFloat)width withFont:(UIFont*)font;

- (CGFloat)singleHeightWithFont:(UIFont*)font;

- (CGSize)singleSizeWithFont:(UIFont*)font;


@end
