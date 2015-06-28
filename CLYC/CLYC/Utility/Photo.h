//
//  Photo.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "IMDialogObject.h"

@interface Photo : NSObject {
	
}

/*
 * 缩放图片
 * image 图片对象
 * toWidth 宽
 * toHeight 高
 * return 返回图片对象
 */
+(UIImage *)scaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 缩放图片数据
 * imageData 图片数据
 * toWidth 宽
 * toHeight 高
 * return 返回图片数据对象
 */
+(NSData *)scaleData:(NSData *)imageData toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 圆角
 * image 图片对象
 * size 尺寸
 */
+(id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;

/*
 * image 图片对象
 * size 尺寸
 */
+ (UIImage*)scalingImageSize:(CGSize)targetSize sorceImgage:(UIImage*) sourceImage;

/*
 * 图片转换为字符串
 */
+(NSString *) image2String:(UIImage *)image;

/*
 * 字符串转换为图片
 */
+(UIImage *) string2Image:(NSString *)string;

/*
 *从文件中加载小型图片到内存中
 */
+(UIImage*) loadImage:(NSString*) filePath;

/*
 *线程安全加载小型图片到内存中
 */
+(UIImage*) loadImageThreadSafe:(NSString *)filePath;
/*
 * 对应卸载内存中的图片，释放转载图片内存
 */
+(void) unloadImages;

/*
 * 对应卸载内存中的对应的图片，释放转载图片内存
 */
+ (void)unloadImageForKey:(NSString *)filePath;


/*
 * 根据群成员头像，创建群头像
 */
+ (UIImage *)createGroupAvatarByContacts:(NSArray *)contactArray;

/*
 * 根据头像 url，创建群头像
 */
//+ (UIImage *)createGroupAvatarByStrings:(IMDialogObject *)object;
@end
