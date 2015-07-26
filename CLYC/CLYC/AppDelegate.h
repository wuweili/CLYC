//
//  AppDelegate.h
//  CLYC
//
//  Created by weili.wu on 15/5/18.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBackgroundViewController.h"
#import <BaiduMapAPI/BMapKit.h>


#define HXAPPDELEGATE   ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *rootNavController;

@property (strong, nonatomic) HXBackgroundViewController *backgroundViewController;


- (void)goToMainView;

-(void)logOut;
@end

