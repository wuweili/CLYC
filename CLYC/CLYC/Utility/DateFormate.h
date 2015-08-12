
#import <Foundation/Foundation.h>
#import "StringBuilder.h"

@interface DateFormate : NSObject {
    
}

+ (BOOL)IsAM : (NSInteger)hour;
+ (int)GetHH12 : (NSUInteger)hour;

+ (NSString*)GetString_ddMMMyyyy: (NSDate*)date; //Month is short by English word ; dd-mmm-yyyy
+ (NSString*)GetString_ddMMyyyy: (NSDate*)date;// dd.mm.yyyy
+ (NSString*)GetString_hhmmAMPM : (NSDate*)date; // hh:mm am/pm
+ (NSString*)GetString : (NSDate*)date;//dd-mmm-yyyy hh:mm am/pm
+ (NSString*)GetString_yyyymmddhhmm: (NSDate*)date; //yyyy-mm-dd hh:mm

+ (NSString *) ChangeTimeFormat:(NSString *)timeStr; //2009-05-15 03:08:10.0 To 15.05.09
+ (NSString *) ChangeTimeFormatWithMonth:(NSString *)timeStr; //2009-05-15 03:08:10.0 To 15 Mail 09, 03:08:10.0
+ (NSString *) ChangeTimeFormat2:(NSString *)timeStr; //08.07.2009 07:25 To 2009-05-15 03:08:10.0
+ (NSString *) ChangeTimeFormat3:(NSString *)timeStr; //08.07.2009 07:25 To today 07:25 PM/AM

+(NSDate *)ChangeStrToDate:(NSString *)timeStr;
+ (NSDate *) NSStringDateToNSDate:(NSString *)string; //yyyy-MM-dd HH:mm:ss With TimeZone
+ (NSDate *)GetDateByString:(NSString *)timeStr; //june 09/2009 to date

+ (NSString *)GetCurrentTime:(NSString *)timeFormat;  //Get current time formate string by formate
+ (NSString *) BuildStringTimeByZone:(NSString *)string TimeZone:(NSTimeZone *)zone;

+(int)GetDay:(NSDate *)date;
+(int)GetMonth:(NSDate *)date;
+(int)GetYear:(NSDate *)date;
+(int)GetHour:(NSDate *)date;
+(int)GetMinute:(NSDate *)date;
+(int)GetSecond:(NSDate *)date;

+(NSString *)GetWeedDay:(NSDate *)date;

+(NSString *)GetHourAndMinute:(NSDate *)date;

+(NSString *)GetHourAndMinuteFromatter:(NSDate *)date;

////change 2014-01-13 23:59 to 01-13 23:59 add by xishuaishuai
+(NSString *)ChangeStrToDateMDHS:(NSString *)timeStr;
+(NSString *)ChangeStrToDateMDHSS:(NSString *)timeStr;//change 2014-01-16 16:56:50 to 01-16 16:56 add by yuhaiping

//add by xishuaishuai
+(NSString *)GetLastMsgTimeString:(NSString *)timeString;

+(NSString *)GetMsgTimeString:(NSString *)timeString;

+ (NSString *) NSStringDateToString:(NSDate *)date; //yyyy-MM-dd HH:mm:ss With yyyy-MM-ddTHH:mm:ssZ
//end by xishuaishuai

+(NSString *)timeConvertWithTimeStr:(NSString *)timeStr;

+(NSString *)GetString_YYYMMDD:(NSString *)dateStr;//2014-05-14 to 2014年05月14日


+(NSString *)GetString_YYYMM:(NSString *)dateStr;   //1970-01-12  --->> 1970年1月

+(NSString *)timeConvertToYYYY_MM_DD_HH_MM_SSWithTimeStr:(NSString *)timeStr WithDetail:(BOOL)flag;

//add by wuweili
+(NSString *)get_yyyyddmmAMPMhhmm:(NSString *)datastr;


+(NSString *)timeConvertToyyyyMMddHHmmWithTimeStr:(NSString *)timeStr; //时间戳--->> 2014-05-26 11:25

+(NSDate*)getNSDateFromTimeStr:(NSString *)timeStr;

+(NSString *)getTimeIntervalFromTimeStr:(NSString *)timeStr; //时间转化为时间戳


/**
 * 计算从今天到未来摸个时间的间隔天数
 */

+(NSInteger)getResidualDaysWithEndTimeStr:(NSString *)endTimeStr systemNowTimeStr:(NSString *)systemNowTimeStr; //计算从今天到未来摸个时间的间隔天数

+(NSString *)newInterfaceTimeType:(NSString *)timeStr WithDetail:(BOOL)flag;

+(NSString *)getCurrentTimeWithNoDian:(NSDate*)date;

+(NSString *)getThreeDaysAfterTimeStr;

+ (NSString *) NSStringLocationDateToString:(NSDate *)date;

+(NSString *)getOtherDaysWithDays:(NSInteger)days beginTime:(NSString *)beginTime;

@end
