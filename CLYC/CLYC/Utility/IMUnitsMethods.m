//
//  IMUnitsMethods.m
//  IOS-IM
//
//  Created by ZhangGang on 13-9-10.
//  Copyright (c) 2013年 weihua. All rights reserved.
//

#import "IMUnitsMethods.h"
#import "HXStrings.h"
#import "DateFormate.h"
#import "HXOther.h"

#import "HXUserModel.h"
#import "UITextField+HXExtentRange.h"

#import <CommonCrypto/CommonDigest.h>

@implementation IMUnitsMethods

+(void)drawTheLeftBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title
{

    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 41/2)];
    //modify by xishuaishuai
    backBtn.backgroundColor = [UIColor clearColor];
   
    [backBtn.titleLabel setFont:HEL_BOLD_16];
    //end by xishuaishuai
//    NSString *titleStr = [NSString stringWithFormat:@"  %@",title];
//    
//    [backBtn setTitle:titleStr forState:UIControlStateNormal];
//    
//    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    if ([title isEqualToString:STR_BACK])
    {
        [backBtn setImage:HX_BACK_GREEN_IMAG forState:UIControlStateNormal];

        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }else
    {
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    [backBtn setImage:FirstPageLeftMenu_bg forState:UIControlStateNormal];


    [backBtn addTarget:control action:funName forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    control.navigationItem.leftBarButtonItem = backBtnItem;
    
    [[self class]setViewControllerProperty:control];
}

//draw left button with title
+(void)drawTheLeftBarBtn:(UIViewController *)control btnTitle:(NSString*)title
{
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]init];
    backBtn.title = title;
    control.navigationItem.backBarButtonItem = backBtn;
}

+(void)drawTheRightBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title bgImage:(UIImage*)image
{
    if (title == nil || [title length] == 0) {
        [[self class]drawTheRightBarBtnImage:control function:funName bgImage:image withFrame:CGRectMake(0, 0, 22, 21)];
        return;
    }

    
    UIButton * rightItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 32)];//CGRectMake(0, 0, 46, 32)
    [rightItemBtn addTarget:control action:funName forControlEvents:UIControlEventTouchUpInside];
    //modify by xishuaishuai
   // [rightItemBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [rightItemBtn.titleLabel setFont:HEL_BOLD_16];
    //end by xishuaishuai
    rightItemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightItemBtn setTitle:title forState:UIControlStateNormal];
    [rightItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightItemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightItemBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    UIBarButtonItem * rightEditBtn = [[UIBarButtonItem alloc] initWithCustomView:rightItemBtn];
    rightEditBtn.style = UIBarButtonItemStyleBordered;
    control.navigationItem.rightBarButtonItem = rightEditBtn;
    //add by xishuaishuai 设置ios 7下面视图的属性 如果有问题 请移除此属性 用其他方法优化
    [[self class]setViewControllerProperty:control];
    
}

+(void)drawTheRightBarBtnImage:(UIViewController *)control function:(SEL )funName bgImage:(UIImage*)image withFrame:(CGRect)frame
{
    UIButton * rightItemBtn = [[UIButton alloc] initWithFrame:frame];//CGRectMake(0, 0, 46, 32)
    [rightItemBtn addTarget:control action:funName forControlEvents:UIControlEventTouchUpInside];
    //modify by xishuaishuai
    [rightItemBtn setBackgroundImage:image forState:UIControlStateNormal];
    //end by xishuaishuai
    rightItemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem * rightEditBtn = [[UIBarButtonItem alloc] initWithCustomView:rightItemBtn];
    rightEditBtn.style = UIBarButtonItemStyleBordered;
    control.navigationItem.rightBarButtonItem = rightEditBtn;
}

+(void)drawTheLeftBarBtnWithNoTitle:(UIViewController *)control function:(SEL )funName
{
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 50/2)];
    backBtn.backgroundColor = [UIColor clearColor];
    
    [backBtn.titleLabel setFont:HEL_BOLD_16];
    
    
    [backBtn setImage:Left_bar_nav_image forState:UIControlStateNormal];
    
    [backBtn addTarget:control action:funName forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    control.navigationItem.leftBarButtonItem = backBtnItem;
    
    [[self class]setViewControllerProperty:control];
}

