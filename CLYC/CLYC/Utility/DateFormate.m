
#import "DateFormate.h"
#import "HXStrings.h"
#import "HXOther.h"


static NSString* MONTHs[] = {
@" NA",
@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun",
@"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"
};

static NSString *MONTHFULLSPELL[] = {@"January", @"February", @"March", @"April", @"May", @"June",@"July", @"August", @"September", @"October", @"November", @"December"};

@implementation DateFormate

+ (BOOL)IsAM : (NSInteger)hour
{
	return hour >= 0 && hour < 12;
}

+ (int)GetHH12 : (NSUInteger)hour {
	if (hour > 12) {
		return hour - 12;
	} else {
		return hour;
	}
}

#pragma mark -
#pragma mark Get NSString form NSDate

+ (NSString*)GetString_ddMMMyyyy : (NSDate*)date //Month is short by English word ; dd-mmm-yyyy
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:
			@"%02i-%@-%04i",
			dateComp.day,
			MONTHs[dateComp.month],//MONTHFULLSPELL[dateComp.month],
			dateComp.year];
}

+ (NSString*)GetString_ddMMyyyy: (NSDate*)date // dd.mm.yyyy
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:
			@"%02i.%02i.%04i",
			dateComp.day,
			dateComp.month,
			dateComp.year];
}

+ (NSString*)GetString_hhmmAMPM : (NSDate*)date  // hh:mm am/pm
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:
			@"%i:%02i %@",
			[DateFormate GetHH12 : dateComp.hour],
			dateComp.minute,
			([DateFormate IsAM:dateComp.hour] ? @"AM" : @"PM")];;
}





+ (NSString*)GetString : (NSDate*)date //dd-mmm-yyyy hh:mm am/pm
{
	return [NSString stringWithFormat:
			@"%@ %@",
			[DateFormate GetString_ddMMMyyyy:date],
			[DateFormate GetString_hhmmAMPM:date]];
}

+ (NSString*)GetString_yyyymmddhhmm: (NSDate*)date //yyyy-mm-dd hh:mm
{
    NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:
			@"%04i-%02i-%02i %02i:%02i",
			dateComp.year,
			dateComp.month,//MONTHFULLSPELL[dateComp.month],
			dateComp.day,
            dateComp.hour,
            dateComp.minute
    ];
}


//add by wuweili
+ (NSString*)GetString_AMPMhhmm : (NSDate*)date  // 上午/下午 hh:mm
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:
			@"%@ %i:%02i",
            ([DateFormate IsAM:dateComp.hour] ? @"上午" : @"下午"),
			[DateFormate GetHH12 : dateComp.hour],
			dateComp.minute];
			
}


+ (NSString*)GetString_yyyymmdd: (NSDate*)date //yyyy-mm-dd
{
    NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:
			@"%04i-%02i-%02i",
			dateComp.year,
			dateComp.month,//MONTHFULLSPELL[dateComp.month],
			dateComp.day
            ];
}

+ (NSString*)GetString_yyyymmddAMPMhhmm : (NSDate*)date //dd-mmm-yyyy 上午、下午 hh:mm
{
	return [NSString stringWithFormat:
			@"%@ %@",
			[DateFormate GetString_yyyymmdd:date],
			[DateFormate GetString_AMPMhhmm:date]];
}

#pragma mark -
#pragma mark Get NSDate form NSString

+ (NSDate *) NSStringDateToNSDate:(NSString *)string //yyyy-MM-dd HH:mm:ss With TimeZone
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
    [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    
    NSTimeInterval timeStrInt = ([string doubleValue])/1000;
    
 
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStrInt];
	return date;
}

+(NSDate *)ChangeStrToDate:(NSString *)timeStr //
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *timeStr2 = [DateFormate ChangeTimeFormat2:timeStr];
	NSDate *timeStrDate = [formatter dateFromString:timeStr2];
	return timeStrDate;
}

+(NSString *)ChangeStrToDateMDHS:(NSString *)timeStr //change 2014-01-13 23:59 to 01-13 23:59
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSDate *timeStrDate = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"MM-dd HH:mm"];
	return [formatter stringFromDate:timeStrDate];
}

+(NSString *)ChangeStrToDateMDHSS:(NSString *)timeStr //change 2014-01-16 16:56:50 to 01-16 16:56
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *timeStrDate = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"MM-dd HH:mm"];
	return [formatter stringFromDate:timeStrDate];
}

+ (NSDate *)GetDateByString:(NSString *)timeStr //june 09,2009 to date
{
	NSString *month = [[timeStr componentsSeparatedByString:@" "] objectAtIndex:0];
	NSString *temp = [[timeStr componentsSeparatedByString:@" "] objectAtIndex:1];
	NSString *day =  [[temp componentsSeparatedByString:@","] objectAtIndex:0];
	NSString *year = [[temp componentsSeparatedByString:@","] objectAtIndex:1];
	//@"yyyy-MM-dd"
	NSString *monthNum;
	for(int i=0; i<12; i++)
	{
		NSString *monthInArray = MONTHFULLSPELL[i];
		if([monthInArray isEqual:month])
		{
			if(i+1<10)
				monthNum = [NSString stringWithFormat:@"0%d",i+1]; 
			else {
				monthNum = [NSString stringWithFormat:@"%d",i+1];
			}
			
		}
	}
	NSDateFormatter *inputFormate = [[NSDateFormatter alloc] init];
	[inputFormate setDateFormat:@"yyyy-MM-dd"];
	NSString *dateStr =  [NSString stringWithFormat:@"%@-%@-%@",year,monthNum,day];
	return [inputFormate dateFromString:dateStr];
}


