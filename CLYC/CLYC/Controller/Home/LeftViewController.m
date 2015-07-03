//
//  LeftViewController.m
//  TestSwiftToOc
//
//  Created by weili.wu on 15/5/20.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftSecondViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"left";
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 40, 20)];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}



-(void)click
{
    LeftSecondViewController *userInfoMVC = [[LeftSecondViewController alloc]init];
    UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:userInfoMVC];
    
    userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:userInfoNav animated:YES completion:^{
        
    }];
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
