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
        self.carUse = @"";
        self.status = @"";
        self.appTime = @"";
        self.appUserId = @"";
        self.appDeptId = @"";
        self.driver = @"";
        self.driverTel = @"";
        self.totalMil = @"";
        
        
    }
    
    return self;
}

@end






