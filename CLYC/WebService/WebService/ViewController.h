//
//  ViewController.h
//  WebService
//
//  Created by aJia on 12/12/12.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
@interface ViewController : UIViewController<ServiceHelperDelegate>{
    ServiceHelper *helper;
}
//同步请求
- (IBAction)buttonSyncClick:(id)sender;
//异步请求
- (IBAction)buttonAsycClick:(id)sender;
//队列请求
- (IBAction)buttonQueueClick:(id)sender;
//返回
- (IBAction)buttonBackClick:(id)sender;

@end
