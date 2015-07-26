//
//  CLYCLocationManager.h
//  CLYC
//
//  Created by weili.wu on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI/BMapKit.h>



@interface CLYCLocationManager : NSObject<BMKLocationServiceDelegate>

@property(nonatomic,strong)BMKLocationService *locService;

+(CLYCLocationManager *)shareInstance;

-(void)startLocation;

@end
