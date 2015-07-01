//
//  ViewController.m
//  WebService
//
//  Created by aJia on 12/12/12.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "ViewController.h"
#import "SoapHelper.h"
#import "ASIHTTPRequest.h"
#import "SoapXmlParseHelper.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    helper=[[ServiceHelper alloc] initWithDelegate:self];
    
    //NSString *filePath=[[NSBundle mainBundle] pathForResource:@"datatable" ofType:@"xml"];
    //NSData *data=[NSData dataWithContentsOfFile:filePath];
    //NSMutableArray *arr=[SoapXmlParseHelper SearchNodeToArray:data nodeName:@"CircularTaxType"];
    //NSLog(@"arr=%@\n",arr);
	// Do any additional setup after loading the view, typically from a nib.
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
- (IBAction)buttonAsycClick:(id)sender {
    [AppHelper showHUD:@"loading"];//显示动画
    NSLog(@"=======异步请求开始======\n");
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"curPage", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"GetWebNewsByType"];
    [helper asynServiceMethod:@"GetWebNewsByType" soapMessage:soapMsg];
}
//队列请求
- (IBAction)buttonQueueClick:(id)sender {
    [AppHelper showHUD:@"loading"];//显示动画
    NSLog(@"=======队列请求开始======\n");
    [helper resetQueue];//取消之前的请求
    for (int i=1; i<4; i++) {
        NSString *name=[NSString stringWithFormat:@"request%d",i];
        //获取soap
        NSMutableArray *arr=[NSMutableArray array];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"type", nil]];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"curPage", nil]];
        [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize", nil]];
        NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"GetWebNewsByType"];
        
        //获取ASIHTTPRequest
        ASIHTTPRequest *request=[ServiceHelper commonSharedRequestMethod:@"GetWebNewsByType" soapMessage:soapMsg];
        //设置UserInfo用于区分不同的请求
        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:name,@"name", nil]];
        //添加到队列中
        [helper addRequestQueue:request];
    }
    [helper startQueue];//开始队列
}
//返回
- (IBAction)buttonBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark 异步请求结果
-(void)finishSuccessRequest:(NSString*)xml{
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSLog(@"异步请求返回的xml:\n%@\n",xml);
    NSLog(@"=======异步请求结束======\n");
    [AppHelper removeHUD];//移除动画
}
-(void)finishFailRequest:(NSError*)error{
    NSLog(@"异步请发生失败:%@\n",[error description]);
   [AppHelper removeHUD];//移除动画
}
- (void)dealloc {
    [helper release];
    [super dealloc];
}
#pragma mark -
#pragma mark 队列请求处理
-(void)finishQueueComplete{
    NSLog(@"＝＝＝所有队列请求完成=====\n");
     [AppHelper removeHUD];//移除动画
}
-(void)finishSingleRequestSuccess:(NSString*)xml userInfo:(NSDictionary*)dic{
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSString *name=[dic objectForKey:@"name"];
    NSLog(@"队列%@,请求完成\n",name);
    NSLog(@"队列%@,返回的xml为\n%@\n",name,xml);
}
-(void)finishSingleRequestFailed:(NSError*)error userInfo:(NSDictionary*)dic{
    NSString *name=[dic objectForKey:@"name"];
    NSLog(@"队列%@,请求失败\n",name);
    NSLog(@"队列%@,请求失败原因为\n%@\n",name,[error description]);

}
@end
