//
//  AppDelegate.m
//  CLYC
//
//  Created by weili.wu on 15/5/18.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "AppDelegate.h"
#import "MyKeyChainHelper.h"
#import "HXRootViewViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "CLYCLocationManager.h"

BMKMapManager* _mapManager;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiDuMap_AK generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [self initGlobalSettings];
    
    if ([self isNeedLogin])
    {
        [self goToLoginView];
    }
    else
    {
        [self goToLoginViewToDirectLogin];
    }
    
    
    
    
    return YES;
}




/**
 *	log启用，内存显示等全局设置
 */
- (void)initGlobalSettings
{
    
#ifdef YB_HTTP_IDP_SERVER_LOACL_DEBUG
    
    [Log logOpen];
    
#endif
  
    
}

-(void)monitorNetWork
{
    [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus = AFNetworkReachabilityStatusReachableViaWiFi;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                DDLogInfo(@"monitorNetWork 网络 AFNetworkReachabilityStatusUnknown");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                DDLogInfo(@"monitorNetWork 网络 AFNetworkReachabilityStatusNotReachable");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                DDLogInfo(@"monitorNetWork 网络 AFNetworkReachabilityStatusReachableViaWWAN");
                
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                DDLogInfo(@"monitorNetWork 网络 AFNetworkReachabilityStatusReachableViaWiFi");
                
                
            }
                break;
                
            default:
                break;
        }
    }];
    
}


#pragma mark - 判断是否需要登陆
- (BOOL)isNeedLogin
{
    
    NSString *userLoginId = [MyKeyChainHelper getUserNameWithService:KEY_USERNAME];
    NSString *password = [MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];
    
    if ([NSString isBlankString:userLoginId] || [NSString isBlankString:password])
    {
        
        return YES;
    }
    
    [HXUserModel shareInstance].loginId=userLoginId;
    [HXUserModel shareInstance].password=password;
    
    return NO;
}

#pragma mark - 跳转到登陆界面
- (void)goToLoginView
{
    _backgroundViewController = nil;
    self.window.rootViewController = nil;
    
    if (!self.rootNavController)
    {
        HXRootViewViewController *loginMVC  = [[HXRootViewViewController alloc]initWithDirectLogin:NO];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginMVC];
        self.rootNavController = navController;
        
        self.window.rootViewController = self.rootNavController;
        
    }
    else
    {
        if (![self.rootNavController.topViewController isKindOfClass:[HXRootViewViewController class]])
        {
            self.window.rootViewController = self.rootNavController;
            
            [self.rootNavController popToRootViewControllerAnimated:YES];
            
        }
        else
        {
            self.window.rootViewController = self.rootNavController;
        }
    }
    
}

#pragma mark - 跳转到主界面
- (void)goToMainView
{
    if (IS_DefaultUser)
    {
        if(CurrentSystemVersion >= 7.0)
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }
        else
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
        }
        
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x4fc1e9)];
        
        if (CurrentSystemVersion>=8.0)
        {
            [UINavigationBar appearance].translucent = NO;
        }
    }
    else
    {
        if(CurrentSystemVersion >= 7.0)
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }
        else
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
        }
        
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x4fc1e9)];
        
//        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x69d25c)];
        
        if (CurrentSystemVersion>=8.0)
        {
            [UINavigationBar appearance].translucent = NO;
        }
    }
    
    
    
    if (!_backgroundViewController)
    {
        _backgroundViewController = [[HXBackgroundViewController alloc]init];
    }
    
    self.window.rootViewController = _backgroundViewController;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *array = self.rootNavController.viewControllers;
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
        
        [resultArray addObject:[array firstObject]];
        
        [self.rootNavController setViewControllers:resultArray animated:NO];
        
    });
}

#pragma mark - 跳转到登陆界面且直接登录
-(void)goToLoginViewToDirectLogin
{
    _backgroundViewController = nil;
    
    self.window.rootViewController = nil;
    
    if (!self.rootNavController)
    {
        HXRootViewViewController *loginMVC  =[[HXRootViewViewController alloc]initWithDirectLogin:YES];
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginMVC];
        
        self.rootNavController = navController;
        
        self.window.rootViewController = self.rootNavController;
    }
    else
    {
        if (![self.rootNavController.topViewController isKindOfClass:[HXRootViewViewController class]])
        {
            self.window.rootViewController = self.rootNavController;
            
            [self.rootNavController popToRootViewControllerAnimated:YES];
            
        }
        else
        {
            self.window.rootViewController = self.rootNavController;
        }
    }
}

#pragma mark - 退出 - 

-(void)logOut
{
    [_backgroundViewController showHome];
    
    [[CLYCLocationManager shareInstance] stopLocationTimer];
    
    [self clearUserInfo];
    //清空记住的用户名和密码
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"rememberPwd"];
    
    [MyKeyChainHelper clearUserPasswordWithpsaawordKeyChain:KEY_PASSWORD];
    
    [self goToLoginView];
    
}

#pragma mark - 清空用户信息
- (void)clearUserInfo
{
    
    [[HXUserModel shareInstance] clear];
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    
     [BMKMapView willBackGround];
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
