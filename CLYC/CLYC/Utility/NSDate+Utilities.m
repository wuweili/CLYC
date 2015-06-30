/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/*
 #import <humor.h> : Not planning to implement: dateByAskingBoyOut and dateByGettingBabysitter
 ----
 General Thanks: sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej
*/

#import "NSDate+Utilities.h"
#import "NSString+Utility.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]


@implementation NSDate (Utilities)

#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) && 
			([components1 day] == [components2 day]));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if ([components1 week] != [components2 week]) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return ([components1 year] == [components2 year]);
}

- (BOOL) isThisYear
{
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return ([components1 year] == ([components2 year] + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return ([components1 year] == ([components2 year] - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self earlierDate:aDate] == self);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self laterDate:aDate] == self);
}


#pragma mark Adjusting Dates

- (NSDate *)dateByAddingYears: (NSUInteger) dYears
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.year = components.year + dYears;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateByAddingMonths: (NSUInteger) dMonths
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.month = components.month + dMonths;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *) dateByAddingDays: (NSUInteger) dDays
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSUInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
	return [components hour];
}

- (NSInteger) hour
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components hour];
}

- (NSInteger) minute
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components minute];
}

- (NSInteger) seconds
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components second];
}

- (NSInteger) day
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components day];
}

- (NSInteger) month
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components month];
}

- (NSInteger) week
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components week];
}

- (NSInteger) weekday
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components weekday];
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components weekdayOrdinal];
}
- (NSInteger) year
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components year];
}

- (NSInteger) lastDayOfMonth
{
    int dayNum = 0;
    switch (self.month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            dayNum = 31;
            break;
        case 4: case 6: case 9: case 11:
            dayNum = 30;
            break;
        case 2:
            if ([self isLeapYear]) {
                dayNum = 29;
            }else{
                dayNum = 28;
            }
            break;
        default:
            break;
    }
    return dayNum;
}

- (NSString *)stringFromFormatterString:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:self];
}

- (NSString *)stringForChatList
{
    NSString *timeStr = @"";
    
    if ([self isToday])
    {
        timeStr = [self stringForTwelveHours];
    }
    else if ([self isTomorrow])
    {
        timeStr = STR_TOMORROW;
    }
    else if ([self isYesterday])
    {
        timeStr = STR_YESTERDAY;
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        timeStr = [formatter stringFromDate:self];
    }
    return timeStr;
}

- (NSString *)stringForTwelveHours
{
    int hourNum = 0;
    NSString *timeStr = @"";
    if (self.hour > 13) {
        hourNum = self.hour - 13;
        timeStr = @"下午";
    }else{
        hourNum = self.hour;
        timeStr = @"上午";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
    [formatter setDateFormat:@"mm"];
    return [NSString stringWithFormat:@"%@%d:%@",timeStr,hourNum,[formatter stringFromDate:self]];
}

- (NSString *)stringForPushMessage
{
    NSString *timeStr = @"";
    
    if ([self isToday])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
        [formatter setDateFormat:@"mm"];
        timeStr = [NSString stringWithFormat:@"%@%d:%@",STR_TODAY,self.hour,[formatter stringFromDate:self]];
    }
    else if ([self isTomorrow])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
        [formatter setDateFormat:@"mm"];
        timeStr = [NSString stringWithFormat:@"%@%d:%@",STR_TOMORROW,self.hour,[formatter stringFromDate:self]];
    }
    else if ([self isYesterday])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
        [formatter setDateFormat:@"mm"];
        timeStr = [NSString stringWithFormat:@"%@%d:%@",STR_YESTERDAY,self.hour,[formatter stringFromDate:self]];
    }
    else
    {
        if ([self isThisYear]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
            [formatter setDateFormat:@"mm"];
            timeStr = [NSString stringWithFormat:@"%d月%d日%d:%@",self.month,self.day,self.hour,[formatter stringFromDate:self]];
        }else{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
            [formatter setDateFormat:@"mm"];
            timeStr = [NSString stringWithFormat:@"%d年%d月%d日%d:%@",self.year,self.month,self.day,self.hour,[formatter stringFromDate:self]];
        }
    }
    return timeStr;
}




