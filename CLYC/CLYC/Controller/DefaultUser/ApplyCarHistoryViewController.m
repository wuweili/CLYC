//
//  ApplyCarHistoryViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/5.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ApplyCarHistoryViewController.h"

@interface ApplyCarHistoryViewController ()
{
    UISegmentedControl *_segmentedSwitchView;
    
    NSInteger switchIndex;


}

@end

@implementation ApplyCarHistoryViewController

-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"约车记录";
    
    [self initSwitchView];
    
    
}

-(void)initSwitchView
{
    NSArray* titles=[[NSArray alloc]initWithObjects:@"未出行", @"已出行", @"已取消", nil];
    
    _segmentedSwitchView = [[UISegmentedControl alloc]initWithItems:titles];
    
    _segmentedSwitchView.frame = CGRectMake(8, 8, kMainScreenWidth-16, 30);
    
    [_segmentedSwitchView addTarget:self action:@selector(segmentChanges:) forControlEvents:UIControlEventValueChanged];
    
    _segmentedSwitchView.tintColor = UIColorFromRGB(0x4fc1e9);
    
    [self.view addSubview:_segmentedSwitchView];
}

#pragma  mark - UISegmentedControl  -

-(void)segmentChanges:(UISegmentedControl *)paramSender
{
    NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
    
    if (selectedSegmentIndex == switchIndex)
    {
        return;
    }
    
    
    switchIndex = selectedSegmentIndex;
    
    
    
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
