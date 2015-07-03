//
//  HXRootViewViewController.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "HXRootViewViewController.h"
#import "HXRadioButton.h"


#import "HXRootTableViewCell.h"

#import "MyKeyChainHelper.h"

#import "SDCycleScrollView.h"
#import "MBProgressHUD.h"

#import "AppDelegate.h"


@interface HXRootViewViewController ()<RadioButtonDelegate,SDCycleScrollViewDelegate>
{
    MBProgressHUD *_progressHUD;
    NSTimer *_xmppTimer;
    
    UITableView *_tableView1;
    
    UITextField *_textField1;
    UITextField *_textField2;
    
    NSMutableArray *_imagesMutableArray;
    UIButton *_secretButton;
    
    SDCycleScrollView *_imagesScrollView;
    
    
    BOOL _isDirectLogin; //直接登陆
    
    UIView *_footView;

    UIView *_tableHeadView,*_tableFootView;
    NSIndexPath *_currentFirstRespondIndexPath;
    
    HXRadioButton *_remindPwdButton;
   
   
    
}

@end

@implementation HXRootViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithDirectLogin:(BOOL)directLogin
{
    self = [super init];
    if (self)
    {
        _isDirectLogin = directLogin;
    }
    return self;
}

-(void)dealloc
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initData];
    
    [self initUI];
    
    [self initScrollImageView];
    
    [self initFootView];
    
    [self initTableView];

    if (CurrentSystemVersion>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    
    if (_isDirectLogin)
    {
        [self autoLogin];
    }
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
    if (_tableView1)
    {
        [_tableView1 reloadData];
    }
    
    if (_remindPwdButton)
    {
        [_remindPwdButton refreshRadioButton];
    }
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification
     object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)initData
{
    UIImage *image1=LOGIN_LOGIN_FIRST_IMAGE;
//    UIImage *image2=LOGIN_LOGIN_SECOND_IMAGE;
//    UIImage *image3=LOGIN_LOGIN_THIRD_IMAGE;

    _imagesMutableArray=[[NSMutableArray alloc]initWithObjects:image1,nil];
  
}


-(void)initScrollImageView
{

    _imagesScrollView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (245.0f/480.0f)*kMainScreenHeight) imagesGroup:_imagesMutableArray];
    
    _imagesScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _imagesScrollView.delegate = self;
    _imagesScrollView.autoScrollTimeInterval = 4.0;
    
  
}


-(void)initFootView
{
    
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (175.0f/480.f)*kMainScreenHeight)];
    
    _footView.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL rememberPwd = [defaults boolForKey:@"rememberPwd"];
    
    //记住密码
    _remindPwdButton = [[HXRadioButton alloc]initWithFrame:CGRectMake(15, 17, 100, 20) isSelected:rememberPwd selectedImage:RADIOBtn_SELECTED_IMAGE unSelectedImage:RADIOBtn_UNSELECTED_IMAGE];
    
    _remindPwdButton.backgroundColor = [UIColor clearColor];
    [_remindPwdButton setTitle:@"记住密码" forState:UIControlStateNormal];
    _remindPwdButton.titleLabel.font = HEL_15;
    [_remindPwdButton setTitleColor:UIColorFromRGB(0x70cbeb) forState:UIControlStateNormal];
    _remindPwdButton.delegate = self;
    [_footView addSubview:_remindPwdButton];
    
    //忘记密码
    UIButton *forgetPwdButton = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth - 15 - 78, _remindPwdButton.frame.origin.y, 78, 20)];
    forgetPwdButton.backgroundColor = [UIColor clearColor];
    [forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdButton setTitleColor:UIColorFromRGB(0x70cbeb) forState:UIControlStateNormal];
    [forgetPwdButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    forgetPwdButton.titleLabel.font = HEL_15;
    [forgetPwdButton addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:forgetPwdButton];
    
    //登录按钮
    
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(15,_remindPwdButton.frame.origin.y + _remindPwdButton.frame.size.height +30 , kMainScreenWidth -30 , 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = HEL_17;
    [loginBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    [loginBtn setBackgroundImage:ICON_LOGIN forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:loginBtn];
   
   
}

-(void)initTableView
{
    _tableView1=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth,kMainScreenHeight) style:UITableViewStyleGrouped];
    _tableView1.delegate=self;
    _tableView1.dataSource=self;
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView1.backgroundColor = [UIColor clearColor];
    _tableView1.backgroundView = nil;
    if (CurrentSystemVersion>=7.0)
    {
        //分割线显示
        if ([_tableView1 respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_tableView1 setSeparatorInset:UIEdgeInsetsMake (0,0,0,0)];
        }
    }
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView1];
   
}



-(void)initUI
{
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor= UIColorFromRGB(0xF7F7F7);
}


