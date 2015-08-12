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

#define NotifyActionKey "NotifyAction"
NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

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
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    // [2-EXT]: 获取启动时收到的APN数据
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString *payloadMsg = [message objectForKey:@"payload"];
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    }
    
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

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    
    _appID = appID;
    _appKey = appKey;
    _appSecret = appSecret;
    
    NSError *err = nil;
    
    //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self error:&err];
    
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    //[1-3]:设置电子围栏功能，开启LBS定位服务 和 是否允许SDK 弹出用户定位请求
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    
    if (err) {
        
        DDLogInfo(@"%@",[err localizedDescription]);
        
    }
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

//注册推送 //推送的形式：标记，声音，提示
-(void)registerAPNS
{
    UIRemoteNotificationType type = UIRemoteNotificationTypeAlert |
    UIRemoteNotificationTypeBadge |
    UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
    
}
//取消推送
-(void)unregisterAPNS
{
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
}


- (void)registerRemoteNotification {
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[action1, action2]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                       UIRemoteNotificationTypeSound|
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                   UIRemoteNotificationTypeSound|
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}



#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //[5] Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    DDLogInfo(@"deviceToken:%@", _deviceToken);
    
    // [3]:向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:_deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    [GeTuiSdk registerDeviceToken:@""];
    
    DDLogInfo(@"didFailToRegisterForRemoteNotificationsWithError:%@",[error localizedDescription]);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo {
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    DDLogInfo(@"收到推送消息 payloadMsg = %@ ",payloadMsg);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
    DDLogInfo(@"收到推送消息userInfo =  %@",userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
     [BMKMapView willBackGround];
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [GeTuiSdk enterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // [EXT] 重新上线
    [self startSdkWith:_appID appKey:_appKey appSecret:_appSecret];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - GexinSdkDelegate
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    _clientId = clientId;
    
    if (![NSString isBlankString:_clientId])
    {
        [MyKeyChainHelper saveRegistrationId:_clientId];
    }
    
    if (_deviceToken) {
        [GeTuiSdk registerDeviceToken:_deviceToken];
    }
}

- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId fromApplication:(NSString *)appId
{
    // [4]: 收到个推消息
    _payloadId = payloadId;
    
    NSData* payload = [GeTuiSdk retrivePayloadById:payloadId];
    
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:payloadMsg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
    
    DDLogInfo(@"task id : %@, messageId:%@ payloadMsg = %@", taskId, aMsgId,payloadMsg);
    
    
    
   
}

- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    
    DDLogInfo(@"%@",record);
}

- (void)GeTuiSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    
    DDLogInfo(@">>>[GexinSdk error]:%@", [error localizedDescription]);
    
}

- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // [EXT]:通知SDK运行状态
    _sdkStatus = aStatus;
}


@end
