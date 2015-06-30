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
            [self setImage:nil forState:UIControlStateNormal];
            return;
        }
        else
        {
             __weak __typeof(self)weakSelf = self;
            
            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:@"" placeholderImage:nil withBlock:^(UIImage *image, NSError *error) {
                
                if (error)
                {
                    [weakSelf setImage:nil forState:UIControlStateNormal];
                }
                else
                {
                    UIImage *tmpImage = [image circleImageWithSize:size];
                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
                    
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
//    if ([NSString isBlankString:urlString])
//    {
//        
//        [self setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
//        
//        return;
//    }
//    else
//    {
//        
//        if ([NSString isBlankString:urlString])
//        {
//            [self setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
//            return;
//        }
//        else
//        {
//            __weak __typeof(self)weakSelf = self;
//            
//            [self baseRequestWithImageUrl:urlString commonDownloadPathUrl:API_DoctorImageUrl placeholderImage:DOCTOR_DEFAULT_HEADIMAGE withBlock:^(UIImage *image, NSError *error) {
//                
//                if (error)
//                {
//                    [weakSelf setImage:DOCTOR_DEFAULT_HEADIMAGE forState:UIControlStateNormal];
//                }
//                else
//                {
//                    UIImage *tmpImage = [image circleImageWithSize:size];
//                    [weakSelf setImage:tmpImage forState:UIControlStateNormal];
//
//                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
//                        
//                        BOOL isExist = NO;
//                        NSString *iconPath = [DocumentUtil getDoctorHeadAvatarByDoctorId:doctorId isExist:&isExist];
//                        if (isExist)
//                        {
//                            [Photo unloadImageForKey:iconPath];
//                            
//                        }
//                    });
//                    
//                    dispatch_async(HXAPPDELEGATE.storageFileQuene, ^{
//                        
//                        [DocumentUtil saveDoctorAvatar:image withDoctorId:doctorId];
//                    });
//                    
//                }
//                
//            }];
//  
//        }
//   
//    }
//}




@end
