//
//  UIImageView+Avatar.m
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "UIImageView+Avatar.h"
#import "DocumentUtil.h"
#import "UIImageView+AFNetworking.h"
#import "Photo.h"
#import "UIImage+IMChat.h"
#import "HXUserModel.h"
#import "AppDelegate.h"



@implementation UIImageView (Avatar)

-(NSString *)getCommonAppinfoStr
{
    NSString *result = [IMUnitsMethods getCommonAppinfoStr];
    return result;
}

-(void)baseRequestWithImageUrl:(NSString *)imageUrl commonDownloadPathUrl:(NSString *)downloadUrl placeholderImage:(UIImage *)placeholderImage withBlock:(void (^)(UIImage *, NSError *))block
{
    
   
    
    NSString *urlSuffix = [self getCommonAppinfoStr];
    
    NSRange range = [imageUrl rangeOfString:downloadUrl];
    NSString *imageThumbUrl = [NSString stringWithFormat:@"%@%@&%@",downloadUrl,imageUrl,urlSuffix];
    if (range.location != NSNotFound) {
        imageThumbUrl = [NSString stringWithFormat:@"%@&%@",imageUrl,urlSuffix];;
    }
    
    NSURL *requestUrl = [NSURL URLWithString:[imageThumbUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if (block)
        {
            block(image,nil);
        }
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        
        if (block)
        {
            block(nil,error);
        }  
    }];
  
}

/*

/**
 * 优先从本地加载
 */
-(void)setDoctorAvatarFromLocalFileWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
    
    if (isExist)
    {
        UIImage *localImage = [Photo loadImageThreadSafe:iconPath];
        
        self.image = [localImage circleImageWithSize:size];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            
            self.image = DOCTOR_DEFAULT_HEADIMAGE;
            
            return;
            
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    tempImgView.image = DOCTOR_DEFAULT_HEADIMAGE;
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];
                    });

 
                    
                }

            }];
        }
  
    }
  
}


/**
 * 从网络获取最新头像
 */
-(void)setDoctorAvatarFromServerWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    
    
    if ([NSString isBlankString:urlString])
    {
        
        self.image = DOCTOR_DEFAULT_HEADIMAGE;
        
        return;
        
    }
    else
    {
        
        __weak UIImageView *tempImgView = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                tempImgView.image = DOCTOR_DEFAULT_HEADIMAGE;
            }
            else
            {

                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    BOOL isExist = NO;
                    NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
                    if (isExist)
                    {
                        [Photo unloadImageForKey:iconPath];
                        
                    }
                });
                
                
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [tempImgView setImage:tmpImage];
                
                
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];
                });
                
               
            }
            
        }];
    }
}




/**
 * 优先从本地加载患者头像
 */
-(void)setPatientAvatarFromLocalFileWithPatientId:(NSString *)patientId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getPatientHeadAvatarByPatientId:patientId isExist:&isExist];
    
    if (isExist)
    {
        UIImage *localImage = [Photo loadImageThreadSafe:iconPath];
        
        self.image = [localImage circleImageWithSize:size];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            
            self.image = Patient_DEFAULT_HEADIMAGE;
            
            return;
            
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:Patient_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    tempImgView.image = Patient_DEFAULT_HEADIMAGE;
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil savePatientAvatar:image withPatientId:patientId];
                    });
                    
                    
                    
                }
                
            }];
        }
        
    }
}


/**
 * 从网络获取患者最新头像
 */
-(void)setPatientAvatarFromServerWithPatientId:(NSString *)patientId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    if ([NSString isBlankString:urlString])
    {
        
        self.image = Patient_DEFAULT_HEADIMAGE;
        
        return;
        
    }
    else
    {
        __weak UIImageView *tempImgView = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:Patient_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                tempImgView.image = Patient_DEFAULT_HEADIMAGE;
            }
            else
            {
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    BOOL isExist = NO;
                    NSString *iconPath = [DocumentUtil getPatientHeadAvatarByPatientId:patientId isExist:&isExist];
                    if (isExist)
                    {
                        [Photo unloadImageForKey:iconPath];
                        
                    }
                    
                });
                
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [tempImgView setImage:tmpImage];
                
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    [DocumentUtil savePatientAvatar:image withPatientId:patientId];
                });
                
                
                
            }
            
        }];
    }
}


