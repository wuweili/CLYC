/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800

@interface NSDate (Utilities)

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSUInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSUInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSUInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays;
- (NSDate *) dateByAddingHours: (NSUInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;
@property (readonly) NSInteger lastDayOfMonth;

// add by zhangkan
- (NSString *)stringFromFormatterString:(NSString *)formatterStr;
- (NSString *)stringForChatList;
- (NSString *)stringForTwelveHours;
- (NSString *)stringForPushMessage;

/**
 @brief 时间在列表中的显示
 */
- (NSString *)stringForList;
/**
 @brief 时间在详情中的显示
 */
- (NSString *)stringForDetail;

/**
 @brief 时间在IM列表中的显示
 */
- (NSString *)stringForIMList;


+ (id)dateWithServerTimeInterval:(NSString *)timeInterval;

//  获取当前时间所在的年、月、日的其实时间
- (NSDate *)currentDayStartDate;
- (NSDate *)currentMonthStartDate;
- (NSDate *)currentYearStartDate;

/**
 * 新的时间格式调用
 */
+(NSDate*)dateWithString:(NSString*)string;

/**
 * 老的时间格式调用   时间戳
 */

+(NSDate*)dateWithNSTimeIntervalString:(NSString*)string;


//date转时间戳
-(NSString *)timeStamp;

/**
 @brief 判断当前是闰年
 */
- (BOOL)isLeapYear;

/**
 @brief 两个时间之间的天数差（两时间均按00：00：00算）
 */
- (int)daysSinceDate:(NSDate *)start;


/**
 * 面诊详情使用
 */
+(NSString *)stringForFaceDiagnoseCellWithIsHour:(NSString *)isHour dateStr:(NSString *)dateStr;


/**
 * 获取当前时间
 */
-(NSString *)getCurrentTimeStrWithDate;



/**
 * 新的时间格式调用  除IM外的其他地方时间格式 20150508164723000 -> 12：12      昨天      星期三     2012-12-12
 */

+(NSString *)timeStrForListWithDateStr:(NSString *)dateStr;


/**
 *  新的时间格式调用 IM聊天界面时间格式 20150508164723000 -> 12：12 昨天 12：12    星期三 12：12 2012-12-12 12：12
 */

+(NSString *)timeStrForIMChatDetailWithDateStr:(NSString *)dateStr;


/**
 *  老的时间格式  列表时间格式 时间戳 -> 12：12 昨天 星期三 2012-12-12
 */

+(NSString *)timeStrForListWithNSTimeIntervalStringStr:(NSString *)dateStr;

/**
 *  老的时间格式  详情时间格式 时间戳 -> 12：12 昨天 12：12 星期三 12：12 2012-12-12 12：12
 */

+(NSString *)timeStrForDetailWithNSTimeIntervalStringStr:(NSString *)dateStr;


/**
 * 文章列表 时间展示 2015-01-01
 */
+(NSString *)timeStrForyyyyMMddWithNSTimeIntervalStringStr:(NSString *)dateStr;


/**
 *  文章详情格式  详情时间格式 2012-12-12
 */

+(NSString *)timeStrForArticleDetailWithDateStr:(NSString *)dateStr;

/**
 * 文章评论列表 时间展示 2015-01-01 18：30
 */
+(NSString *)timeStrForArticleCommentWithNSTimeIntervalStringStr:(NSString *)dateStr;

@end
