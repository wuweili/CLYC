//
//  UITextField+HXExtentRange.m
//  BJXH-patient
//
//  Created by wu weili on 14-8-19.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "UITextField+HXExtentRange.h"

@implementation UITextField (HXExtentRange)

- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    if (startPosition && endPosition) {
        UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
        [self setSelectedTextRange:selectionRange];
        
    }
}


@end
