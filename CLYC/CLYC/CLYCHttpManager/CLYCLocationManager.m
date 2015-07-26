//
//  CLYCLocationManager.m
//  CLYC
//
//  Created by weili.wu on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CLYCLocationManager.h"
#import "DateFormate.h"

@interface CLYCLocationManager ()
{
    NSTimer * _startLocationTimer;
}

@end


@implementation CLYCLocationManager


static CLYCLocationManager *instance = nil;

+(CLYCLocationManager *)shareInstance
{
    
    @synchronized(self)
    {
        if (nil == instance)
        {
            instance = [[CLYCLocationManager alloc] init];
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

-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
    
    
}

-(void)stopLocationTimer
{
    if (_startLocationTimer)
    {
        [_startLocationTimer invalidate];
        _startLocationTimer = nil;
    }
    
    [_locService stopUserLocationService];
}


-(void)startLocation
{
    if (!_startLocationTimer)
    {
        _startLocationTimer = [NSTimer timerWithTimeInterval:180
                                                      target:self
                                                    selector:@selector(startLocation)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_startLocationTimer forMode:NSRunLoopCommonModes];
    }
    

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
    
    NSString *carAppId = [[NSUserDefaults standardUserDefaults] objectForKey:CY_APPCAR_ID];
    
    if (![NSString isBlankString:carAppId])
    {

        
        NSString *latitude = [NSString getFormatStr:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude]];
        
        NSString *longitude = [NSString getFormatStr:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
        
        NSString *course = [NSString getFormatStr:[NSString stringWithFormat:@"%f",userLocation.location.course]];
        
        NSString *recieveTime = [DateFormate NSStringLocationDateToString:userLocation.location.timestamp];
   
        NSArray *keyArray = @[@"applyId",@"receiveTime",@"latitude",@"longitude",@"direction"];
        
        NSArray *valueArray = @[carAppId,recieveTime,latitude,longitude,course];
        
        [CLYCCoreBizHttpRequest driverUploadGPSWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
            
            if ([retcode isEqualToString:YB_HTTP_CODE_OK])
            {
                DDLogInfo(@"上传GPS成功");
            }
            else
            {
                DDLogInfo(@"上传GPS失败");
            }
            
            
            
            
        } keyArray:keyArray valueArray:valueArray ];
    }

    DDLogInfo(@"didUpdateUserLocation lat %f,long %f course = %f timestamp = %@",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude,userLocation.location.course,userLocation.location.timestamp);
}




@end