/**
 @brief 获取预约面诊日历的星期字符串
 */
- (NSString *)stringForFaceDiagnosisCalendarWeekday
{
    NSString *weekStr = [NSString stringWithWeekday:self.weekday];
    if (self.day < 10) {
        return [NSString stringWithFormat:@"  %d  %@",self.day,weekStr];
    }else{
        return [NSString stringWithFormat:@"%d  %@",self.day,weekStr];
    }
    
}



- (NSString *)stringForList
{

    NSString *timeStr = @"";
    if ([self isThisYear]) {
        if ([self isToday])
        {
            timeStr = [NSString stringWithFormat:@"%02i:%@",self.hour,[self stringFromFormatterString:@"mm"]];
        }
        else if ([self isYesterday])
        {
            timeStr = STR_YESTERDAY;
        }
        else if ([self isThisWeek])
        {
            timeStr = [NSString stringWithWeekday:self.weekday];
        }
        else
        {
            timeStr = [self stringFromFormatterString:@"MM-dd"];
        }
    }else{
        timeStr = [self stringFromFormatterString:@"yyyy-MM-dd"];
    }
    
    return timeStr;
}

- (NSString *)stringForDetail
{
    NSString *timeStr = @"";
    if ([self isThisYear]) {
        if ([self isToday])
        {
            timeStr = [NSString stringWithFormat:@"%d:%@",self.hour,[self stringFromFormatterString:@"mm"]];
        }
        else if ([self isYesterday])
        {
            timeStr = STR_YESTERDAY;
        }
        else if ([self isThisWeek])
        {
            timeStr = [NSString stringWithWeekday:self.weekday];
        }
        else
        {
            timeStr = [self stringFromFormatterString:@"MM-dd"];
        }
    }else{
        timeStr = [self stringFromFormatterString:@"yyyy-MM-dd"];
    }
    
    return timeStr;
}

- (NSString *)stringForIMList
{
    NSString *timeStr = @"";
    if ([self isThisYear]) {
        if ([self isToday])
        {
            timeStr = [NSString stringWithFormat:@"%d:%@",self.hour,[self stringFromFormatterString:@"mm"]];
        }
        else if ([self isYesterday])
        {
            timeStr = [NSString stringWithFormat:@"%@ %d:%@",STR_YESTERDAY,self.hour,[self stringFromFormatterString:@"mm"]];
        }
        else if ([self isThisWeek])
        {
            timeStr = [NSString stringWithFormat:@"%@ %d:%@",[NSString stringWithWeekday:self.weekday],self.hour,[self stringFromFormatterString:@"mm"]];
        }
        else
        {
            timeStr = [NSString stringWithFormat:@"%@ %d:%@",[self stringFromFormatterString:@"MM-dd"],self.hour,[self stringFromFormatterString:@"mm"]];
        }
    }
    else
    {
        timeStr = [NSString stringWithFormat:@"%@ %d:%@",[self stringFromFormatterString:@"yyyy-MM-dd"],self.hour,[self stringFromFormatterString:@"mm"]];
    }
    
    return timeStr;
}

+ (id)dateWithServerTimeInterval:(NSString *)timeInterval
{
    return [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000];
}

- (NSDate *)getStartDateWithFormatterString:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
    [formatter setDateFormat:string];
    NSString *dateStr = [formatter stringFromDate:self];
    return [formatter dateFromString:dateStr];
}

- (NSDate *)currentDayStartDate
{
    return [self getStartDateWithFormatterString:@"yyyyMMdd"];
}

- (NSDate *)currentMonthStartDate
{
    return [self getStartDateWithFormatterString:@"yyyyMM"];
}

- (NSDate *)currentYearStartDate
{
    return [self getStartDateWithFormatterString:@"yyyy"];
}


