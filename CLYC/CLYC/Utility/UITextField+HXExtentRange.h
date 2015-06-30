//
//  UITextField+HXExtentRange.h
//  BJXH-patient
//
//  Created by wu weili on 14-8-19.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (HXExtentRange)

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end
