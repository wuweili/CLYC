//
//  Log.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

// DDLog的简单调用控制
#import "Log.h"
#import <Foundation/Foundation.h>

@implementation Log

+ (Log *)logOpen
{
    static Log *shareLogInstance = nil;
    
    static dispatch_once_t doInit;
    dispatch_once(&doInit, ^{
        shareLogInstance = [[self alloc] init];
    });
    
    return shareLogInstance;
}

- (id)init
{
    if(self = [super init])
    {
#ifdef CONSOLE_LOG_ON
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
#endif
        
#ifdef FILE_LOG_ON
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.maximumFileSize = (1024 * 1024 * 2); //  2 MB
        fileLogger.rollingFrequency = 60 * 60 * 4;      //记录4个小时的log
        fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
        
        [DDLog addLogger:fileLogger];
#endif

    }
    return self;
}


- (void)dealloc
{
}


@end
