//
//  CarTrajectoryMapViewController.h
//  CLYC
//
//  Created by weili.wu on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXBJHXBaseViewController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface CarTrajectoryMapViewController : HXBJHXBaseViewController<BMKMapViewDelegate>
{
    
}

@property(nonatomic,strong)BMKMapView* mapView;

-(id)initWithApplyCarDetailModel:(ApplyCarDetailModel *)model;

@end
