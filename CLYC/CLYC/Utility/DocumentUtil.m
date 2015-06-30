//
//  DocumentUtil.m
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "DocumentUtil.h"
//#import "Photo.h"
#import "DateFormate.h"
#import "IMUnitsMethods.h"
#import "HXOther.h"

@implementation DocumentUtil

+(BOOL)createAllImageFolderPath
{
     BOOL isSuccess = NO;
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_DOCTOR_AVATAR isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_PATIENT_AVATAR isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_LEAVE_ORIGIN_IMAGE isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_LEAVE_THUMBNAIL_IMAGE isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_RECORD_PICTURE_ORIGIN_IMAGE isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_RECORD_PICTURE_THUMBNAIL_IMAGE isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCES_FOLDER_ARTICLE_IMAGE isSuccess:&isSuccess];
    
    [DocumentUtil createFolderPathWithFolderName:RESOURCE_CHANNEL_GROUP_IMAGE isSuccess:&isSuccess];
    
    
    

    return isSuccess;
    
}



+(BOOL)createFolderPathWithFolderName:(NSString *)folderName isSuccess:(BOOL *)isSuccess
{
    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [userPath stringByAppendingPathComponent:folderName];
    
    BOOL isExit;
    
    BOOL isFolder = NO;
    
    if ([fileManager fileExistsAtPath:folderPath isDirectory:&isFolder])
    {
        if (!isFolder)
        {
            isExit = NO;
            
        }
        
        isExit = YES;
        
    }
    else
    {
        isExit =  [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    if (isSuccess)
    {
        *isSuccess = isExit;
    }
    
    return isExit;

}


#pragma mark - common - 

+ (NSString *)pathForFolder:(NSString *)folderName fileName:(NSString *)docName
{
    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [userPath stringByAppendingPathComponent:folderName];
    BOOL isFolder = NO;
    if ([fileManager fileExistsAtPath:folderPath isDirectory:&isFolder])
    {
        if (!isFolder)
        {
            return nil;
        }
    }
    else
    {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return [folderPath stringByAppendingPathComponent:docName];
}



//image transform
+ (CGAffineTransform)transformForOrientation:(UIImageOrientation)imageOrientation newSize:(CGSize)newSize {
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

+ (UIImage *)fixImage:(UIImage *)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = image.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    CGAffineTransform transform = [DocumentUtil transformForOrientation:image.imageOrientation newSize:newSize];
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    //CGContextSetInterpolationQuality(bitmap, quality);
    
    BOOL transpose;
    
    switch (image.imageOrientation) {
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

+ (NSData *)fixImage:(UIImage *)image compressionLimite:(CGFloat)cl resizeLimite:(CGFloat)rl {
    CGSize size = image.size;
    CGFloat rate = size.width/size.height;
    CGFloat m = rate > 1 ? size.width : size.height;
    BOOL shouldResize = NO;
    if (m > rl) {
        if (rate > 1) {
            size.width = rl;
            size.height = rl/rate;
        }
        else {
            size.width = rl*rate;
            size.height = rl;
        }
        shouldResize = YES;
        //image = [Photo scaleImage:image toWidth:size.width toHeight:size.height];
    }
    if (image.imageOrientation != UIImageOrientationUp || shouldResize) {
        image = [DocumentUtil fixImage:image newSize:size];
    }
    CGFloat quality = m > cl ? COMPRESSION_QUALITY : 1.0;
    NSData *imgData = UIImageJPEGRepresentation(image, quality);

    return imgData;
}

+ (void)saveImage:(UIImage *)image compressionLimite:(CGFloat)cl resizeLimite:(CGFloat)rl savePath:(NSString *)savePath
{
    NSData *imgData = [DocumentUtil fixImage:image compressionLimite:cl resizeLimite:rl];
    [imgData writeToFile:savePath atomically:YES];
}






// 计算图片的实际大小位图大小
+ (long)getImageSize:(UIImage *)image
{
    
    int  perMBBytes = 1024*1024;
    
    CGImageRef cgimage = image.CGImage;
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    
    long lPixelsPerMB  = perMBBytes/bytes_per_pixel;
    
    
    long totalPixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    
    
    long totalFileMB = totalPixel/lPixelsPerMB;
    
    return totalFileMB;
    
}





#pragma mark - 大夫头像 - 

+(NSString *)pathForDoctorHeadAvatarFilename:(NSString *)fileName doctorId:(NSString *)doctorId
{
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_DOCTOR_AVATAR];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:doctorId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];

    return [DocumentUtil pathForFolder:stringPath fileName:fileName];
    
}

/**
 * 文件名，暂时不加.jpeg
 */

+ (NSString *)createDoctorImageFileNameWithExtension:(NSString *)extension withDoctorId:(NSString *)doctorId
{
    
    return [NSString stringWithFormat:@"%@.%@",doctorId,extension];
}

//保存大夫头像
+(NSString *)saveDoctorAvatar:(UIImage *)image withDoctorId:(NSString *)doctorId
{
    NSString *filename = [DocumentUtil createDoctorImageFileNameWithExtension:@"jpeg" withDoctorId:doctorId];
    NSString *filepath = [DocumentUtil pathForDoctorHeadAvatarFilename:filename doctorId:doctorId];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

//得到大夫头像
+(NSString *)getDoctorHeadAvatarByDoctorId:(NSString *)doctorId isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createDoctorImageFileNameWithExtension:@"jpeg"  withDoctorId:doctorId];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_DOCTOR_AVATAR];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:doctorId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    

    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}



#pragma mark - 患者头像 -

+(NSString *)pathForPatientHeadAvatarFilename:(NSString *)fileName patientId:(NSString *)patientId
{
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_PATIENT_AVATAR];
    
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:patientId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    return [DocumentUtil pathForFolder:stringPath fileName:fileName];
    
}

