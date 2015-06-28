//
//  UIImageView+Avatar.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Avatar)


/**
 * 基本的下载图片网络请求 外部不要调用
 */
-(void)baseRequestWithImageUrl:(NSString *)imageUrl commonDownloadPathUrl:(NSString *)downloadUrl placeholderImage:(UIImage*)placeholderImage withBlock:(void (^)(UIImage * image,NSError *error))block;


/**
 * 优先从本地加载医生头像
 */
-(void)setDoctorAvatarFromLocalFileWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 从网络获取医生最新头像
 */
-(void)setDoctorAvatarFromServerWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size;


/**
 * 优先从本地加载患者头像
 */
-(void)setPatientAvatarFromLocalFileWithPatientId:(NSString *)patientId headUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 从网络获取患者最新头像
 */
-(void)setPatientAvatarFromServerWithPatientId:(NSString *)patientId headUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 病例中的图片
 */
- (void)setCaseRecordImageWithRecordPictureId:(NSString *)pictureId pictureUrl:(NSString *)urlString;


/**
 * 设置教育文章轮播大图
 */

-(void)setArtTitleNVODImageWithPictureUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 设置教育文章小图
 */

-(void)setArtTitleImageWithPictureUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 设置评论者-患者 - 图片
 */
-(void)setArtTitleWithPatientCommentUserId:(NSString *)commentUserId pictureUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 设置评论者-医生 - 图片
 */
-(void)setArtTitleWithDoctorCommentUserId:(NSString *)commentUserId pictureUrl:(NSString *)urlString withSize:(CGFloat)size;


/**
 * 设置集团图片 优先从本地获取
 */
-(void)setGroupAvatarFromLocalFileWithGroupId:(NSString *)groupId headUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 设置集团图片 从网络获取
 */
-(void)setGroupAvatarFromServerWithGroupId:(NSString *)groupId headUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 设置渠道图片 优先从本地获取
 */
-(void)setChannelAvatarFromLocalFileWithChannelId:(NSString *)channelId headUrl:(NSString *)urlString withSize:(CGFloat)size;

/**
 * 设置渠道图片 从网络获取
 */
-(void)setChannelAvatarFromServerWithChannelId:(NSString *)channelId headUrl:(NSString *)urlString withSize:(CGFloat)size;


/**
 * 设置留言图片
 */
-(void)setLeaveMessageImageWithImageUrl:(NSString *)urlString;


@end
