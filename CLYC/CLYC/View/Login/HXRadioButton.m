//
//  HXRadioButton.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "HXRadioButton.h"

@implementation HXRadioButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame isSelected:(BOOL)isSelected selectedImage:(UIImage *)selectedImage unSelectedImage:(UIImage *)unSelectedImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
        self.isSelected =isSelected;
        self.selectedImage = selectedImage;
        self.unSelectedImage = unSelectedImage;
        if (isSelected)
        {
            [self setImage:selectedImage forState:UIControlStateNormal];
        }
        else
        {
            [self setImage:unSelectedImage forState:UIControlStateNormal];
        }
        
        [self addTarget:self action:@selector(radioButtonClicked) forControlEvents:UIControlEventTouchUpInside];
  
    }
    return self;
}


-(void)refreshRadioButton
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL rememberPwd = [defaults boolForKey:@"rememberPwd"];
    self.isSelected =rememberPwd;
    if (rememberPwd)
    {
        [self setImage:RADIOBtn_SELECTED_IMAGE forState:UIControlStateNormal];
    }
    else
    {
        [self setImage:RADIOBtn_UNSELECTED_IMAGE forState:UIControlStateNormal];
    }
    
}


-(void)radioButtonClicked
{
    if (self.isSelected)
    {
        self.isSelected = NO;
        [self setImage:self.unSelectedImage forState:UIControlStateNormal];
        
    }
    else
    {
        self.isSelected = YES;
        [self setImage:self.selectedImage forState:UIControlStateNormal];
    }
    
    [self resultReponse:self.isSelected];
    
}

-(void)resultReponse:(BOOL)checkBoolResult
{
    if (_delegate && [_delegate respondsToSelector:@selector(radioButtonChange:didSelect:)])
    {
        [_delegate radioButtonChange:self didSelect:checkBoolResult];
    }
}



-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, 0, 20, 20);
}
-(CGRect )titleRectForContentRect:(CGRect)contentRect
{
    
    
    return CGRectMake(29,0, self.frame.size.width - 29 , self.frame.size.height);
    
}


@end