+ (NSString *)createPatientImageFileNameWithExtension:(NSString *)extension withPatientId:(NSString *)patientId
{
    
//    return [NSString stringWithFormat:@"%@.%@",leaveTime,extension];
    
    return [NSString stringWithFormat:@"%@.%@",patientId,extension];
}

//保存患者头像
+(NSString *)savePatientAvatar:(UIImage *)image withPatientId:(NSString *)patientId
{
    NSString *filename = [DocumentUtil createPatientImageFileNameWithExtension:@"jpeg"  withPatientId:patientId];
    NSString *filepath = [DocumentUtil pathForPatientHeadAvatarFilename:filename patientId:patientId];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

//得到患者头像
+(NSString *)getPatientHeadAvatarByPatientId:(NSString *)patientId isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createPatientImageFileNameWithExtension:@"jpeg" withPatientId:patientId];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_PATIENT_AVATAR];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:patientId];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    
    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (isExist)
    {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}



#pragma mark - 留言图片 函数描述:保存LeaveMessge图片 原图和缩略图



//原图
+(NSString *)pathLeaveMessageOriginImageFileName:(NSString *)fileName withImageUrl:(NSString *)imageUrl
{
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_LEAVE_ORIGIN_IMAGE];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    return [DocumentUtil pathForFolder:stringPath fileName:fileName];
}

+ (NSString *)createLeaveMessageOriginImageWithExtension:(NSString *)extension withImageUrl:(NSString *)imageUrl
{
    
    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
}

+ (NSString *)saveLeaveMessageOriginImage:(UIImage *)image imageUrl:(NSString *)imageUrl
{
    NSString *filename = [DocumentUtil createLeaveMessageOriginImageWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathLeaveMessageOriginImageFileName:filename withImageUrl:imageUrl];
    [DocumentUtil saveImage:image
          compressionLimite:IMAGE_COMPRESS_LIMIT
               resizeLimite:IMAGE_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

+(NSString *)getLeaveMessageOriginImageByImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createLeaveMessageOriginImageWithExtension:@"jpeg" withImageUrl:imageUrl];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_LEAVE_ORIGIN_IMAGE];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];

    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist)
    {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}

//缩略图
+(NSString *)pathLeaveMessageThumbnailImageFileName:(NSString *)fileName withImageUrl:(NSString *)imageUrl
{
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_LEAVE_THUMBNAIL_IMAGE];
    
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    
    
    
    return [DocumentUtil pathForFolder:stringPath fileName:fileName];
}

+ (NSString *)createLeaveMessageThumbnailImageWithExtension:(NSString *)extension withImageUrl:(NSString *)imageUrl
{
    
    
    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
    
}


+(NSString *)saveLeaveMessageThumbnailImage:(UIImage *)image imageUrl:(NSString *)imageUrl

{
    NSString *filename = [DocumentUtil createLeaveMessageThumbnailImageWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathLeaveMessageThumbnailImageFileName:filename withImageUrl:imageUrl];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

+(NSString *)getLeaveMessageThumbnailImageByImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createLeaveMessageThumbnailImageWithExtension:@"jpeg" withImageUrl:imageUrl];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_LEAVE_THUMBNAIL_IMAGE];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];

    NSString *userPath = [IMUnitsMethods userFilePath];
    
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}


#pragma mark - 病例图片

//病例等里面的图片 缩略图

+(NSString *)pathForCaseRecorePicture:(NSString *)fileName imageUrl:(NSString *)imageUrl
{
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_RECORD_PICTURE_THUMBNAIL_IMAGE];
    
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    
    return [DocumentUtil pathForFolder:stringPath fileName:fileName];
}

