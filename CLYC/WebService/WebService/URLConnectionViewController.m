//
//  URLConnectionViewController.m
//  WebService
//
//  Created by aJia on 12/12/25.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "URLConnectionViewController.h"
#import "SoapHelper.h"
@interface URLConnectionViewController ()

@end

@implementation URLConnectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    helper=[[WebServices alloc] initWithDelegate:self];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark -
#pragma mark WebServices delegate Methods
-(void)requestFinishedMessage:(NSString*)xml{
    NSLog(@"请求成功，返回的xml:\n%@\n",xml);
    [AppHelper removeHUD];//移除动画
}
-(void)requestFailedMessage:(NSError*)error{
    NSLog(@"请求失败:%@\n",[error description]);
    [AppHelper removeHUD];//移除动画
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//同步请求
- (IBAction)buttonSyncClick:(id)sender {
    [AppHelper showHUD:@"loading"];//显示动画
    NSLog(@"=======同步请求开始======\n");
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"curPage", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"GetWebNewsByType"];
    //执行同步并取得结果
    NSString *xml=[helper syncServiceMethod:@"GetWebNewsByType" soapMessage:soapMsg];
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSLog(@"同步请求返回的xml:\n%@\n",xml);
    NSLog(@"=======同步请求结束======\n");
    [AppHelper removeHUD];//移除动画
}
//异步请求
- (IBAction)buttonAsyncClick:(id)sender {
    [AppHelper showHUD:@"loading"];//显示动画
    NSLog(@"=======异步请求开始======\n");
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"curPage", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"GetWebNewsByType"];
    [helper asyncServiceMethod:@"GetWebNewsByType" soapMessage:soapMsg];
}
//返回
- (IBAction)buttonBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [helper release];
    [super dealloc];
}
@end
