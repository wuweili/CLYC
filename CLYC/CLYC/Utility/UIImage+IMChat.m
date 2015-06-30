//
//  UIImage+IMChat.m
//  IOS-IM
//
//  Created by ZhangGang on 13-9-17.
//  Copyright (c) 2013年 weihua. All rights reserved.
//

#import "UIImage+IMChat.h"

@implementation UIImage (IMChat)

#pragma mark - Avatar styles
- (UIImage *)circleImageWithSize:(CGFloat)size
{
    return [self imageAsCircle:YES
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

- (UIImage *)squareImageWithSize:(CGFloat)size
{
    return [self imageAsCircle:NO
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

//add by xishuaishuai 处理圆角图片
- (UIImage *)roundImageWithSize:(CGFloat)size
{
    return [self imageAsRound:YES
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

- (UIImage *)imageAsRound:(BOOL)clipToCircle
              withDiamter:(CGFloat)diameter
              borderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             shadowOffSet:(CGSize)shadowOffset
{
    // increase given size for border and shadow
    CGFloat increase = 0.0;//diameter * 0.15f;
    CGFloat newSize = diameter; //+ increase;
    
    CGRect newRect = CGRectMake(0.0f,
                                0.0f,
                                newSize,
                                newSize);
    
    // fit image inside border and shadow
    CGRect imgRect = CGRectMake(increase,
                                increase,
                                newRect.size.width - (increase * 2.0f),
                                newRect.size.height - (increase * 2.0f));
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw shadow
    if(!CGSizeEqualToSize(shadowOffset, CGSizeZero))
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(shadowOffset.width, shadowOffset.height),
                                    3.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
//    // draw border
//    // as circle or square
//    CGPathRef borderPath = CGPathCreateWithRect(imgRect, NULL);
//    
//    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
//    CGContextSetLineWidth(context, borderWidth);
//    CGContextAddPath(context, borderPath);
//    CGContextDrawPath(context, kCGPathFillStroke);
//    CGPathRelease(borderPath);
//    CGContextRestoreGState(context);
    
    // clip to circle
    if(clipToCircle) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithRoundedRect:imgRect cornerRadius:4.0];
        [imgPath addClip];
    }
    
    [self drawInRect:imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (UIImage *)imageAsCircle:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
              shadowOffSet:(CGSize)shadowOffset
{
    // increase given size for border and shadow
    CGFloat increase = 0.0;//diameter * 0.15f;
    CGFloat newSize = diameter; //+ increase;
    
    CGRect newRect = CGRectMake(0.0f,
                                0.0f,
                                newSize,
                                newSize);
    
    // fit image inside border and shadow
    CGRect imgRect = CGRectMake(increase,
                                increase,
                                newRect.size.width - (increase * 2.0f),
                                newRect.size.height - (increase * 2.0f));
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw shadow
    if(!CGSizeEqualToSize(shadowOffset, CGSizeZero))
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(shadowOffset.width, shadowOffset.height),
                                    3.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
    // draw border
    // as circle or square
    CGPathRef borderPath = (clipToCircle) ? CGPathCreateWithEllipseInRect(imgRect, NULL) : CGPathCreateWithRect(imgRect, NULL);
    
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);//modidy by xishuaishuai borderColor
    CGContextSetLineWidth(context, borderWidth);
    CGContextAddPath(context, borderPath);
    [[UIColor clearColor] setFill];//设置要填充颜色。//add by xishuaishuai//有问题的话再打开
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(borderPath);
    CGContextRestoreGState(context);
    
    // clip to circle
    if(clipToCircle) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:imgRect];
        [imgPath addClip];
    }
    
    [self drawInRect:imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Input bar
+ (UIImage *)inputBar
{
    return [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
}

+ (UIImage *)inputField
{
    return [[UIImage imageNamed:@"input-field"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
}

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableSquareIncoming
{
     return [self stretchableImageWithLeftCapWidth:20 topCapHeight:20];//modify by xishuaishuai 20 30 to 20 20
}

- (UIImage *)makeStretchableSquareOutgoing
{
//    return [self stretchableImageWithLeftCapWidth:20 topCapHeight:20];//modify by xishuaishuai 20 30 to 20 20
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(26.0f,17.0f,10.0f,17.0f)];
    
}


- (UIImage *)textImageStretchableIncoming
{
    //return [self stretchableImageWithLeftCapWidth:50 topCapHeight:30];
     return [self resizableImageWithCapInsets:UIEdgeInsetsMake(26.0f,17.0f,10.0f,17.0f)];
//    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(52.0f,34.0f,18.0f,34.0f)];
//    return [self stretchableImageWithLeftCapWidth:20 topCapHeight:40];  26.0f,17.0f,10.0f,17.0f
}

- (UIImage *)textImageStretchableOutgoing
{
    // return [self stretchableImageWithLeftCapWidth:50 topCapHeight:30];
//    return [self stretchableImageWithLeftCapWidth:30 topCapHeight:15];
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(26.0f,17.0f,10.0f,17.0f)];
    
    
}


////////////////------------////////////////////
//image transform
- (CGAffineTransform)transformForOrientation:(UIImageOrientation)imageOrientation newSize:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

- (UIImage *)fixImageWithNewSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    CGAffineTransform transform = [self transformForOrientation:self.imageOrientation newSize:newSize];
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    //CGContextSetInterpolationQuality(bitmap, quality);
    
    BOOL transpose;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transpose = YES;
            break;
        default:
            transpose = NO;
    }
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

- (NSData *)fixImageWithHeightLimite:(CGFloat)hl widthLimite:(CGFloat)wl {
    CGSize size = self.size;
    //    float compressionRatio = 1.0f;
    BOOL shouldResize = NO;
    if (size.height > hl) {
        CGFloat hrate = hl/size.height;
        size.height = hl;
        size.width = hrate * size.width;
        shouldResize = YES;
    }
    if (size.width > wl) {
        CGFloat wrate = wl/size.width;
        size.width = wl;
        size.height = wrate * size.width;
        shouldResize = YES;
    }
    UIImage *newImage = self;
    if (self.imageOrientation != UIImageOrientationUp || shouldResize) {
        newImage = [self fixImageWithNewSize:size];
    }
    //    NSData *imgData = UIImageJPEGRepresentation(newImage, compressionRatio);
    NSData* imgData = UIImagePNGRepresentation(newImage);
    return imgData;
}

- (NSData *)compressImageWithHeightLimite:(CGFloat)hl widthLimite:(CGFloat)wl
{
    CGSize size = self.size;
    BOOL shouldResize = NO;
    if (size.height > hl) {
        CGFloat hrate = hl/size.height;
        size.height = hl;
        size.width = hrate * size.width;
        shouldResize = YES;
    }
    if (size.width > wl) {
        CGFloat wrate = wl/size.width;
        size.width = wl;
        size.height = wrate * size.width;
        shouldResize = YES;
    }
    UIImage *newImage = self;
    if (self.imageOrientation != UIImageOrientationUp || shouldResize) {
        newImage = [self fixImageWithNewSize:size];
    }
    NSData *imgData = UIImageJPEGRepresentation(newImage, 0.6);
    //    NSData* imgData = UIImagePNGRepresentation(newImage);
    return imgData;
}

@end
