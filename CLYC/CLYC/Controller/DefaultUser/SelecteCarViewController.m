//
//  SelecteCarViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelecteCarViewController.h"

@interface SelecteCarViewController ()
{
    UITableView *_tableView;
    
    NSMutableArray *_carListArray;
    
    SelectCarBlock _selectCarBlock;
    
    SelectCarInfoModel *_selectedCarModel;
    
}

@end

@implementation SelecteCarViewController

-(id)initWithDefaultSelectedCarModel:(SelectCarInfoModel *)selectedCarModel selectCarBlock:(SelectCarBlock)block
{
    self = [super init];
    
    if (self)
    {
        _selectedCarModel = selectedCarModel;
        
        _selectCarBlock = block;
    }
    
    return  self;
}


- (void)viewDidLoad
{
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
