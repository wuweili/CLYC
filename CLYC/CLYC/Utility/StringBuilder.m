
#import "StringBuilder.h"


@implementation StringBuilder
//clear space in parseString
+ (NSString *) clearSpace:(NSString *)parseString
{
//	NSString*text = nil ; 
//	NSString *clearSpace = [parseString stringByReplacingOccurrencesOfString:
//							[ NSString stringWithFormat:@" ", text] withString:@""];
//	return clearSpace;
    return nil;
}

+ (NSString *) clearEnter:(NSString *)parseString
{
//	NSString*text = nil ; 
//	NSString *clearSpace1 = [parseString stringByReplacingOccurrencesOfString:
//                             [ NSString stringWithFormat:@"\r", text] withString:@""];
//	NSString *clearSpace2 = [clearSpace1 stringByReplacingOccurrencesOfString:
//							 [ NSString stringWithFormat:@"\n", text] withString:@""];
//    
//	return clearSpace2;
    return nil;
}

//add enter at the end of parseString
+ (NSString *) addEnter:(NSString *)parseString;
{
	NSString *addEnter =  [parseString stringByAppendingString:@"\r\n"];
	return addEnter;	
}

//splict string to word by space
+ (NSMutableArray *)buildStringBySplitSpace:(NSString *)inputString
{
	int count_index = 0;
	int beginWordindex = -1;
	int endWordindex = -1;
	NSMutableArray *splictWords = [NSMutableArray array];
	NSString *splictString;
	while(count_index< [inputString length])
	{
		if([inputString characterAtIndex:count_index]  == 32)
		{
			count_index ++;				
		}
		else
		{
			if (beginWordindex == -1)
			{
				beginWordindex = count_index;
				if([inputString characterAtIndex:count_index + 1]  == 32 && [inputString characterAtIndex:count_index + 2]  == 32 && [inputString characterAtIndex:count_index + 3]  == 32)
				{
					endWordindex = count_index;
					splictString = [inputString substringWithRange:NSMakeRange(beginWordindex, endWordindex - beginWordindex + 1)];
					[splictWords addObject:splictString];
					beginWordindex = -1;					
				}
				count_index ++;
			}
			else
			{
				if (count_index + 1 == [inputString length])
				{
					count_index ++;
				}
				else
				{
					if([inputString characterAtIndex:count_index + 1]  == 32 && [inputString characterAtIndex:count_index + 2]  == 32 && [inputString characterAtIndex:count_index + 3]  == 32)
					{
						endWordindex = count_index;
						splictString = [inputString substringWithRange:NSMakeRange(beginWordindex, endWordindex - beginWordindex + 1)];
						[splictWords addObject:splictString];
						beginWordindex = -1;
					}
					count_index ++;
				}
			}
		}
	}
	return splictWords;
}

//replace string
+ (NSString *) buildStringByReplace:(NSString *)originalString To:(NSString *)replaceString  FromString:(NSString *) fromString;
{
	NSString*text = nil ; 
	NSString *result = [fromString stringByReplacingOccurrencesOfString:
						[ NSString stringWithFormat:originalString, text]
															 withString:replaceString];
	return result;
}

+ (NSMutableArray *)buildStringIntoGroupByWord:(NSString *) inputWord Index:(int) index From:(NSArray *)inputArray
{
	NSMutableArray * result = [[NSMutableArray alloc] init]; 
	for(int i = 0; i<[inputArray count]; i++)
	{
		if ([[inputArray objectAtIndex:i] characterAtIndex:index] == [inputWord characterAtIndex:0])
		{
			[result addObject:[inputArray objectAtIndex:i]];
		}
	}
	return result;
}

+ (NSString *) buildStringByStartIndex:(int)startindex EndIndex:(int)endindex FromString:(NSString *)string
{
	NSString *resultString;
	if (startindex != -1 && endindex != -1)
	{
		resultString = [string substringWithRange:NSMakeRange(startindex,endindex - startindex+1)];
	}
	else if(startindex != -1 && endindex == -1)
	{
		resultString = [string substringFromIndex:startindex];
	}
	else if(startindex == -1 && endindex != -1)
	{
		resultString = [string substringToIndex:endindex];
	}
	else
	{
		resultString = @"";
	}
	return resultString; 
}

@end