#pragma mark -
#pragma mark  获取当前用户文件目录（如没有则创建）
+ (NSString *)userFilePath
{  //初始化documents目录
    NSString *documentPath = PATH_OF_DOCUMENT;
    //设置用户保存的文件夹
    NSString *userPath = [documentPath stringByAppendingPathComponent:USER_ID];
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL userPathExists = [fileManager fileExistsAtPath:userPath];
    if (!userPathExists)
    {
        [fileManager createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return userPath;
}

#pragma mark  获取当前document文件目录
+ (NSString *)userDocumentPath
{  //初始化documents目录
    NSString *documentPath = PATH_OF_DOCUMENT;
    //设置用户保存的文件夹
    
    
    return documentPath;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark  日期二次处理相关
/////////////////////////////////////////////////////////////////////////////////////////////////////
//信息主界面的时间显示格式
+ (NSString *)convertDateToMsgShow:(NSString *)dateStr WithDetail:(BOOL)flag
{
    static NSString * oldDateFmt = kDEFAULT_DATE_TIME_FORMAT;
    static NSString * outDateFmt = @"yyyyMMdd";
    static NSString * timeDateFmt = @"HH:mm";
    
    NSString * resultString = nil;
    NSString * dateOrigin = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:oldDateFmt];
    NSDate * date = [dateFormatter dateFromString:dateStr];
    if (date)
    {
        [dateFormatter setDateFormat:outDateFmt];
        dateOrigin = [dateFormatter stringFromDate:date];
        
        NSString *dateNowString =  [DateFormate GetCurrentTime:outDateFmt];
        int gapDay = [dateNowString intValue] - [dateOrigin intValue];
        
        [dateFormatter setDateFormat:timeDateFmt];
        NSString *detailString =  [dateFormatter stringFromDate:date];
        
        //今天
        if (0 == gapDay)
        {
            resultString = detailString;
        }
        else if(gapDay == 1)//昨天
        {
            if(flag)
            {
                resultString = [NSString stringWithFormat:@"%@ %@",STR_YESTERDAY,detailString];
            }
            else
            {
                resultString = STR_YESTERDAY;
            }
        }
        else if(gapDay >1 && gapDay <7)//星期几(昨天之前的时间,但在一周内)
        {
            /*由于必须要一直显示中文，所以必须先取出星期几，然后转换成中文*/
            static NSString * weekPosFmt   = @"c";//@"e"和@"c"是相同的，星期天都是一周的开始，返回1；
            
            NSArray *weekDayArray = @[STR_SUNDAY,STR_MONDAY,STR_TUESDAY,STR_WEDNESDAY,STR_THURSDAY,STR_FRIDAY,STR_SATURDAY];
            
            [dateFormatter setDateFormat:weekPosFmt];
            NSString * temp = [dateFormatter stringFromDate:date];
            int     tempPos = [temp intValue] - 1;
            if (tempPos > 0 && tempPos < [weekDayArray count])
            {
                if(flag)
                {
                    resultString = [NSString stringWithFormat:@"%@ %@",weekDayArray[tempPos],detailString];
                }
                else
                {
                    resultString = weekDayArray[tempPos];
                }
            }
        }
        else//2013-10-25
        {
            if([dateStr length]>10)
            {
                if(flag)
                {
                    resultString = [NSString stringWithFormat:@"%@ %@",[dateStr substringToIndex:10],detailString];
                }
                else
                {
                    resultString = [dateStr substringToIndex:10];
                }
            }
        }
    }
    
    return resultString;
}




+ (void)setViewControllerProperty:(UIViewController *)controller
{
    //add by xishuaishuai
    if (CurrentSystemVersion >= 7.0) {
        controller.edgesForExtendedLayout = UIRectEdgeNone;
       
    }
    //end by xishuaishuai
}


#pragma mark - 屏蔽emoji表情输入
//屏蔽emoji表情输入 不适应九宫格输入法
+(BOOL)stringContainsEmoji:(NSString *)string
{
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
    
}



//判断输入长度  屏蔽系统表情及防止手写时崩溃  UITextView
+(void)limitInputTextWithTextView:(UITextView *)textView limit:(NSInteger)limit
{
    if (CurrentSystemVersion >= 7.0)
    {
        NSRange textRange = [textView selectedRange];
        
        NSString *toBeString = textView.text;
        
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        
        if ([lang isEqualToString:@"zh-Hans"])
        {
            UITextRange *selectedRange = [textView markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                toBeString = [IMUnitsMethods disable_emoji:textView.text];
                
                if ([IMUnitsMethods unicodeLengthOfString:toBeString] > limit)
                {
                    for (int i = 0; i< toBeString.length; i++)
                    {
                        if ([IMUnitsMethods unicodeLengthOfString:[toBeString substringToIndex:i]] == limit)
                        {
                            textView.text = [toBeString substringToIndex:i];
                        }
                    }
                }
                else
                {
                    textView.text = toBeString;
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else
            {
                
            }
        }
        else if ([lang isEqualToString:@"dictation"])
        {
            //语音输入
        }
        else
        {
            toBeString = [IMUnitsMethods disable_emoji:textView.text];
            
            if ([IMUnitsMethods unicodeLengthOfString:toBeString] > limit)
            {
                for (int i = 0; i< toBeString.length; i++)
                {
                    if ([IMUnitsMethods unicodeLengthOfString:[toBeString substringToIndex:i]] == limit)
                    {
                        textView.text = [toBeString substringToIndex:i];
                    }
                }
            }
            else
            {
                textView.text = toBeString;
            }

        }
        
        [textView setSelectedRange:textRange];
   
    }
}


//判断输入长度  屏蔽系统表情及防止手写时崩溃  UITextField
+(void)limitInputTextWithUITextField:(UITextField *)textField limit:(NSInteger)limit
{
    if (CurrentSystemVersion >= 7.0)
    {
        NSRange textRange = [textField selectedRange];
        
        NSString *toBeString = textField.text;
        
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        
        if ([lang isEqualToString:@"zh-Hans"])
        {
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position)
            {
                toBeString = [IMUnitsMethods disable_emoji:textField.text];
                
                if ([IMUnitsMethods unicodeLengthOfString:toBeString] > limit)
                {
                    for (int i = 0; i< toBeString.length; i++)
                    {
                        if ([IMUnitsMethods unicodeLengthOfString:[toBeString substringToIndex:i]] == limit)
                        {
                            textField.text = [toBeString substringToIndex:i];
                        }
                    }
                }
                else
                {
                    textField.text = toBeString;
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else
            {
                
            }
        }
        else
        {
            toBeString = [IMUnitsMethods disable_emoji:textField.text];
            
            if ([IMUnitsMethods unicodeLengthOfString:toBeString] > limit)
            {
                for (int i = 0; i< toBeString.length; i++)
                {
                    if ([IMUnitsMethods unicodeLengthOfString:[toBeString substringToIndex:i]] == limit)
                    {
                        textField.text = [toBeString substringToIndex:i];
                    }
                }
            }
            else
            {
                textField.text = toBeString;
            }
            
        }
        
        [textField setSelectedRange:textRange];
        
    }
}



//屏蔽emoji表情输入
+(NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    
    return modifiedString;
}


#pragma mark - 统计ASCII和Unicode混合文本长度的，看下来和新浪微博的统计结果是一致的
+(NSUInteger)unicodeLengthOfString:(NSString *)text
{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        
//        asciiLength += isascii(uc) ? 1 : 2;
        asciiLength += isascii(uc) ? 1 : 1;
    }
    
//    NSUInteger unicodeLength = asciiLength / 2;
    
    NSUInteger unicodeLength = asciiLength / 1;
    
    if(asciiLength % 1) //asciiLength % 2
    {
        unicodeLength++;
    }
    return unicodeLength;
}

#pragma mark -判断输入的邮箱格式是否正确
+(BOOL)checkInputEmail:(NSString*)text
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_EMAIL];
    return [emailTest evaluateWithObject:text];
}

#pragma mark -判断输入的身高格式是否正确
+(BOOL)checkInputHeight:(NSString*)text
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_Height];
    return [emailTest evaluateWithObject:text];
}

