//
//  HXRootViewViewController.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface HXRootViewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    
}

@property(nonatomic,assign) int flag;


-(id)initWithDirectLogin:(BOOL)directLogin;

@end
