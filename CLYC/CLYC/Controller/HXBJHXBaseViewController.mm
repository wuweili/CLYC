//
//  BJHXBaseViewController.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "HXBJHXBaseViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "CLYCHomeViewController.h"



@interface HXBJHXBaseViewController ()<UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *_progressHUD;
    NSTimer * _xmppTimer;
  
}

@end

@implementation HXBJHXBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=BACKGROUND_COLOR ;//UIColorFromRGB(0xF5F5F5);
    if (CurrentSystemVersion >= 7.0)
    {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, HEL_20,NSFontAttributeName,nil]];
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        
    }
    else
    {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HEL_20,UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    
    [self setupLeftMenuButton];
    
    
    
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
   
    
}

-(void)setupLeftMenuButton
{
    if ([self isKindOfClass:[CLYCHomeViewController class]])
    {
        [IMUnitsMethods drawTheLeftBarBtn:self function:@selector(leftDrawerButtonPress:) btnTitle:nil ];
//        [IMUnitsMethods drawTheRightBarBtn:self function:@selector(rightDrawerButtonPress:) btnTitle:nil bgImage:XC_rightNavButton_bg_image];
        
    }
    else
    {
        [IMUnitsMethods drawTheLeftBarBtnWithNoTitle:self function:@selector(clickLeftNavMenu)];
    }
}

static  BOOL hideLeft  = NO;

-(void)leftDrawerButtonPress:(id)sender
{
    
    [HXAPPDELEGATE.backgroundViewController showLeft];

    return;
    
//    if (hideLeft)
//    {
//        [HXAPPDELEGATE.backgroundViewController showHome];
//
//    }
//    else
//    {
//        [HXAPPDELEGATE.backgroundViewController showLeft];
//    }
//    
//    hideLeft = !hideLeft;

    
}

-(void)clickLeftNavMenu
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}




#pragma mark - set tab bar unread msg num

- (void)setBadageValuerOnTabBar:(int)num
{
    if (num > 0)
    {
        if (num > 99)
        {
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"new"];
        }
        else
        {
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",num];
        }
    }
    else
    {
        self.navigationController.tabBarItem.badgeValue = nil;
    }
//    self.navigationController.tabBarItem.tag = 0;
}

- (void)setBadageValuerOnTabBarNoNum
{
    self.navigationController.tabBarItem.badgeValue = @"";
    self.navigationController.tabBarItem.tag = 1000;
}



#pragma mark tap action
-(void)tapAction:(id)sender
{
    [self.view endEditing:YES];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![touch.view isKindOfClass:[UITextField class]] &&
        ![touch.view isKindOfClass:[UITextView class]] &&
        ![touch.view isKindOfClass:[UIButton class]]
        )
    {
        [self.view endEditing:YES];
    }
    return NO;
}


-(void)hideKeyBoardShow
{
    //私有api关闭键盘方法
    /*
     Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
     id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
     [activeInstance performSelector:@selector(dismissKeyboard)];
     */
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
   
}



#pragma mark - 上拉或者下拉，文字显示。如果更改，可以在子类里面重写。
-(void)tableViewMJRefresh:(UITableView*)tableView
{
    tableView.headerPullToRefreshText = @"下拉可以刷新了";
    tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    tableView.headerRefreshingText = @"正在帮您刷新,请稍等";
    
    tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableView.footerRefreshingText = @"正在帮您刷新,请稍等";

}

#pragma mark - MBHUDProgress and NSTime
-(void)initMBHudWithTitle:(NSString *)title
{
    if (_progressHUD != nil)
    {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
    _progressHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
    if (![NSString isBlankString:title])
    {
        _progressHUD.mode = MBProgressHUDModeText;
        
        _progressHUD.detailsLabelText = title;
        if (title.length > 12)
        {
            _progressHUD.detailsLabelFont = HEL_14;
        }
        else
        {
            _progressHUD.detailsLabelFont = HEL_16;
        }
        
        
    }
    
    _progressHUD.removeFromSuperViewOnHide = YES;
    
    _xmppTimer = [NSTimer timerWithTimeInterval:30
                                         target:self
                                       selector:@selector(timeoutFailed)
                                       userInfo:nil
                                        repeats:NO];
    [[NSRunLoop currentRunLoop]addTimer:_xmppTimer forMode:NSRunLoopCommonModes];
    
}

-(void)initMBHudBecauseNetWorkUnavailable
{
    _progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = STR_NET_ERROR;
    [_progressHUD show:YES];
    _progressHUD.removeFromSuperViewOnHide = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    
    
    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0];
}

-(void)displaySomeInfoWithInfo:(NSString *)infoStr finsh:(void (^)(void))finshBlock
{
    _progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    _progressHUD.mode = MBProgressHUDModeText;
    
    
    _progressHUD.detailsLabelText = infoStr;
    if (infoStr.length > 12)
    {
        _progressHUD.detailsLabelFont = HEL_14;
    }
    else
    {
        _progressHUD.detailsLabelFont = HEL_16;
    }
    
    
    [_progressHUD show:YES];
    _progressHUD.removeFromSuperViewOnHide = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideProgress];
        
        if (finshBlock)
        {
            finshBlock();
        }
        
    });

}



-(void)stopMBHudAndNSTimerWithmsg:(NSString *)msg finsh:(void (^)(void))finshBlock
{
    
    if (_xmppTimer)
    {
        [_xmppTimer invalidate];
        _xmppTimer = nil;
    }
    
    /*
     *  目前是如果停止时又文字显示，那就有一个回调block
     *
     */
    
    if (msg != nil)
    {
        _progressHUD.mode =  MBProgressHUDModeText;
//        _progressHUD.labelText = msg;
        
        
        _progressHUD.detailsLabelText = msg;
        if (msg.length > 12)
        {
            _progressHUD.detailsLabelFont = HEL_14;
        }
        else
        {
            _progressHUD.detailsLabelFont = HEL_16;
        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            
            if (finshBlock)
            {
                finshBlock();
            }
            
            
        });
        
//        [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0];
    }else
    {
        
        
        [self hideProgress];
        
        if (finshBlock)
        {
            finshBlock();
        }
    }
}

-(void)hideProgress
{
//    _progressHUD.hidden = YES;
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    if (_progressHUD != nil) {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
}

-(void)timeoutFailed
{
    if (_xmppTimer)
    {
        [_xmppTimer invalidate];
        _xmppTimer = nil;
    }
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    if (_progressHUD != nil) {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progressHUD];
    _progressHUD.labelText = @"操作超时，请重试!";
    _progressHUD.mode = MBProgressHUDModeText;
    
    
    [_progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
        
    }];
    
//    _progressHUD.mode = MBProgressHUDModeText;
//    _progressHUD.labelText = @"操作超时，请重试!";
//    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1.0];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
