//
//  CarTrajectoryMapViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CarTrajectoryMapViewController.h"
#import "DateFormate.h"

@interface CarTrajectoryMapViewController ()
{
    ApplyCarDetailModel *_applyCarModel;
    
    NSMutableDictionary *_dataArrayDic;
    
    UIToolbar *_toolbar;
    
    UIBarButtonItem *_previousButton, *_nextButton ,*_middleTitleButton;
    
    NSMutableArray *_searchTimeArray;
    
    NSInteger _currentTimeIndex;
    
    NSString *_currentQueryTime;
    
    
    
}


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
    
    _currentTimeIndex = 0;
    
    _currentQueryTime = [self getyyyyMMddWithTimeStr:_applyCarModel.beginTime];
    
    _dataArrayDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    _searchTimeArray = [NSMutableArray arrayWithCapacity:0];
    
//    self.locationArrayM = [NSMutableArray arrayWithCapacity:0];
    
    
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    // 设置MapView的一些属性
    [self setMapViewProperty];
    
    [self.view addSubview:self.mapView];
    
    [self initToorbar];

    [self getTimeSep];
    
    [self obtainDataWithIndex:_currentTimeIndex];
}

-(void)getTimeSep
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger numberOfDays = [DateFormate getResidualDaysWithEndTimeStr:_applyCarModel.endTime systemNowTimeStr:_applyCarModel.beginTime];
        
        NSString *beginTime = [self getyyyyMMddWithTimeStr:_applyCarModel.beginTime];
        
        [_searchTimeArray addObject:beginTime];
        
        if (numberOfDays+1 > 0)
        {
            for (int i = 1 ; i< numberOfDays+1;i++ )
            {
                NSString *timeStr = [DateFormate getOtherDaysWithDays:i beginTime:beginTime];
                [_searchTimeArray addObject:timeStr];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新UI
            if ([_searchTimeArray count]>1)
            {
                [self showToorBar];
            }
        });
    });
    
    
}



- (CGRect)frameForToolbarAtOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat height = 49;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
        UIInterfaceOrientationIsLandscape(orientation)) height = 32;
    
    return CGRectIntegral(CGRectMake(0, self.view.bounds.size.height - height, kMainScreenWidth, height));
}

-(void)initToorbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:[self frameForToolbarAtOrientation:self.interfaceOrientation]];
    
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    _toolbar.barStyle = UIBarStyleDefault;

    _toolbar.backgroundColor = [UIColor blackColor];
    
    _toolbar.tintColor = [UIColor whiteColor];
    
    UIImage *leftImage;
    UIImage *rightImage;
    
    if (CurrentSystemVersion>=7.0)
    {
        
        leftImage = HX_SEE_CASE_PIC_LEFT_7_IMAG;
        rightImage = HX_SEE_CASE_PIC_RIGHT_7_IMAG;
        
    }
    else
    {
        leftImage = HX_SEE_CASE_PIC_LEFT_6_IMAG;
        rightImage = HX_SEE_CASE_PIC_RIGHT_6_IMAG;
        
    }

    leftImage = HX_SEE_CASE_PIC_LEFT_6_IMAG;
    rightImage = HX_SEE_CASE_PIC_RIGHT_6_IMAG;
    
    _previousButton = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(gotoPreviousPage)];
    _previousButton.enabled = NO;
    _nextButton = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(gotoNextPage)];
    
    _middleTitleButton = [[UIBarButtonItem alloc]initWithTitle:_currentQueryTime style:UIBarButtonItemStylePlain target:nil action:nil];
    _middleTitleButton.tintColor = [UIColor redColor];

    // Toolbar items
    UIBarButtonItem *fixedLeftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedLeftSpace.width = 32; // To balance action button
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    [items addObject:_previousButton];
    
    [items addObject:flexSpace];
    
    [items addObject:_middleTitleButton];
    
    [items addObject:flexSpace];
    
    [items addObject:_nextButton];
    
    
    [_toolbar setItems:items];
    
    _toolbar.alpha = 0.5;
    
    _toolbar.hidden = YES;
    
    [self.view addSubview:_toolbar];
}


