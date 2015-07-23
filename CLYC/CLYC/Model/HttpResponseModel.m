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

@implementation ApplyCarListModel



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








