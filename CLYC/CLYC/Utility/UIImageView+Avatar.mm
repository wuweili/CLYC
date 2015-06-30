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
            
            self.image =nil; //DOCTOR_DEFAULT_HEADIMAGE;
            
            return;
            
        }
        else
        {
            __weak UIImageView *tempImgView = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:@"" placeholderImage:nil withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    tempImgView.image = nil;//DOCTOR_DEFAULT_HEADIMAGE;
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    
                    [tempImgView setImage:tmpImage];
                    
                    [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];


 
                    
                }

            }];
        }
  
    }
  
}


/**
 * 从网络获取最新头像
 */
//-(void)setDoctorAvatarFromServerWithDoctorId:(NSString *)doctorId headUrl:(NSString *)urlString withSize:(CGFloat)size
//{
//    
//    
//    if ([NSString isBlankString:urlString])
//    {
//        
//        self.image = DOCTOR_DEFAULT_HEADIMAGE;
//        
//        return;
//        
//    }
//    else
//    {
//        
//        __weak UIImageView *tempImgView = self;
//        
//        [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
//            
//            if (error)
//            {
//                tempImgView.image = DOCTOR_DEFAULT_HEADIMAGE;
//            }
//            else
//            {
//
//                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
//                    
//                    BOOL isExist = NO;
//                    NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
//                    if (isExist)
//                    {
//                        [Photo unloadImageForKey:iconPath];
//                        
//                    }
//                });
//                
//                
//                UIImage *tmpImage = [image circleImageWithSize:size];
//                
//                [tempImgView setImage:tmpImage];
//                
//                
//                dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
//                    
//                    [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];
//                });
//                
//               
//            }
//            
//        }];
//    }
//}




@end
