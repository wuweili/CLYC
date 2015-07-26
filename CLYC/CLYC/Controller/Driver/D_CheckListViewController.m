//
//  D_CheckListViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "D_CheckListViewController.h"

@interface D_CheckListViewController ()

@end

@implementation D_CheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
}

-(void)initUI
{
    self.title = @"考核查询";
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
