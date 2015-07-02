//
//  YBTabBarViewController.m
//  TestSwiftToOc
//
//  Created by weili.wu on 15/5/21.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "YBTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"



@interface YBTabBarViewController ()

@end

@implementation YBTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    FirstViewController *firstMVC = [[FirstViewController alloc]init];
    UINavigationController *firstNav = [[UINavigationController alloc]initWithRootViewController:firstMVC];
    firstMVC.title = @"first";
    
    SecondViewController *secondMVC = [[SecondViewController alloc]init];
    UINavigationController *secondNav = [[UINavigationController alloc]initWithRootViewController:secondMVC];
    secondMVC.title = @"second";
    
    NSArray *array = [NSArray arrayWithObjects:firstNav,secondNav, nil];
    
    
    
    
    [self setViewControllers:array];
    
    
    
    
   
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
