//
//  UIImage+IMChat.h
//  IOS-IM
//
//  Created by ZhangGang on 13-9-17.
//  Copyright (c) 2013年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IMChat)

#pragma mark - Avatar styles
- (UIImage *)circleImageWithSize:(CGFloat)size;
- (UIImage *)squareImageWithSize:(CGFloat)size;

- (UIImage *)imageAsCircle:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
              shadowOffSet:(CGSize)shadowOffset;

//add by xishuaishuai
- (UIImage *)roundImageWithSize:(CGFloat)size;

- (UIImage *)imageAsRound:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
             shadowOffSet:(CGSize)shadowOffset;

#pragma mark - Input bar
+ (UIImage *)inputBar;
+ (UIImage *)inputField;

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableSquareIncoming;
- (UIImage *)makeStretchableSquareOutgoing;

#pragma mark 发送和接收文字
+ (UIImage *)bubbleSquareIncoming;
+ (UIImage *)bubbleSquareIncomingSelected;
+ (UIImage *)bubbleSquareOutgoing;
+ (UIImage *)bubbleSquareOutgoingSelected;

#pragma mark 发送和接收图片
+ (UIImage *)bubbleImageOutgoing;
+ (UIImage *)bubbleImageIncoming;

////////////////////////////////////////////////////////////////////
#pragma mark 发送和接收名片
////////////////////////////////////////////////////////////////////
+ (UIImage *)bubbleVcardOutgoing;
+ (UIImage *)bubbleVcardOutgoingSelected;
+ (UIImage *)bubbleVcardIncoming;
+ (UIImage *)bubbleVcardIncomingSelected;

///////////////////////////////////////////////////////////////////
- (NSData *)fixImageWithHeightLimite:(CGFloat)hl widthLimite:(CGFloat)wl;

- (NSData *)compressImageWithHeightLimite:(CGFloat)hl widthLimite:(CGFloat)wl;

@end
