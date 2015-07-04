//
//  XCCenterSecondCollectionViewCell.m
//  XCWash
//
//  Created by weili.wu on 15/4/2.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCCenterSecondCollectionViewCell.h"

@implementation XCCenterSecondCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];

        self.cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        self.cellImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.cellImageView];

        
    }
    
    return self;
    
    
}

@end