#pragma mark -
#pragma mark Change NSString formate To another NSString formate

+ (NSString *) ChangeTimeFormat:(NSString *)timeStr //2009-05-15 03:08:10.0 To 15.05.09
{
	NSMutableString *str = [[NSMutableString alloc] init];
	[str appendString:[StringBuilder buildStringByStartIndex:8 EndIndex:9 FromString:timeStr]];
	[str appendString:@"."];
	[str appendString:[StringBuilder buildStringByStartIndex:5 EndIndex:6 FromString:timeStr]];
	[str appendString:@"."];
	[str appendString:[StringBuilder buildStringByStartIndex:2 EndIndex:3 FromString:timeStr]];
	return str;
}

+ (NSString *) ChangeTimeFormatWithMonth:(NSString *)timeStr //2009-05-15 03:08:10.0 To Mail 15,2009, 03:08:10.0
{
	NSMutableString *str = [[NSMutableString alloc] init];
	
	NSString *month = [StringBuilder buildStringByStartIndex:5 EndIndex:6 FromString:timeStr];
	NSString *EnMonth;
	EnMonth = MONTHFULLSPELL[[month intValue]-1];
	[str appendString:EnMonth];
	[str appendString:@" "];
	[str appendString:[StringBuilder buildStringByStartIndex:8 EndIndex:9 FromString:timeStr]];
	[str appendString:@","];
	[str appendString:[StringBuilder buildStringByStartIndex:0 EndIndex:3 FromString:timeStr]];
	return str;
}

+ (NSString *) ChangeTimeFormat2:(NSString *)timeStr //08.07.2009 07:25 To 2009-05-15 03:08:10.0
{
	NSMutableString *str = [[NSMutableString alloc] init];
	[str appendString:[StringBuilder buildStringByStartIndex:6 EndIndex:9 FromString:timeStr]];
	[str appendString:@"-"];
	[str appendString:[StringBuilder buildStringByStartIndex:3 EndIndex:4 FromString:timeStr]];
	[str appendString:@"-"];
	[str appendString:[StringBuilder buildStringByStartIndex:0 EndIndex:1 FromString:timeStr]];
	[str appendString:@" "];
	[str appendString:[StringBuilder buildStringByStartIndex:11 EndIndex:15 FromString:timeStr]];
	[str appendString:@":00"];
	return str;
}

+ (NSString *) ChangeTimeFormat3:(NSString *)timeStr //08.07.2009 07:25 To today 07:25 PM/AM
{
	NSMutableString *str = [[NSMutableString alloc] init];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *timeStr2 = [DateFormate ChangeTimeFormat2:timeStr];
	NSDate *timeStrDate = [formatter dateFromString:timeStr2];
	
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *pmORam = [formatter stringFromDate:timeStrDate];
	
	NSString *currentDate = [DateFormate GetCurrentTime:@"dd.MM.yyyy"];
	NSString *dateStr = [StringBuilder buildStringByStartIndex:0 EndIndex:9 FromString:timeStr];	
	[str appendString:[dateStr isEqual:currentDate]?@"heute":dateStr];
	[str appendString:@" "];
	[str appendString:pmORam];
	
	return str;
}

#pragma mark -
#pragma mark Date Time

+ (NSString *)GetCurrentTime:(NSString *)timeFormat  //Get current time formate string by formate
{
	NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:timeFormat];
	NSString *time = [formatter stringFromDate:now];

	return time;
}

+ (NSString *) BuildStringTimeByZone:(NSString *)string TimeZone:(NSTimeZone *)zone
{
	NSInteger second = [zone secondsFromGMT];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
	[formatter setTimeZone:zone];
	NSDate *date = [formatter dateFromString:string];
	NSDate *resultDate = [date dateByAddingTimeInterval:second];
	NSString *resultString = [resultDate description];
	resultString = [StringBuilder buildStringByStartIndex:-1 EndIndex:18 FromString:resultString];
	return resultString;
}

+(int)GetDay:(NSDate *)date
{
	
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [dateComp day];
	
    //	NSString *d = [[[date description] componentsSeparatedByString:@" "] objectAtIndex:0];
    //	return [[[d componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
}

+(int)GetMonth:(NSDate *)date
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [dateComp month];
	
    //	NSString *d = [[[date description] componentsSeparatedByString:@" "] objectAtIndex:0];
    //	return [[[d componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
}

+(int)GetYear:(NSDate *)date
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [dateComp year];
	
    //	NSString *d = [[[date description] componentsSeparatedByString:@" "] objectAtIndex:0];
    //	return [[[d componentsSeparatedByString:@"-"] objectAtIndex:0] intValue];
}

