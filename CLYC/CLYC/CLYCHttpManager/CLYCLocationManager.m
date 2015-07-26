//
//  CLYCLocationManager.m
//  CLYC
//
//  Created by weili.wu on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CLYCLocationManager.h"

@implementation CLYCLocationManager


static CLYCLocationManager *instance = nil;

+(CLYCLocationManager *)shareInstance
{
    
    @synchronized(self)
    {
        if (nil == instance)
        {
            instance = [[CLYCLocationManager alloc] init];
            
            [NSTimer scheduledTimerWithTimeInterval:180 target:instance selector:@selector(startLocation) userInfo:nil repeats:YES];
            
        }
    }
    return instance;
}


+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (instance == nil)
        {
            instance = [super allocWithZone:zone];
            return  instance;
        }
    }
    return nil;
}

-(void)startLocation
{

    if (![CLLocationManager locationServicesEnabled])
    {
        DDLogInfo(@"定位服务当前可能尚未打开，请设置打开！");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"定位服务当前可能尚未打开，请设置打开！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        [BMKLocationService setLocationDistanceFilter:100.f];
        
        //初始化BMKLocationService
        
        if (!_locService)
        {
            _locService = [[BMKLocationService alloc]init];
        }
        
        
        _locService.delegate = [CLYCLocationManager shareInstance];
        //启动LocationService
        [_locService startUserLocationService];
    });
  
}


-(void)stopLocation
{
    [_locService stopUserLocationService];
    
    
    
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    
    DDLogInfo(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];
    
    
    DDLogInfo(@"didUpdateUserLocation lat %f,long %f course = %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude,userLocation.location.course);
    
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}




@end
