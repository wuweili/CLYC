//
//  URLConnectionViewController.h
//  WebService
//
//  Created by aJia on 12/12/25.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
@interface URLConnectionViewController : UIViewController<WebServiceDelegate>{
    WebServices *helper;
}

//同步请求
- (IBAction)buttonSyncClick:(id)sender;
//异步请求
- (IBAction)buttonAsyncClick:(id)sender;
//返回
- (IBAction)buttonBackClick:(id)sender;

@end
