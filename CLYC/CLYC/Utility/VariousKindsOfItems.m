//
//  HXVariousKindsOfItems.m
//  BJXH-patient
//
//  Created by weili.wu on 15/4/9.
//  Copyright (c) 2015年 weihua. All rights reserved.
//

#import "VariousKindsOfItems.h"

@implementation VariousKindsOfItems

/**
 * 创建一个button button上左边文字，右边小图片   同时有正常/高亮下的背景图   文字和图片在点击/高亮/选中状态下不变
 */


+(UIButton *)createButtonWithFrame:(CGRect )frame
                            Target:(id)target
                            action:(SEL)action
                             Title:(NSString *)title
                         titleFont:(UIFont *)font
                        titleColor:(UIColor*)color
                             image:(UIImage *)image
                   backgroundImage:(UIImage *)backgroundImage
        highlightedBackGroundImage:(UIImage *)highlightedBackGroundImage
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.titleLabel.font = font;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGSize size = [title sizeWithFont:font];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, -size.width)];
    
    [btn setBackgroundImage:highlightedBackGroundImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

/**
 * 创建一个button button上左边文字，右边小图片   同时有正常/高亮下的背景图   文字和图片在点击/选中状态下会改变
 */
+(UIButton *)createButtonWithFrame:(CGRect )frame
                            Target:(id)target
                            action:(SEL)action
                             Title:(NSString *)title
                     selectedTitle:(NSString *)selectedTitle
                         titleFont:(UIFont *)font
                        titleColor:(UIColor*)color
                             image:(UIImage *)image
                     selectedImage:(UIImage *)selectedImage
                   backgroundImage:(UIImage *)backgroundImage
        highlightedBackGroundImage:(UIImage *)highlightedBackGroundImage
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.titleLabel.font = font;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    
    CGSize size = [title sizeWithFont:font];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, -size.width)];
    
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    [btn setBackgroundImage:highlightedBackGroundImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


+(UIButton *)createStartConsultButtonWithFrame:(CGRect )frame
                            Target:(id)target
                            action:(SEL)action
                             Title:(NSString *)title
                         titleFont:(UIFont *)font
                        titleColor:(UIColor*)color
                             image:(UIImage *)image
                   backgroundImage:(UIImage *)backgroundImage
        highlightedBackGroundImage:(UIImage *)highlightedBackGroundImage
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.titleLabel.font = font;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGSize size = [title sizeWithFont:font];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, image.size.width+30, 0, image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -size.width-30, 0, -size.width)];
    
     [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedBackGroundImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


@end
