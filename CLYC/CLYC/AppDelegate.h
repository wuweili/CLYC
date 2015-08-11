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
#import "GeTuiSdk.h"


#define HXAPPDELEGATE   ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *rootNavController;

@property (strong, nonatomic) HXBackgroundViewController *backgroundViewController;


@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *appID;
@property (strong, nonatomic) NSString *clientId;
@property (assign, nonatomic) SdkStatus sdkStatus;

@property (assign, nonatomic) int lastPayloadIndex;
@property (strong, nonatomic) NSString *payloadId;
@property(nonatomic,strong) NSString *deviceToken;



- (void)goToMainView;

-(void)logOut;

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret;
@end

