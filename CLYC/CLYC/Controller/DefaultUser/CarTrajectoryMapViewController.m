//
//  CarTrajectoryMapViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CarTrajectoryMapViewController.h"

@interface CarTrajectoryMapViewController ()
{
     ApplyCarDetailModel *_applyCarModel;
    
     NSMutableArray *_dataArray;
}

/** 位置数组 */
@property (nonatomic, strong) NSMutableArray *locationArrayM;


@property (nonatomic, strong) BMKPolyline *polyLine;
@end

@implementation CarTrajectoryMapViewController

-(id)initWithApplyCarDetailModel:(ApplyCarDetailModel *)model;
{
    self = [super init];
    
    if (self)
    {
        _applyCarModel = model;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"车辆轨迹";
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.locationArrayM = [NSMutableArray arrayWithCapacity:0];
    
    
    
    
    
    
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    // 设置MapView的一些属性
    [self setMapViewProperty];
    
    [self.view addSubview:self.mapView];
    
    
    

    [self obtainData];
   
}

/**
 *  设置 百度MapView的一些属性
 */
- (void)setMapViewProperty
{
    // 显示定位图层
    self.mapView.showsUserLocation = YES;
    
    // 设置定位模式
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    // 允许旋转地图
    self.mapView.rotateEnabled = YES;
    
    // 显示比例尺
    self.mapView.showMapScaleBar = YES;
    
    
    self.mapView.zoomEnabled = YES;
    self.mapView.mapScaleBarPosition = CGPointMake( 20, self.view.frame.size.height - 100);
    
    // 定位图层自定义样式参数
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = NO;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = YES;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [self.mapView updateLocationViewWithParam:displayParam];
}



-(NSString *)getyyyyMMddWithTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *timeStrDate = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *resultString = [formatter stringFromDate:timeStrDate];
    return resultString;
    
}

-(void)obtainData
{
    if (![NSString isBlankString:_applyCarModel.appId])
    {
        
        NSArray *keyArray = @[@"applyId",@"queryTime"];
        
        NSString *beginTime = [self getyyyyMMddWithTimeStr:_applyCarModel.beginTime];
        
        
        NSArray *valueArray = @[_applyCarModel.appId,beginTime];
        
        [CLYCCoreBizHttpRequest carTrajectoryWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error) {
            
            if ([retcode isEqualToString:YB_HTTP_CODE_OK])
            {
                [_dataArray addObjectsFromArray:listArry];
                
                [self dealDataArray];
            }
            else
            {
                
            }
            
        } keyArray:keyArray valueArray:valueArray];
        
        
    }
}

-(void)dealDataArray
{
    if ([_dataArray count]>0)
    {
        TrajectoryListModel *model0 = [_dataArray firstObject];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[model0.latitude doubleValue] longitude:[model0.longitude doubleValue]];
        // 设置当前地图的显示范围，直接显示到用户位置
        BMKCoordinateRegion adjustRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(location.coordinate, BMKCoordinateSpanMake(0.2f,0.2f))];
        
        //BMKCoordinateSpanMake(0.2f,0.2f)  调整比例尺
        
        
        [self.mapView setRegion:adjustRegion animated:YES];
        
        [self.locationArrayM addObject:location];
        
        for (int i = 1; i<[_dataArray count]; i++)
        {
            TrajectoryListModel *modeli = [_dataArray objectAtIndex:i];
            
            CLLocation *locationi = [[CLLocation alloc] initWithLatitude:[modeli.latitude doubleValue] longitude:[modeli.longitude doubleValue]];
            [self.locationArrayM addObject:locationi];
            
        }
        
        [self drawWalkPolyline];
       
    }
}


/**
 *  绘制轨迹路线
 */
- (void)drawWalkPolyline
{
    
    
    NSInteger pointCount = [self.locationArrayM count];
    
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i)
    {
        CLLocation *location = [self.locationArrayM objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
    }
    
    self.polyLine = [BMKPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    [self.mapView addOverlay:self.polyLine];
    
    free(coordinateArray);
    coordinateArray = NULL;
    
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 5.0;
        
        return polylineView;
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
