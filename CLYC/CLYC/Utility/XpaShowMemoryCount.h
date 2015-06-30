//
//  XpaShowMemoryCount.h
//  XpaApp
//
//  Created by zengchao on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XpaShowMemoryCount : NSObject
{
    NSTimer* _showMemoryTimer;
    UITextView* _uiTextView;  
    CGSize _size;
}


+(XpaShowMemoryCount*)shareInstance;
+(void)clearInstance;
-(NSString*)reportMemory;
-(void)showMemory;
-(void)closeMemory;
-(void)refresh;
//断点，在这个地方断点打印出此处内存，后面写出添加得内存值
-(void)breakPoint:(NSString*)thisBreakPoint;
-(void)removeBreakPoint:(NSString*)thisBreakPoint;

@end
