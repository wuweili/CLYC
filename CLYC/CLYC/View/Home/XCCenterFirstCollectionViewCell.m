//
//  XCCenterFirstCollectionViewCell.m
//  XCWash
//
//  Created by weili.wu on 15/4/2.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCCenterFirstCollectionViewCell.h"

@implementation XCCenterFirstCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 17,22)];
        self.cellImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.cellImageView];
        
        
        self.cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cellImageView.frame)+5, 7, CGRectGetWidth(self.frame)-10-30-5, 30)];
        self.cellLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.cellLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, 1)];
        line.backgroundColor = UIColorFromRGB(0xcccccc);
        [self addSubview:line];
        
        
        
    }
    
    return self;
    
    
}


@end