-(void)showToorBar
{
    [UIView animateWithDuration:0.35 animations:^{
        
        _toolbar.hidden = NO;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideToorBar
{
    
}

- (void)gotoPreviousPage
{
    if (_currentTimeIndex ==0)
    {
        
    }
    else
    {
        _currentTimeIndex --;
        
        [self updateNavigation];
        
        [self obtainDataWithIndex:_currentTimeIndex];
    }
}
- (void)gotoNextPage
{
    if (_currentTimeIndex >= [_searchTimeArray count])
    {
        
    }
    else
    {
        _currentTimeIndex ++;
        
        [self updateNavigation];
        
        [self obtainDataWithIndex:_currentTimeIndex];
    }
}

- (void)updateNavigation
{
    if ([_searchTimeArray count]>1)
    {
        self.title = [NSString stringWithFormat:@"%li / %lu",(long)_currentTimeIndex+1,(unsigned long)[_searchTimeArray count] ];
        
        _middleTitleButton.title = [_searchTimeArray objectAtIndex:_currentTimeIndex];
    }
    else
    {
        self.title = [_searchTimeArray firstObject];
    }
    
    
    
    _previousButton.enabled = (_currentTimeIndex > 0);
    _nextButton.enabled = (_currentTimeIndex < [_searchTimeArray count]-1);
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
    
    if (resultString == nil)
    {
        resultString = @"";
    }
    
    return resultString;
    
}

-(void)obtainDataWithIndex:(NSInteger )index
{
    if (![NSString isBlankString:_applyCarModel.appId])
    {
        if ([_searchTimeArray count]>0 && index<[_searchTimeArray count])
        {
            _currentQueryTime = [_searchTimeArray objectAtIndex:index];
        }
        
        NSArray *queryTimeValue = [_dataArrayDic objectForKey:_currentQueryTime];
        
        if (queryTimeValue && [queryTimeValue count]>0)
        {
            [self drawWalkPolylineWithCLLocationArray:queryTimeValue];
        }
        else
        {
            NSArray *keyArray = @[@"applyId",@"queryTime"];
            
            NSArray *valueArray = @[_applyCarModel.appId,_currentQueryTime];
            
            [CLYCCoreBizHttpRequest carTrajectoryWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error) {
                if ([retcode isEqualToString:YB_HTTP_CODE_OK])
                {
                    [self dealDataArrayWithArray:listArry];
                }
                else
                {
                    
                }
            } keyArray:keyArray valueArray:valueArray];
        }
    }
}

-(void)dealDataArrayWithArray:(NSArray *)array
{
    if ([array count]>0)
    {
        TrajectoryListModel *model0 = [array firstObject];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[model0.latitude doubleValue] longitude:[model0.longitude doubleValue]];
        // 设置当前地图的显示范围，直接显示到用户位置
        BMKCoordinateRegion adjustRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(location.coordinate, BMKCoordinateSpanMake(0.2f,0.2f))];
        
        //BMKCoordinateSpanMake(0.2f,0.2f)  调整比例尺
        
        [self.mapView setRegion:adjustRegion animated:YES];
        
        NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
        
        
        [mutabArray addObject:location];
        
        for (int i = 1; i<[array count]; i++)
        {
            TrajectoryListModel *modeli = [array objectAtIndex:i];
            
            CLLocation *locationi = [[CLLocation alloc] initWithLatitude:[modeli.latitude doubleValue] longitude:[modeli.longitude doubleValue]];
            [mutabArray addObject:locationi];
        }
        
        [_dataArrayDic setObject:mutabArray forKey:_currentQueryTime];
        
        [self drawWalkPolylineWithCLLocationArray:mutabArray];
       
    }
}


/**
 *  绘制轨迹路线
 */
- (void)drawWalkPolylineWithCLLocationArray:(NSArray *)array
{
    NSInteger pointCount = [array count];
    
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i)
    {
        CLLocation *location = [array objectAtIndex:i];
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
