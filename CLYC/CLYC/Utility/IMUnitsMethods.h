//
//  IMUnitsMethods.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

/**
 *
 * Only Support Static Methodes !
 *
 **/

#import <Foundation/Foundation.h>
#import "NSString+Utility.h"
#import "RegexKitLite.h"

@interface IMUnitsMethods : NSObject

//导航左按钮
+(void)drawTheLeftBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title;

+(void)drawTheLeftBarBtn:(UIViewController *)control btnTitle:(NSString*)title;

//导航右按钮

+(void)drawTheRightBarBtn:(UIViewController *)control function:(SEL )funName  btnTitle:(NSString*)title bgImage:(UIImage*)image;


// 获取当前用户文件目录（如没有则通过合抱用户id创建）
+ (NSString *)userFilePath;

#pragma mark  获取当前document文件目录
+ (NSString *)userDocumentPath;


//信息主界面的时间显示格式
+ (NSString *)convertDateToMsgShow:(NSString *)dateStr WithDetail:(BOOL)flag;


//屏蔽emoji表情输入 不适应九宫格输入法
+(BOOL)stringContainsEmoji:(NSString *)string;
//屏蔽emoji表情输入
+(NSString *)disable_emoji:(NSString *)text;

//判断输入长度  屏蔽系统表情及防止手写时崩溃
+(void)limitInputTextWithTextView:(UITextView *)textView limit:(NSInteger)limit;


//判断输入长度  屏蔽系统表情及防止手写时崩溃  UITextField
+(void)limitInputTextWithUITextField:(UITextField *)textField limit:(NSInteger)limit;

#pragma mark - 统计ASCII和Unicode混合文本长度的，看下来和新浪微博的统计结果是一致的
+(NSUInteger)unicodeLengthOfString:(NSString *)text;

#pragma mark -判断输入的邮箱格式是否正确
+(BOOL)checkInputEmail:(NSString*)text;

#pragma mark -判断输入的身高格式是否正确
+(BOOL)checkInputHeight:(NSString*)text;

#pragma mark -判断输入的体重格式是否正确
+(BOOL)checkInputWeigth:(NSString*)text;
#pragma mark 手机号码判断方法
+(BOOL)regexPhoneNumber:(NSString*)phoneNumber;
#pragma mark - 判断输入的军官证格式是否正确
+(BOOL)checkInputOfficeCertificate:(NSString*)text;

#pragma mark - 身份证判断方法
+(BOOL)regexIdCardToEighteenNumber:(NSString*)idCard;

//身份证判断方法
+(BOOL)regexPersonalIdentifierNum:(NSString *)value;

+ (NSString *)generateUUID;

+ (NSString *)createRecordPictureName;

//清空session
+(void)clearSession;



//获取图片时要用的
+(NSString *)getCommonAppinfoStr;

@end