#pragma mark -判断输入的体重格式是否正确
+(BOOL)checkInputWeigth:(NSString*)text
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_Weigth];
    return [emailTest evaluateWithObject:text];
}


#pragma mark - 判断输入的军官证格式是否正确

+(BOOL)checkInputOfficeCertificate:(NSString*)text
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_OfficeCertificate];
    return [emailTest evaluateWithObject:text];
}

#pragma mark 手机号码判断方法
+(BOOL)regexPhoneNumber:(NSString*)phoneNumber
{
    NSString* regex = @"^((13[0-9])|(147)|(177)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    if(phoneNumber.length == 11)
    {
        if([phoneNumber isMatchedByRegex:regex])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

#pragma mark 身份证判断方法
+(BOOL)regexIdCardToEighteenNumber:(NSString*)idCard
{
    NSArray* expArray = [[NSArray alloc]initWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    
    NSArray* validArray = [[NSArray alloc]initWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    
    if(idCard.length == 18)
    {
        NSString *regex = @"(\\d{17})[\\d|X]{1}";
        if ([idCard isMatchedByRegex:regex])
        {
            int sum = 0, idx;
            for(int i = 0; i < idCard.length - 1; i++){
                // 对前17位数字与权值乘积求和
                NSRange range = NSMakeRange (i, 1);
                sum += [[idCard substringWithRange:range] intValue]*[expArray[i] intValue];
            }
            // 计算模（固定算法）
            idx = sum % 11;
            // 检验第18为是否与校验码相等
            NSRange range = NSMakeRange (17, 1);
            if([[idCard substringWithRange:range] isEqual:validArray[idx]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if (idCard.length == 15)
    {
        NSString *regex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
        
        if([idCard isMatchedByRegex:regex])
        {
            return YES;
        }
        else
        {
            return NO;
        }
        
        
        
    }
    return NO;
}

//身份证判断方法
+(BOOL)regexPersonalIdentifierNum:(NSString *)value
{
    value = [value stringByReplacingOccurrencesOfString:@"X" withString:@"x"];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"                   options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"           options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
                
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
    }
    return NO;
}

+ (NSString *)generateUUID
{
	NSString *result = nil;
	
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	if (uuid)
	{
		result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
		CFRelease(uuid);
	}
	
	return result;
}

+ (NSString *)createRecordPictureName
{
    
    NSString *prefix = [DateFormate GetCurrentTime:@"yyyyMMddHHmmss"];
    
    return [NSString stringWithFormat:@"%@%@",prefix,[IMUnitsMethods generateUUID]];
}


//清空session
+(void)clearSession
{
    
    
    NSHTTPCookieStorage *cookiesStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookiesArry = [cookiesStorage cookies];
    
    NSHTTPCookie *cookies = cookiesArry.firstObject;
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookies];
 
}

//获取图片时要用的
+(NSString *)getCommonAppinfoStr
{
    
//    NSString *tokenStr =  [NSString stringWithFormat:@"token=%@",[BaseRequestManager getAccessToken]];
//
//    
//    return tokenStr;
    
    
//    NSString *updateVersion = [HXUserModel shareInstance].updateVersion;
//    
//    
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"YibaoConfig" ofType:@"plist"];
//    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    
//    NSString *plistKey = [plistDic objectForKey:@"YIBAO_APP_CHANNEL_KEY"];
//
//    NSString *sepAndUpdate = [NSString stringWithFormat:@"%@=%@&%@=%@",HX_SEP,plistKey,YB_UPDATE_VERSION,updateVersion];
//    
//
//    return sepAndUpdate;
    
    return @"";
}




@end
