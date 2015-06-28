//
//  HXRadioButton.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RadioButtonDelegate <NSObject>


- (void)radioButtonChange:(id)radiobutton didSelect:(BOOL)selectBoolResult ;

@end


@interface HXRadioButton : UIButton

@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,strong)UIImage *selectedImage;
@property(nonatomic,strong)UIImage *unSelectedImage;
@property(nonatomic,weak)id<RadioButtonDelegate>delegate;

-(id)initWithFrame:(CGRect)frame isSelected:(BOOL)isSelected selectedImage:(UIImage *)selectedImage unSelectedImage:(UIImage *)unSelectedImage;

-(void)refreshRadioButton;

@end
