//
//  DocumentUtil.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <Foundation/Foundation.h>

// 沙盒中为各种类型的文件指定默认文件夹


//医生头像
#define RESOURCES_FOLDER_DOCTOR_AVATAR   @"Resources/Image/HeadPhoto_avatar/DoctorPhoto_Avatar"

//患者头像
#define RESOURCES_FOLDER_PATIENT_AVATAR   @"Resources/Image/HeadPhoto_avatar/PatientPhoto_Avatar"

//留言原图
#define RESOURCES_FOLDER_LEAVE_ORIGIN_IMAGE   @"Resources/Image/Leave_Msg_Image/LeaveMsg_Origin_Image"

//留言缩略图
#define RESOURCES_FOLDER_LEAVE_THUMBNAIL_IMAGE   @"Resources/Image/Leave_Msg_Image/LeaveMsg_Thumbnail_Image"

//病历原图
#define RESOURCES_FOLDER_RECORD_PICTURE_ORIGIN_IMAGE   @"Resources/Image/CaseRecord_Image/CaseRecord_Origin_Image"

//病历缩略图
#define RESOURCES_FOLDER_RECORD_PICTURE_THUMBNAIL_IMAGE   @"Resources/Image/CaseRecord_Image/CaseRecord_Thumbnail_Image"

//教育文章的图片

#define RESOURCES_FOLDER_ARTICLE_IMAGE   @"Resources/Image/Edu_Article_image"

//集团、渠道logo
#define RESOURCE_CHANNEL_GROUP_IMAGE  @"Resources/Image/Channel_Group_Image"







// 需要图片压缩的原图尺寸上限
#define IMAGE_COMPRESS_LIMIT 150
// 需要缩减图片尺寸的原图尺寸上限
#define IMAGE_RESIZE_LIMIT   960

// 与以上两个对应的缩略图参数
#define THUMBNAIL_COMPRESS_LIMIT 80
#define THUMBNAIL_RESIZE_LIMIT   150

// 图片压缩比
#define COMPRESSION_QUALITY 0.75

@interface DocumentUtil : NSObject {
    
}



/**
 * 创建基本的本地图片文件夹
 */

+(BOOL)createAllImageFolderPath;

/**
 * 按照压缩上限、缩放上限修正图片，同时修正照相时的方位错误
 */

+ (NSData *)fixImage:(UIImage *)image compressionLimite:(CGFloat)cl resizeLimite:(CGFloat)rl;


/**
 * 计算图片的实际大小位图大小
 */

+ (long)getImageSize:(UIImage *)image;



#pragma mark - 大夫头像 -

/**
 * 保存大夫头像
 */

+(NSString *)saveDoctorAvatar:(UIImage *)image withDoctorId:(NSString *)doctorId;


/**
 * 得到大夫头像
 */
+(NSString *)getDoctorHeadAvatarByDoctorId:(NSString *)doctorId isExist:(BOOL *)isExist;




#pragma mark - 患者头像 -

/**
 * 保存患者头像
 */

+(NSString *)savePatientAvatar:(UIImage *)image withPatientId:(NSString *)patientId;


/**
 * 得到患者头像
 */

+(NSString *)getPatientHeadAvatarByPatientId:(NSString *)patientId isExist:(BOOL *)isExist;


#pragma mark - 留言图片 - 

/**
 * 保存留言原图 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+ (NSString *)saveLeaveMessageOriginImage:(UIImage *)image imageUrl:(NSString *)imageUrl;


/**
 * 获取留言原图路径 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)getLeaveMessageOriginImageByImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist;

/**
 * 保存留言缩略图 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)saveLeaveMessageThumbnailImage:(UIImage *)image imageUrl:(NSString *)imageUrl;


/**
 * 获取留言缩略图路径 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)getLeaveMessageThumbnailImageByImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist;


#pragma mark - 病例图片 - 

/**
 * 保存病历缩略图 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)saveCaseRecordPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl;

/**
 * 获取病历缩略图 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)getCaseRecordPictureWithImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist;

/**
 * 保存病历原图 url需要处理   [NSString urlWithNoExtension:urlString];
 */

+(NSString *)saveCaseRecordOriginPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl;

/**
 * 获取病历原图 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)getCaseRecordOriginPictureWithImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist;


#pragma mark - 健康教育图片

/**
 * 获取健康教育图 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)saveArtTitlePicture:(UIImage *)image withImageUrl:(NSString *)imageUrl;

/**
 * NVOD 大图   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)saveArtTitleNVODPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl;


/**
 * 得到健康教育文章图片 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)getArtTitleWithTitleIdPicByImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist;




#pragma mark - 集团渠道图片

/**
 * 保存集团渠道图片 url需要处理   [NSString urlWithNoExtension:urlString];
 */
+(NSString *)saveChannelOrGroupPicture:(UIImage *)image withImageUrl:(NSString *)imageUrl;


/**
 * 获取集团渠道图片 url需要处理   [NSString urlWithNoExtension:urlString];
 */

+(NSString *)getChannelOrGroupPicByChannelOrGroupImageUrl:(NSString *)imageUrl isExist:(BOOL *)isExist;



@end
