//
//  HXUserModel.m
//  CLYC
//
//  Created by weili.wu on 15/6/28.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXUserModel.h"

@implementation HXUserModel

static HXUserModel *instance = nil;

+(HXUserModel *)shareInstance
{
    
    @synchronized(self)
    {
        if (nil == instance)
        {
            instance = [[HXUserModel alloc] init];
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
    if (self = [super init])
    {
        
        self.userId = @"";
        
        self.loginId = @"";
        
        self.userName = @"";
        
        self.sex = @"";
        
        self.email = @"";
        
        self.telphone = @"";
        
        self.roleNo = @"";
        
        self.deptId = @"";
        
        self.deptName = @"";
        
        self.password = @"";
   
    }
    return self;
}


@end