//病例中的图片
- (void)setCaseRecordImageWithRecordPictureId:(NSString *)pictureId pictureUrl:(NSString *)urlString
{
    
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    BOOL isExist = NO;
    NSString *picturePath = [DocumentUtil getCaseRecordPictureWithImageUrl:urlNoExtension isExist:&isExist];
    if (isExist)
    {
        self.image = [Photo loadImageThreadSafe:picturePath];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = CASE_RECORD_DEFAULT_HEADIMAGE;  //换图片
            return;
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_Record_ImageUrl placeholderImage:CASE_RECORD_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    tempImgView.image = CASE_RECORD_DEFAULT_HEADIMAGE;
                }
                else
                {
                    [tempImgView setImage:image];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveCaseRecordPicture:image withImageUrl:urlNoExtension];
                        
                        BOOL isExist = NO;
                        NSString *picturePath = [DocumentUtil getCaseRecordPictureWithImageUrl:urlNoExtension isExist:&isExist];
                        if (isExist)
                        {
                            [Photo unloadImageForKey:picturePath];
                        }
                        
                    });
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveCaseRecordOriginPicture:image withImageUrl:urlNoExtension];
                        
                        BOOL isExist = NO;
                        NSString *picturePath = [DocumentUtil getCaseRecordOriginPictureWithImageUrl:urlNoExtension isExist:&isExist];
                        if (isExist)
                        {
                            [Photo unloadImageForKey:picturePath];
                        }
                        
                    });
                    
                }

            }];

        }
    }
}



/**
 * 设置教育文章轮播大图
 */

-(void)setArtTitleNVODImageWithPictureUrl:(NSString *)urlString withSize:(CGFloat)size
{
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getArtTitleWithTitleIdPicByImageUrl:urlNoExtension isExist:&isExist];
    if (isExist)
    {
        self.image = [Photo loadImageThreadSafe:iconPath];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = ICON_BIG_DEFAUT_ART_IMAGE;   //后面要用一张方形默认图
            return;
        }
        else
        {
             __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_Art_ImageUrl placeholderImage:ICON_BIG_DEFAUT_ART_IMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [tempImgView setImage:ICON_BIG_DEFAUT_ART_IMAGE];
                }
                else
                {
                    [tempImgView setImage:image];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveArtTitleNVODPicture:image withImageUrl:urlNoExtension];
                        
                    });
                }
                
                
                
            }];

        }
    }
    
    
    
}


/**
 * 设置教育文章小图
 */

-(void)setArtTitleImageWithPictureUrl:(NSString *)urlString withSize:(CGFloat)size
{
    
    
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getArtTitleWithTitleIdPicByImageUrl:urlNoExtension isExist:&isExist];
    if (isExist)
    {
        self.image = [[Photo loadImageThreadSafe:iconPath]circleImageWithSize:size];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = ICON_DEFAUT_ART_IMAGE;
            return;
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_Art_ImageUrl placeholderImage:ICON_DEFAUT_ART_IMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [tempImgView setImage:ICON_DEFAUT_ART_IMAGE];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveArtTitlePicture:image withImageUrl:urlNoExtension];
                    });
                }

            }];
            
            
        }
    }
    
}




/**
 * 设置评论者-患者 - 图片
 */
-(void)setArtTitleWithPatientCommentUserId:(NSString *)commentUserId pictureUrl:(NSString *)urlString withSize:(CGFloat)size
{
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getPatientHeadAvatarByPatientId:commentUserId isExist:&isExist];
    if (isExist)
    {
        self.image = [[Photo loadImageThreadSafe:iconPath] circleImageWithSize:size];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = DEFAUT_Comment_Head_Image;
            return;
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:DEFAUT_Comment_Head_Image withBlock:^(UIImage *image, NSError *error) {
                if (error)
                {
                    [tempImgView setImage:DEFAUT_Comment_Head_Image];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil savePatientAvatar:image withPatientId:commentUserId];
                    });
                    
                    
                }
            }];
 
        }
        
    }
}


/**
 * 设置评论者-医生 - 图片
 */
