//
//  UIButton+Avatar.m
//  BJXH-patient
//
//  Created by wu weili on 14-5-15.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "UIButton+Avatar.h"
#import "DocumentUtil.h"

#import "UIButton+AFNetworking.h"

#import "Photo.h"
#import "UIImage+IMChat.h"
#import "HXUserModel.h"
#import "AppDelegate.h"




@implementation UIButton (Avatar)

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
        imageThumbUrl = [NSString stringWithFormat:@"%@&%@",imageUrl,urlSuffix];//urlString;
    }
    
    NSURL *requestUrl = [NSURL URLWithString:[imageThumbUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    
    [self setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if (block)
        {
            block(image,nil);
        }
        
    } failure:^(NSError *error) {
        
        if (block)
        {
            block(nil,error);
        }
        
    }];
}



/**
 * 优先从本地加载
 */
-(void)setDoctorAvatarFromLocalFileWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
    if (isExist)
    {
        UIImage *btnImage = [Photo loadImageThreadSafe:iconPath];
        
        [self setImage:[btnImage circleImageWithSize:size] forState:UIControlStateNormal];
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            [self setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
            return;
        }
        else
        {
             __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [weakSelf setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                    
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
        
        [self setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
        
        return;
    }
    else
    {
        
        if ([NSString isBlankString:urlString])
        {
            [self setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
            return;
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [weakSelf setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];

                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        BOOL isExist = NO;
                        NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
                        if (isExist)
                        {
                            [Photo unloadImageForKey:iconPath];
                            
                        }
                    });
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];
                    });
                    
                }
                
            }];
  
        }
   
    }
}


/**
 * 首页医生 默认图不一样 优先从本地加载
 */
-(void)setFirstPageDoctorAvatarFromLocalFileWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size
{
    BOOL isExist = NO;
    NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
    if (isExist)
    {
        UIImage *btnImage = [Photo loadImageThreadSafe:iconPath];
        
        [self setImage:[btnImage circleImageWithSize:size] forState:UIControlStateNormal];
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            [self setImage:FIRST_PAGE_DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
            return;
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:FIRST_PAGE_DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [weakSelf setImage:FIRST_PAGE_DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];
                    });
                    
                }
                
                
            }];
            
            
        }
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
        UIImage *btnImage = [Photo loadImageThreadSafe:iconPath];
        
        [self setImage:[btnImage circleImageWithSize:size] forState:UIControlStateNormal];
 
        return;
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            [self setImage:Patient_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
            
            return;
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:Patient_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [weakSelf setImage:Patient_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                    
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
        [self setImage:Patient_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
        
        return;
    }
    else
    {
        __weak __typeof(self)weakSelf = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:Patient_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                [weakSelf setImage:Patient_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
            }
            else
            {
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [weakSelf setImage:tmpImage forState:UIControlStateNormal];

                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    BOOL isExist = NO;
                    NSString *iconPath = [DocumentUtil getPatientHeadAvatarByPatientId:patientId isExist:&isExist];
                    if (isExist)
                    {
                        [Photo unloadImageForKey:iconPath];
                        
                    }
                });
                
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
    NSString *picturePath = [DocumentUtil getCaseRecordPictureWithImageUrl:urlNoExtension  isExist:&isExist];
    if (isExist)
    {
        UIImage *btnImage = [Photo loadImageThreadSafe:picturePath];
        
        [self setImage:btnImage forState:UIControlStateNormal];
        return;
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            
            [self setImage:CASE_RECORD_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
            return;
            
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_Record_ImageUrl placeholderImage:CASE_RECORD_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [weakSelf setImage:CASE_RECORD_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
                }
                else
                {
                    [weakSelf setImage:image forState:UIControlStateNormal];
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        BOOL isExist = NO;
                        NSString *iconPath = [DocumentUtil getCaseRecordPictureWithImageUrl:urlNoExtension isExist:&isExist];
                        if (isExist)
                        {
                            [Photo unloadImageForKey:iconPath];
                        }
                        
                        [DocumentUtil saveCaseRecordPicture:image withImageUrl:urlNoExtension];
                    });
                    
                    
                    
                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                        
                        BOOL isExist = NO;
                        NSString *iconPath = [DocumentUtil getCaseRecordOriginPictureWithImageUrl:urlNoExtension isExist:&isExist];
                        if (isExist)
                        {
                            [Photo unloadImageForKey:iconPath];
                        }
                        
                        [DocumentUtil saveCaseRecordOriginPicture:image withImageUrl:urlNoExtension];
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
         UIImage *btnImage = [Photo loadImageThreadSafe:iconPath];
        
        [self setImage:[btnImage circleImageWithSize:size] forState:UIControlStateNormal];
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            [self setImage:HX_GROUP_NROMAL_IMAG  forState:UIControlStateNormal];
            
           
            return;
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_GROUP_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [self setImage:HX_GROUP_NROMAL_IMAG  forState:UIControlStateNormal];
                    
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                     [weakSelf setImage:tmpImage forState:UIControlStateNormal];
 
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
        [self setImage:HX_GROUP_NROMAL_IMAG  forState:UIControlStateNormal];
        return;
    }
    else
    {
         __weak __typeof(self)weakSelf = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_GROUP_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                [self setImage:HX_GROUP_NROMAL_IMAG  forState:UIControlStateNormal];
            }
            else
            {
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [weakSelf setImage:tmpImage forState:UIControlStateNormal];

                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    BOOL isExist = NO;
                    NSString *iconPath = [DocumentUtil getChannelOrGroupPicByChannelOrGroupImageUrl:urlNoExtension isExist:&isExist];
                    if (isExist)
                    {
                        [Photo unloadImageForKey:iconPath];
                        
                    }
                });
                
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
        UIImage *btnImage = [Photo loadImageThreadSafe:iconPath];
        
        [self setImage:[btnImage circleImageWithSize:size] forState:UIControlStateNormal];
        
    }
    else
    {
        if ([NSString isBlankString:urlString])
        {
            [self setImage:HX_CHANNEL_NROMAL_IMAG  forState:UIControlStateNormal];
            
            return;
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_CHANNEL_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                     [self setImage:HX_CHANNEL_NROMAL_IMAG  forState:UIControlStateNormal];
                    
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                    
                    
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
        [self setImage:HX_CHANNEL_NROMAL_IMAG  forState:UIControlStateNormal];
        return;
    }
    else
    {
         __weak __typeof(self)weakSelf = self;
        
        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_PatientImageUrl placeholderImage:HX_CHANNEL_NROMAL_IMAG withBlock:^(UIImage *image, NSError *error) {
            
            if (error)
            {
                [self setImage:HX_CHANNEL_NROMAL_IMAG  forState:UIControlStateNormal];
            }
            else
            {
                UIImage *tmpImage = [image circleImageWithSize:size];
                
                [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    BOOL isExist = NO;
                    NSString *iconPath = [DocumentUtil getChannelOrGroupPicByChannelOrGroupImageUrl:urlNoExtension isExist:&isExist];
                    if (isExist)
                    {
                        [Photo unloadImageForKey:iconPath];
                        
                    }
                });
                
                
                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
                    
                    [DocumentUtil saveChannelOrGroupPicture:image withImageUrl:urlNoExtension];
                });
            }
        }];
        
    }
}


@end
