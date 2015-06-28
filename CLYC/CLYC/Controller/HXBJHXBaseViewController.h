//
//  BJHXBaseViewController.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBJHXBaseViewController : UIViewController


#pragma mark - MBHUDProgress and NSTime
-(void)initMBHudWithTitle:(NSString *)title;

-(void)initMBHudBecauseNetWorkUnavailable;

-(void)stopMBHudAndNSTimerWithmsg:(NSString *)msg finsh:(void (^)(void))finshBlock;

-(void)displaySomeInfoWithInfo:(NSString *)infoStr finsh:(void (^)(void))finshBlock;


#pragma mark - 上拉或者下拉，文字显示。如果更改，可以在子类里面重写。
-(void)tableViewMJRefresh:(UITableView*)tableView;

@end