+(int)GetHour:(NSDate *)date
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [dateComp hour];
	
    //	NSString *d = [[[date description] componentsSeparatedByString:@" "] objectAtIndex:1];
    //	return [[[d componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
}
+(int)GetMinute:(NSDate *)date
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [dateComp minute];
	
    //	NSString *d = [[[date description] componentsSeparatedByString:@" "] objectAtIndex:1];
    //	return [[[d componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
}
+(int)GetSecond:(NSDate *)date
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [dateComp second];
	
    //	NSString *d = [[[date description] componentsSeparatedByString:@" "] objectAtIndex:1];
    //	return [[[d componentsSeparatedByString:@":"] objectAtIndex:2] intValue];
}

+(NSString *)GetHourAndMinute:(NSDate *)date
{
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:@"%d:%d",[dateComp hour],[dateComp minute]];
	
    //	NSString *timeStr = [[dateStr componentsSeparatedByString:@" "] objectAtIndex:1];
    //	return  [StringBuilder buildStringByStartIndex:0 EndIndex:4 FromString:timeStr];
}

+(NSString *)GetWeedDay:(NSDate *)date //Mondy , July 13
{
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"EEEE','MMMM dd"];
	
	return [outputFormatter stringFromDate:[NSDate date]];
}

+(NSString *)GetHourAndMinuteFromatter:(NSDate *)date
{
    NSCalendar* calender = [NSCalendar currentCalendar];
	NSDateComponents* dateComp = [calender components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	return [NSString stringWithFormat:@"%d:%02d",[dateComp hour],[dateComp minute]];
}

#pragma mark - TimeString -

+(NSString *)GetLastMsgTimeString:(NSString *)timeString
{
    NSDate *date = [DateFormate NSStringDateToENDate:timeString];
    NSString *result = [DateFormate NSStringDateToString:date];
    return result;
}

+ (NSDate *) NSStringDateToENDate:(NSString *)string //yyyy-MM-dd HH:mm:ss With TimeZone
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
    
	[formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
	NSDate *date = [formatter dateFromString:string];
    NSTimeInterval since = [date timeIntervalSince1970];
    since = since + 1;
    date = [NSDate dateWithTimeIntervalSince1970:since];
	return date;
}

+ (NSString *) NSStringDateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//  [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	NSString *time = [formatter stringFromDate:date];

	return time;
}

+(NSString *)timeConvertWithTimeStr:(NSString *)timeStr  //时间戳--->> 2014-05-26
{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    
    NSTimeInterval timeStrInt = ([timeStr doubleValue])/1000;

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStrInt];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
}


+(NSString *)timeConvertToyyyyMMddHHmmWithTimeStr:(NSString *)timeStr //时间戳--->> 2014-05-26 11:25:36
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSTimeInterval timeStrInt = ([timeStr doubleValue])/1000;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStrInt];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}





+(NSString *)GetString_YYYMMDD:(NSString *)dateStr   //1970-01-12  --->> 1970年1月1日
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *resultString = [formatter stringFromDate:date];
    return resultString;
}



+(NSString *)GetString_YYYMM:(NSString *)dateStr   //1970-01-12  --->> 1970年1月
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"yyyy年MM月"];
    NSString *resultString = [formatter stringFromDate:date];
    return resultString;
}


//add by wuweili
+(NSString *)get_yyyyddmmAMPMhhmm:(NSString *)datastr   //158945665236--->1970-01-02 上午 11：30
{
    NSDate *timeStrDate = [self NSStringDateToNSDate:datastr];
    
    NSString *timeStr = [self GetString_yyyymmddAMPMhhmm:timeStrDate];

    return timeStr;
  
}

+(NSDate*)getNSDateFromTimeStr:(NSString *)timeStr  //2014-05-06
{
    if ([NSString isBlankString:timeStr])
    {
        return [NSDate date];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:timeStr];
    return date;
}

+(NSString *)getTimeIntervalFromTimeStr:(NSString *)timeStr  //时间转化为时间戳
{

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:timeStr];
    
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];
    
    return timeSp;
}

/**
 * 计算从今天到未来摸个时间的间隔天数
 */

+(NSInteger)getResidualDaysWithEndTimeStr:(NSString *)endTimeStr systemNowTimeStr:(NSString *)systemNowTimeStr
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];

    NSDate *fromDate;
    NSDate *toDate;
    
    
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:[formatter dateFromString:systemNowTimeStr]];
    
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:[formatter dateFromString:endTimeStr]];

    NSDateComponents *dayComponents = [gregorian components:NSDayCalendarUnit fromDate:fromDate toDate:toDate options:0];
    
    NSInteger days = dayComponents.day;
    
    return days;
   
}



+(NSString *)getCurrentTimeWithNoDian:(NSDate*)date
{
    //    20150504173001000
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT]; //yyyy-MM-dd HH:mm:ss
    NSString *time = [formatter stringFromDate:date];
    
    time = [time stringByReplacingOccurrencesOfString:@"-" withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@" " withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    time = [NSString stringWithFormat:@"%@000",time];
    
    return time;
}

@end
