//
//  HXVerifyTelViewController.m
//  CLYC
//
//  Created by weili.wu on 15/8/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXVerifyTelViewController.h"

@interface HXVerifyTelViewController ()
{
    UITextField *_telTextField;
}

@end

@implementation HXVerifyTelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kMainScreenWidth, 1)];
    line.backgroundColor = UIColorRef(52.0, 182.0, 142);
    [self.navigationController.navigationBar addSubview:line];
    
    self.title = @"填写手机号";
    
    
    [IMUnitsMethods drawTheLeftBarBtn:self function:@selector(backRoot) btnTitle:STR_BACK];
    
    //白色背景
    UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(10, 80, kMainScreenWidth-20, 50)];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    _telTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, 81, kMainScreenWidth-30, 48)];
    _telTextField.borderStyle=UITextBorderStyleNone;
    _telTextField.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _telTextField.delegate=self;
    _telTextField.placeholder=@"请填写您的手机号码";
    [_telTextField becomeFirstResponder];
    _telTextField.keyboardType=UIKeyboardTypeNumberPad;
    _telTextField.font=[UIFont systemFontOfSize:16];
    _telTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_telTextField];
    if (CurrentSystemVersion >=7.0)
    {
        _telTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _telTextField.leftView.userInteractionEnabled = NO;
        _telTextField.leftViewMode = UITextFieldViewModeAlways;
        
    }
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame=CGRectMake(15, 170,kMainScreenWidth-20, 45);
    [btn1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn1.layer.borderColor=[UIColor grayColor].CGColor;
    btn1.layer.borderWidth=1.5;
    [[btn1 layer]setMasksToBounds:YES];
    [[btn1 layer]setCornerRadius:8.0];
    btn1.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn1 setTitleColor:[UIColor colorWithRed:22.0/255.0 green:170.0/255.0 blue:122.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:btn1];
    
    self.view.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    
    //add by xishuaishuai
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    oneTap.delegate = self;
    oneTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:oneTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //注销通知
//    [self  hideKeyBoard];
    
    
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