-(void)setArtTitleWithDoctorCommentUserId:(NSString *)commentUserId pictureUrl:(NSString *)urlString withSize:(CGFloat)size
{
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:commentUserId isExist:&isExist];
    if (isExist)
    {
        UIImage *localImage = [Photo loadImageThreadSafe:iconPath];
        
        self.image = [localImage circleImageWithSize:size];
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = DEFAUT_Comment_Head_Image;
            return;
        }
        else
        {
            
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DEFAUT_Comment_Head_Image withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [tempImgView setImage:DEFAUT_Comment_Head_Image];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveDoctorAvatar:image withDoctorId:commentUserId];
                    });
                    
                }
            }];
        }
    }
}

/**
 * 设置集团图片 优先从本地获取
 */
-(void)setGroupAvatarFromLocalFileWithGroupId:(NSString *)groupId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];

    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getChannelOrGroupPicByChannelOrGroupImageUrl:urlNoExtension isExist:&isExist];
    if (isExist)
    {
        self.image = [[Photo loadImageThreadSafe:iconPath] circleImageWithSize:size];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = HX_GROUP_NROMAL_IMAG;
            return;
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_GROUP_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [tempImgView setImage:HX_GROUP_NROMAL_IMAG];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                         [DocumentUtil saveChannelOrGroupPicture:image withImageUrl:urlNoExtension];
                    });
                }
            }];
 
        }
    }
  
}

/**
 * 设置集团图片 从网络获取
 */
-(void)setGroupAvatarFromServerWithGroupId:(NSString *)groupId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    if ([NSString isBlankString:urlString])
    {
        self.image = HX_GROUP_NROMAL_IMAG;
        return;
    }
    else
    {
        __weak UIImageView *tempImgView = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_GROUP_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                [tempImgView setImage:HX_GROUP_NROMAL_IMAG];
            }
            else
            {
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [tempImgView setImage:tmpImage];
                
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    [DocumentUtil saveChannelOrGroupPicture:image withImageUrl:urlNoExtension];
                });
            }
        }];
        
    }
    
}


/**
 * 设置渠道图片 优先从本地获取
 */
-(void)setChannelAvatarFromLocalFileWithChannelId:(NSString *)channelId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getChannelOrGroupPicByChannelOrGroupImageUrl:urlNoExtension isExist:&isExist];
    if (isExist)
    {
        self.image = [[Photo loadImageThreadSafe:iconPath] circleImageWithSize:size];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = HX_CHANNEL_NROMAL_IMAG;
            return;
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_CHANNEL_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [tempImgView setImage:HX_CHANNEL_NROMAL_IMAG];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveChannelOrGroupPicture:image withImageUrl:urlNoExtension];
                    });
                }
            }];
            
        }
    }
}

/**
 * 设置渠道图片 从网络获取
 */
-(void)setChannelAvatarFromServerWithChannelId:(NSString *)channelId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    if ([NSString isBlankString:urlString])
    {
        self.image = HX_CHANNEL_NROMAL_IMAG;
        return;
    }
    else
    {
        __weak UIImageView *tempImgView = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_CHANNEL_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                [tempImgView setImage:HX_CHANNEL_NROMAL_IMAG];
            }
            else
            {
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [tempImgView setImage:tmpImage];
                
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    [DocumentUtil saveChannelOrGroupPicture:image withImageUrl:urlNoExtension];
                });
            }
        }];
        
    }
}


/**
 * 设置留言图片
 */
-(void)setLeaveMessageImageWithImageUrl:(NSString *)urlString
{
    NSString *urlNoExtension = [NSString urlWithNoExtension:urlString];
    
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getLeaveMessageThumbnailImageByImageUrl:urlNoExtension isExist:&isExist];
    if (isExist)
    {
        self.image = [Photo loadImageThreadSafe:iconPath];
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            self.image = HX_DEFAULT_LEAVE_MSG_IMAG;
            return;
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_LiuYanImageUrl placeholderImage:HX_DEFAULT_LEAVE_MSG_IMAG withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [tempImgView setImage:HX_DEFAULT_LEAVE_MSG_IMAG];
                }
                else
                {

                    [tempImgView setImage:image];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveLeaveMessageThumbnailImage:image imageUrl:urlNoExtension];

                    });
                }
            }];
            
        }
    }
    
}

@end
