//
//  HttpResponseModel.m
//  CLYC
//
//  Created by wuweiqing on 15/7/5.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HttpResponseModel.h"

@implementation HttpResponseModel

@end


@implementation SelectCarInfoModel

-(id)init
{
    self = [super init];
    
    if ( self)
    {
        self.carId = @"";
        self.carCode = @"";
        
        self.carModelId = @"";
        self.carModel = @"";
        self.driverId = @"";
        self.driver = @"";
        self.driverTel = @"";
        self.carType = @"";
        self.price = @"";
    }
    
    return self;
}


@end


@implementation DeptListModel

-(id)init
{
    self = [super init];
    
    if ( self)
    {
        self.deptId = @"";
        self.deptName = @"";
    }
    
    return self;
}

@end


@implementation ProjectListModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.projectId = @"";
        self.projectName = @"";
        self.projectNo = @"";
    }
    
    return self;
}

@end


@implementation ApplyCarDetailModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.appId = @"";
        self.deptModel = [[DeptListModel alloc] init];
        self.projectModel = [[ProjectListModel alloc]init];
        self.selectedCarModel = [[SelectCarInfoModel alloc]init];
        self.beginAdrr = @"";
        self.endAdrr = @"";
        self.beginTime = @"";
        self.endTime = @"";
        self.carAppUserName = @"";
        self.carAppUserId = @"";
        self.carAppUserTel = @"";
        self.carUse = @"";
        self.status = @"";
        self.appTime = @"";
        self.appUserId = @"";
        self.applyDeptModel =[[DeptListModel alloc] init];
        self.driver = @"";
        self.driverTel = @"";
        self.totalMil = @"";
        self.beginMil = @"";
        self.beginMilStatus = @"";
        self.beginMilRemark = @"";
        self.finishMil = @"";
        self.addMil = @"";
        self.finishMilStatus = @"";
        self.finishMilRemark = @"";
        self.price = @"";
        self.driverTravelDays = @"";
        self.systemTime = @"";
        self.cost = @"";
    }
    
    return self;
}

@end


@implementation TrajectoryListModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.receiveTime = @"";
        self.latitude = @"";
        self.longitude = @"";
        self.direction = @"";
        
    }
    
    return self;
}

@end

@implementation ComplainListModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self._id = @"";
        self.createPersonName = @"";
        self.createPersonTel = @"";
        self.status = @"";
        
        self.statusName = @"";
        self.createTime = @"";
        self.complaintContent = @"";
        self.createPersonId = @"";
        self.handelResults = @"";
        self.handelPersonId = @"";
        self.handelPersonName = @"";
        self.handelTime = @"";
        
    }
    
    return self;
}

@end

@implementation DriverCheckModel

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self._id = @"";
        self.driverId = @"";
        self.driverName = @"";
        self.checkTime = @"";
        self.gradeName = @"";
    }
    
    return self;
}

@end

