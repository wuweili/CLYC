//
//  SelectDeptmentViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelectDeptmentViewController.h"

@interface SelectDeptmentViewController ()

@end

@implementation SelectDeptmentViewController

-(id)initWithDefaultSelectedDeptModel:(DeptListModel *)selectedDeptModel selectDeptBlock:(SelectDeptBlock )block;
{
    self = [super init];
    
    if (self)
    {
        _selectedCarModel = selectedCarModel;
        
        _selectCarBlock = block;
        
        _beginTime =beginTime;
        
        _endTime =endTime;
    }
    
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
