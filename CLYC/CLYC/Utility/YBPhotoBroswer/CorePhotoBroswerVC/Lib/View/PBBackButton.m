//
//  PBBackButton.m
//  BJXH-patient
//
//  Created by weili.wu on 15/5/20.
//  Copyright (c) 2015年 weihua. All rights reserved.
//

#import "PBBackButton.h"

@implementation PBBackButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}

/*
 *  视图准备
 */
-(void)viewPrepare
{
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    
    
//    [self setImage:[UIImage imageNamed:@"PB.bundle/preview_save_icon"] forState:UIControlStateNormal];
//    [self setImage:[UIImage imageNamed:@"PB.bundle/preview_save_icon_highlighted"] forState:UIControlStateHighlighted];
//    [self setImage:[UIImage imageNamed:@"PB.bundle/preview_save_icon_disable"] forState:UIControlStateDisabled];
}


@end
