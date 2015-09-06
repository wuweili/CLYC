//
//  HXRegisterViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/9/6.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXRegisterViewController.h"

@interface HXRegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    
    NSString *_phoneString;
    NSString *_userName;
    NSString *_password;
    
    NSIndexPath *_currentFirstRespondIndexPath;

    
}

@end

@implementation HXRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor=UIColorFromRGB(0xf3f3f3) ;
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
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x4fc1e9)];
    
    
    
    
    _phoneString = @"";
    _userName = @"";
    _password = @"";
    _currentFirstRespondIndexPath = nil;
    [IMUnitsMethods drawTheRightBarBtn:self function:@selector(clickRegister) btnTitle:@"注册" bgImage:nil];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    footView.backgroundColor = [UIColor clearColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xABABAB);
//    [footView addSubview:lineView];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kMainScreenWidth, 40)];
    label.textColor = [UIColor lightGrayColor];
    label.font = HEL_11;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"注册成功后，需要管理员审核才可使用账号";
    label.backgroundColor = [UIColor clearColor];
    [footView addSubview:label];
    
    _tableView.tableFooterView =footView;
    
}

-(void)clickRegister
{
    [self moveKeyBoardDown];
    
    if ([NSString isBlankString:_phoneString])
    {
        [self displaySomeInfoWithInfo:@"手机号不能为空" finsh:nil];
        return;
    }
    
    if ([NSString isBlankString:_userName])
    {
        [self displaySomeInfoWithInfo:@"用户名不能为空" finsh:nil];
        return;
    }
    
    if ([NSString isBlankString:_password])
    {
        [self displaySomeInfoWithInfo:@"密码不能为空" finsh:nil];
        return;
    }
    
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"jobNum",@"password",@"userName"];
    NSArray *valueArray = @[_phoneString,_password,_userName];
    
    
    [CLYCCoreBizHttpRequest registerWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"注册成功，等待审核" finsh:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:@"注册失败" finsh:nil];
        }
    } keyArray:keyArray valueArray:valueArray];
    
    
}

-(void)moveKeyBoardDown
{
    NSArray  *cellArray = [_tableView visibleCells];
    
    
    for (UITableViewCell *cell in cellArray)
    {
        for (id view in cell.contentView.subviews)
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                [view resignFirstResponder];
            }
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    [[NSNotificationCenter defaultCenter]removeObserver:self];;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (  id sub  in cell.contentView.subviews ) {
        
        [sub removeFromSuperview];
    }
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, kMainScreenWidth-30, 44)];
    textField.tag = 1000+indexPath.row;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    
    if (indexPath.row == 0)
    {
        
        textField.placeholder = @"请输入手机号";
        textField.text = _phoneString;
    }
    else if (indexPath.row == 1)
    {
        textField.placeholder = @"请输入用户名";
        textField.text = _userName;
        
    }
    else
    {
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        textField.text = _password;
    }
    
    [cell.contentView addSubview:textField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kMainScreenWidth, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xABABAB);
    [cell.contentView addSubview:lineView];
    return cell;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textField.tag-1000 inSection:0];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.tag == 1000)
    {
        _phoneString = textField.text;
    }
    else if (textField.tag == 1001)
    {
        _userName = textField.text;
    }
    else
    {
        _password = textField.text;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark - UIKeyboardNotification-
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
    _tableView.contentInset = UIEdgeInsetsMake(0.0f,
                                                         0.0f,
                                                         bottomInset,
                                                         0.0f);
    
    [UIView commitAnimations];
    
    if (_currentFirstRespondIndexPath != nil)
    {
        [_tableView scrollToRowAtIndexPath:_currentFirstRespondIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
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
    
    _tableView.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];
    
    //    [_detailInfoTableView scrollToRowAtIndexPath:_drugAllergyCellIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
