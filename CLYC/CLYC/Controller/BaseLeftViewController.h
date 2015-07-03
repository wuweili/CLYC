//
//  BaseLeftViewController.h
//  CLYC
//
//  Created by wuweiqing on 15/7/4.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLeftViewController : UIViewController


#pragma mark - MBHUDProgress and NSTime
-(void)initMBHudWithTitle:(NSString *)title;

-(void)initMBHudBecauseNetWorkUnavailable;

-(void)stopMBHudAndNSTimerWithmsg:(NSString *)msg finsh:(void (^)(void))finshBlock;

-(void)displaySomeInfoWithInfo:(NSString *)infoStr finsh:(void (^)(void))finshBlock;

@end
