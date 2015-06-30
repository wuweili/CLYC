

#import <Foundation/Foundation.h>
#import <Foundation/NSString.h>


@interface StringBuilder : NSObject {

}

+ (NSString *) clearEnter:(NSString *)parseString; //清除字符串里的回车换行
+ (NSString *) clearSpace:(NSString *)parseString;
+ (NSString *) addEnter:(NSString *)parseString;
+ (NSMutableArray *) buildStringBySplitSpace:(NSString *)inputString;
+ (NSString *) buildStringByReplace:(NSString *)originalString To:(NSString *)replaceString  FromString:(NSString *) fromString;
+ (NSMutableArray *)buildStringIntoGroupByWord:(NSString *) inputWord Index:(int) index From:(NSArray *)inputArray;
+ (NSString *) buildStringByStartIndex:(int)startindex EndIndex:(int)endindex FromString:(NSString *)string;


@end
