//
//  HXVariousKindsOfItems.h
//  BJXH-patient
//
//  Created by weili.wu on 15/4/9.
//  Copyright (c) 2015年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariousKindsOfItems : NSObject


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
        highlightedBackGroundImage:(UIImage *)highlightedBackGroundImage;



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
        highlightedBackGroundImage:(UIImage *)highlightedBackGroundImage;


+(UIButton *)createStartConsultButtonWithFrame:(CGRect )frame
                                        Target:(id)target
                                        action:(SEL)action
                                         Title:(NSString *)title
                                     titleFont:(UIFont *)font
                                    titleColor:(UIColor*)color
                                         image:(UIImage *)image
                               backgroundImage:(UIImage *)backgroundImage
                    highlightedBackGroundImage:(UIImage *)highlightedBackGroundImage;

@end