/**
 * 新的时间格式调用
 */

+(NSDate*)dateWithString:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT_NEW];
    NSDate *date = [formatter dateFromString:string];
    return date;
}


/**
 * 老的时间格式调用   时间戳
 */

+(NSDate*)dateWithNSTimeIntervalString:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    
    NSTimeInterval timeStrInt = ([string doubleValue])/1000;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStrInt];
    
    return confromTimesp;
}





-(NSString *)timeStamp
{
    NSTimeInterval a = [self timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

- (BOOL)isLeapYear
{
    int year = self.year;
    if (year%4 == 0) {
        if (year%100 == 0) {
            int yearH = year/100;
            if (yearH%4 == 0) {
                return YES;
            }
        }else{
            return YES;
        }
    }
    return NO;
}

- (int)daysSinceDate:(NSDate *)start
{
    NSDate *endDate = [self dateAtStartOfDay];
    NSDate *startDate = [start dateAtStartOfDay];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
    return timeInterval/D_DAY;
}




/**
 * 面诊详情使用
 */


+(NSString *)stringForFaceDiagnoseCellWithIsHour:(NSString *)isHour dateStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithString:dateStr];
    
    NSString *timeStr = [date stringForFaceDiagnoseCellWithIsHour:isHour];
    
    return timeStr;
    
}


- (NSString *)stringForFaceDiagnoseCellWithIsHour:(NSString *)isHour
{
    NSString *timeStr = @"";
    
    if ([isHour isEqualToString:@"1"])
    {
        
        timeStr = [self stringFromFormatterString:@"yyyy-MM-dd HH:mm"];
        
        return timeStr;
        
        
        
        
        if ([self isToday])
        {
            timeStr = [NSString stringWithFormat:@"%02i:%02i",self.hour,self.minute];
        }
//        else if ([self isTomorrow])
//        {
//            
//            timeStr = [NSString stringWithFormat:@"%@ %02i:%02i",STR_TOMORROW,self.hour,self.minute];
//        }
        else if ([self isYesterday])
        {
            
            timeStr = [NSString stringWithFormat:@"%@ %02i:%02i",STR_YESTERDAY,self.hour,self.minute];
        }
        else if ([self isThisWeek])
        {
            timeStr = [NSString stringWithFormat:@"%@ %02i:%02i",[NSString stringWithWeekday:self.weekday],self.hour,self.minute];
        }
        else
        {
            
            if ([self isThisYear])
            {
                timeStr = [NSString stringWithFormat:@"%@ %02i:%@",[self stringFromFormatterString:@"MM-dd"],self.hour,[self stringFromFormatterString:@"mm"]];
                
                
//                timeStr = [NSString stringWithFormat:@"%02i-%02i %02i:%02i",self.month,self.day,self.hour,self.minute];
            }
            else
            {
                timeStr = [NSString stringWithFormat:@"%@ %02i:%@",[self stringFromFormatterString:@"yyyy-MM-dd"],self.hour,[self stringFromFormatterString:@"mm"]];
                
//                timeStr = [NSString stringWithFormat:@"%d-%d-%d %d:%02i",self.year,self.month,self.day,self.hour,self.minute];
            }
            
        }
    }
    else
    {
        
        timeStr = [NSString stringWithFormat:@"%@ %@",[self stringFromFormatterString:@"yyyy-MM-dd"],[NSDate isAM_PM_NIGHT:self.hour]];
        
        
        return timeStr;
        
        
        if ([self isToday])
        {
            timeStr = [NSString stringWithFormat:@"%@",[NSDate isAM_PM_NIGHT:self.hour ]];
        }
//        else if ([self isTomorrow])
//        {
//            
//            timeStr = [NSString stringWithFormat:@"%@ %@",STR_TOMORROW,[NSDate isAM_PM_NIGHT:self.hour]];
//        }
        else if ([self isYesterday])
        {
            
            timeStr = [NSString stringWithFormat:@"%@ %@",STR_YESTERDAY,[NSDate isAM_PM_NIGHT:self.hour]];
        }
        else if ([self isThisWeek])
        {
            timeStr = [NSString stringWithFormat:@"%@ %@",[NSString stringWithWeekday:self.weekday],[NSDate isAM_PM_NIGHT:self.hour]];
        }
        else
        {
            
            if ([self isThisYear])
            {
                 timeStr = [NSString stringWithFormat:@"%@ %@",[self stringFromFormatterString:@"MM-dd"],[NSDate isAM_PM_NIGHT:self.hour]];
                
//                timeStr = [NSString stringWithFormat:@"%d月%d日 %@",self.month,self.day,[NSDate isAM_PM_NIGHT:self.hour]];
            }
            else
            {
                timeStr = [NSString stringWithFormat:@"%@ %@",[self stringFromFormatterString:@"yyyy-MM-dd"],[NSDate isAM_PM_NIGHT:self.hour]];
                
//                timeStr = [NSString stringWithFormat:@"%d年%d月%d日 %@",self.year,self.month,self.day,[NSDate isAM_PM_NIGHT:self.hour]];
            }
            
        }
    }

    return timeStr;
    
}


