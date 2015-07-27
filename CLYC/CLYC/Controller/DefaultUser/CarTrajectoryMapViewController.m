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
    
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = _mapView;
    
    [self obtainData];
    
    
    
}

-(void)obtainData
{
    if (![NSString isBlankString:_applyCarModel.appId])
    {
        
        NSArray *keyArray = @[@"applyId",@"queryTime"];
        
        NSArray *valueArray = @[_applyCarModel.appId,@""];
        
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
        
        for (int i = 0; i<[_dataArray count]; i++)
        {
            if (i+1>=[_dataArray count])
            {
                return;
            }
            
            TrajectoryListModel *model0 = [_dataArray objectAtIndex:i];
            
            TrajectoryListModel *model1 = [_dataArray objectAtIndex:i+1];
            
            CLLocationCoordinate2D coors[2] = {0};
            
            coors[0].latitude = [model0.latitude doubleValue];
            coors[0].longitude = [model0.longitude doubleValue];
            coors[1].latitude = [model1.latitude doubleValue];;
            coors[1].longitude = [model1.longitude doubleValue];
            
            BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
            [_mapView addOverlay:polyline];
            
        }
       
    }
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
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