#pragma mark - UITableViewDelegate - 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _footView.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _imagesScrollView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_tableHeadView)
    {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _imagesScrollView.frame.size.height)];
        [_tableHeadView addSubview:_imagesScrollView];
    }
    return _tableHeadView;
   
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _footView.frame.size.height)];
        
        [_tableFootView addSubview:_footView];
    }
    return _tableFootView;
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier =[NSString stringWithFormat:@"rootCellIdentifier%d",indexPath.row];
    
    HXRootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil)
    {
        cell = [[HXRootTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
    }
    
    if (indexPath.row == 0)
    {
        NSString *userAccount = [MyKeyChainHelper getUserNameWithService:KEY_USERNAME];
        cell.contentTextField.text= userAccount;
    }
    else
    {
        NSString *password = [MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];
        cell.contentTextField.text=password;
    }
    
    
    
    cell.contentTextField.delegate = self;
    if (indexPath.row == 0)
    {
        _textField1 = cell.contentTextField;
    }
    else
    {
        _textField2 = cell.contentTextField;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   
}


#pragma mark - 点击记住按钮
-(void)radioButtonChange:(id)radiobutton didSelect:(BOOL)selectBoolResult
{
    if (selectBoolResult)
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rememberPwd"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"rememberPwd"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)rememberPwdOrNot
{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL rememberPwd = [defaults boolForKey:@"rememberPwd"];

    if (rememberPwd == YES)
    {
        
        [MyKeyChainHelper saveUserName:_textField1.text userNameService:KEY_USERNAME psaaword:_textField2.text psaawordService:KEY_PASSWORD];
        
    }
    else
    {
        [MyKeyChainHelper saveUserName:_textField1.text userNameService:KEY_USERNAME psaaword:@"" psaawordService:KEY_PASSWORD];
    }
}



#pragma mark - 点击忘记密码按钮
-(void)forgotPassword
{
   
    
}


#pragma mark - 点击登录按钮

-(void)clickLoginButton
{
    
    NSDictionary *sendDic = @{@"loginId":@"ios",@"password":@"sj@ios",@"moblieType":@"2",@"cId":@"23456789"};
    
    NSArray *keyArray = @[@"loginId",@"password",@"moblieType",@"cId"];
    
    NSArray *valueArray = @[@"ios",@"sj@ios",@"2",@"23456789"];
    
    
    [CLYCCoreBizHttpRequest loginYBUserWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            
        }
        else
        {
            
        }
        
        
    } keyArray:keyArray valueArray:valueArray  password:@"sj@ios" logonId:@"ios"];
    
    
    [HXAPPDELEGATE goToMainView];
    
    
    
    
    
    
    
    _isDirectLogin = NO;
    
    
    if ([NSString isBlankString:_textField1.text] && [NSString isBlankString:_textField2.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"用户名和密码不能为空" delegate:nil cancelButtonTitle:STR_ALREADY_KNOW otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([NSString isBlankString:_textField1.text] )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"用户名不能为空" delegate:nil cancelButtonTitle:STR_ALREADY_KNOW otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([NSString isBlankString:_textField2.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:STR_ALREADY_KNOW otherButtonTitles:nil, nil];
        [alert show];
        
    }

    else
    {
        
        [self loginWithUserName:_textField1.text password:_textField2.text];

    }
  
}


#pragma mark - 直接登录 - 

-(void)autoLogin
{
    _isDirectLogin = YES;
    
    NSString *userAccount = [MyKeyChainHelper getUserNameWithService:KEY_USERNAME];
    NSString *password = [MyKeyChainHelper getPasswordWithService:KEY_PASSWORD];
    
    [self loginWithUserName:userAccount password:password];
    
}


#pragma mark - 调用登录接口 -

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password
{
    
    

    
}






#pragma mark - 点击最下面的审核提示
-(void)clickCheckTipButton
{
    
}


#pragma mark - KeyboardNotification
- (void) handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    NSDictionary *userInfo = [paramNotification userInfo];
    
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(window.frame, keyboardEndRect);
    CGFloat bottomInset = intersectionOfKeyboardRectAndWindowRect.size.height;
    _tableView1.contentInset = UIEdgeInsetsMake(0.0f,
                                                         0.0f,
                                                         bottomInset,
                                                         0.0f);
    
    [UIView commitAnimations];
    
    
    
    if (_currentFirstRespondIndexPath)
    {
        [_tableView1 scrollToRowAtIndexPath:_currentFirstRespondIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

- (void) handleKeyboardWillHide:(NSNotification *)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject =[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]; NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve]; [animationDurationObject getValue:&animationDuration]; [keyboardEndRectObject getValue:&keyboardEndRect];
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    _tableView1.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];

    
}


#pragma mark - UITextFieldDelegate-

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-500 inSection:0];
    
    [textField becomeFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _textField1)
    {
        [_textField1 resignFirstResponder];
        [_textField2 becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
}


-(void)textFieldDidChange:(UITextField*)textField
{
    
    [IMUnitsMethods limitInputTextWithUITextField:textField limit:100];
    
//    [textField setText:[IMUnitsMethods disable_emoji:[textField text]]];
    
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DDLogInfo(@"---点击了第%d张图片", index);
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
        _progressHUD.labelText = title;
    }
    
    //    [_progressHUD show:YES];
    _progressHUD.removeFromSuperViewOnHide = YES;
    //    [self.navigationController.view addSubview:_progressHUD];
    
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
    _progressHUD.labelText = infoStr;
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
        _progressHUD.labelText = msg;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
