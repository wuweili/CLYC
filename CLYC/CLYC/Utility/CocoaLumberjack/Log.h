//
//  Log.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"
#import "DDFileLogger.h"
#import "DDTTYLogger.h"



/******************************
 * 默认LOG等级，由开发者调试时候设置
 *******************************/

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface Log : NSObject

+ (Log *)logOpen;

- (id)init;



@end