+ (NSString *)createCaseImageFileNameWithExtension:(NSString *)extension withImageUrl:(NSString *)imageUrl
{
//    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
    
    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
  
}

+(NSString *)saveCaseRecordPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl
{
    NSString *filename = [DocumentUtil createCaseImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathForCaseRecorePicture:filename imageUrl:imageUrl];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

+(NSString *)getCaseRecordPictureWithImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createCaseImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_RECORD_PICTURE_THUMBNAIL_IMAGE];
    
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];

    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}


//原图


+(NSString *)pathForCaseRecoreOriginPicture:(NSString *)fileNname imageUrl:(NSString *)imageUrl
{
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_RECORD_PICTURE_ORIGIN_IMAGE];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    return [DocumentUtil pathForFolder:stringPath fileName:fileNname];
}

+ (NSString *)createCaseImageOriginFileNameWithExtension:(NSString *)extension withImageUrl:(NSString *)imageUrl
{
    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
}

+(NSString *)saveCaseRecordOriginPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl
{
    NSString *filename = [DocumentUtil createCaseImageOriginFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathForCaseRecoreOriginPicture:filename imageUrl:imageUrl];
    [DocumentUtil saveImage:image
          compressionLimite:IMAGE_COMPRESS_LIMIT
               resizeLimite:IMAGE_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

+(NSString *)getCaseRecordOriginPictureWithImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createCaseImageOriginFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_RECORD_PICTURE_ORIGIN_IMAGE];
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];

    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}





#pragma mark - 健康教育文章图片 -

+(NSString *)pathForArtTitlePicture:(NSString *)fileName imageUrl:(NSString *)imageUrl
{
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_ARTICLE_IMAGE];
    
    
    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];
    
    
    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];
    
    
    
    return [DocumentUtil pathForFolder:stringPath fileName:fileName];
}

+ (NSString *)createArticleImageFileNameWithExtension:(NSString *)extension withImageUrl:(NSString *)imageUrl
{
    
    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
}

//保存 小图
+(NSString *)saveArtTitlePicture:(UIImage *)image withImageUrl:(NSString *)imageUrl
{
    NSString *filename = [DocumentUtil createArticleImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathForArtTitlePicture:filename imageUrl:imageUrl];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}

//保存 NVOD 大图
+(NSString *)saveArtTitleNVODPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl
{
    NSString *filename = [DocumentUtil createArticleImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathForArtTitlePicture:filename imageUrl:imageUrl];
    [DocumentUtil saveImage:image
          compressionLimite:IMAGE_COMPRESS_LIMIT
               resizeLimite:IMAGE_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}


//得到健康教育文章图片
+(NSString *)getArtTitleWithTitleIdPicByImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createArticleImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@",RESOURCES_FOLDER_ARTICLE_IMAGE];

    NSString *imageOwnerPathName = [NSString getMD5_2_Str:imageUrl];

    NSString *stringPath = [NSString stringWithFormat:@"%@/%@",folderPath,imageOwnerPathName];

    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *realFolderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [realFolderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}




#pragma mark - 集团渠道主页 -

+(NSString *)pathForChannelOrGroupPicture:(NSString *)fileName
{
    return [DocumentUtil pathForFolder:RESOURCE_CHANNEL_GROUP_IMAGE fileName:fileName];
}

+ (NSString *)createChannelOrGroupImageFileNameWithExtension:(NSString *)extension withImageUrl:(NSString *)imageUrl
{
    
//    return [NSString stringWithFormat:@"%@.%@",channelId,extension];
    
    return [NSString stringWithFormat:@"%@.%@",imageUrl,extension];
    
}


+(NSString *)saveChannelOrGroupPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl
{
    NSString *filename = [DocumentUtil createChannelOrGroupImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    NSString *filepath = [DocumentUtil pathForChannelOrGroupPicture:filename];
    [DocumentUtil saveImage:image
          compressionLimite:THUMBNAIL_COMPRESS_LIMIT
               resizeLimite:THUMBNAIL_RESIZE_LIMIT
                   savePath:filepath];
    return filepath;
}


+(NSString *)getChannelOrGroupPicByChannelOrGroupImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist
{
    NSString *filename = [DocumentUtil createChannelOrGroupImageFileNameWithExtension:@"jpeg" withImageUrl:imageUrl];
    
    NSString *stringPath = [NSString stringWithFormat:@"%@",RESOURCE_CHANNEL_GROUP_IMAGE];

    NSString *userPath = [IMUnitsMethods userFilePath];
    NSString *folderPath = [userPath stringByAppendingPathComponent:stringPath];
    NSString *fliePath = [folderPath stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isExist) {
        *isExist = [fileManager fileExistsAtPath:fliePath];
    }
    return fliePath;
}









@end
