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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    if ([self isNeedLogin])
    {
        [self goToLoginView];
    }
    
    
    
    return YES;
}

#pragma mark - 跳转到登陆界面
- (void)goToLoginView
{
    
    
    HXRootViewViewController *loginMVC  = [[HXRootViewViewController alloc]initWithDirectLogin:NO];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginMVC];
    self.window.rootViewController = navController;
    
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