+(NSString *)isAM_PM_NIGHT:(NSInteger)hour
{
    if (hour<12)
    {
        return STR_MORNING;
    }
    else if (hour < 17)
    {
        return STR_AFTERNOON;
    }
    else
    {
        return STR_THENIGHT;
    }
    
}


-(NSString *)getCurrentTimeStrWithDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSString *time = [formatter stringFromDate:self];
    
    return time;
}


/**
 * 除IM外的其他地方时间格式 20150508164723000 -> 12：12 昨天 星期三 2012-12-12
 */

+(NSString *)timeStrForListWithDateStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithString:dateStr];
    
    NSString *timeStr = [date stringForList];
    
    return timeStr;
    
}


/**
 * 详情界面时间格式 20150508164723000 -> 12：12 昨天 12：12 星期三 12：12 2012-12-12 12：12
 */

+(NSString *)timeStrForIMChatDetailWithDateStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithString:dateStr];
    
    NSString *timeStr = [date stringForIMList];
    
    return timeStr;
}


/**
 *  老的时间格式  列表时间格式 时间戳 -> 12：12 昨天 星期三 2012-12-12
 */

+(NSString *)timeStrForListWithNSTimeIntervalStringStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithNSTimeIntervalString:dateStr];
    
    NSString *timeStr = [date stringForList];
    
    return timeStr;
    
}

/**
 *  老的时间格式  详情时间格式 时间戳 -> 12：12 昨天 12：12 星期三 12：12 2012-12-12 12：12
 */

+(NSString *)timeStrForDetailWithNSTimeIntervalStringStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithNSTimeIntervalString:dateStr];
    
    NSString *timeStr = [date stringForIMList];
    
    return timeStr;
    
}

/**
 *  文章详情格式  详情时间格式 2012-12-12
 */

+(NSString *)timeStrForArticleDetailWithDateStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithString:dateStr];
    
    NSString *timeStr = [date stringFromFormatterString:@"yyyy-MM-dd"];
    
    return timeStr;
    
}

/**
 * 时间戳 时间展示 2015-01-01
 */
+(NSString *)timeStrForyyyyMMddWithNSTimeIntervalStringStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithNSTimeIntervalString:dateStr];
    
    NSString *timeStr = [date stringFromFormatterString:@"yyyy-MM-dd"];
    
    return timeStr;
    
    
}



/**
 * 文章评论列表 时间展示 2015-01-01 18：30
 */
+(NSString *)timeStrForArticleCommentWithNSTimeIntervalStringStr:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithNSTimeIntervalString:dateStr];
    
    NSString *timeStr = [date stringFromFormatterString:@"yyyy-MM-dd HH:mm"];
    
    return timeStr;
    
    
}


@end
