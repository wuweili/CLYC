//
//  SelectDeptmentViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelectDeptmentViewController.h"
#import "SelectDeptmentTableViewCell.h"

@interface SelectDeptmentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    DeptListModel *_selectedModel;
    
    SelectDeptBlock _block;
    
    NSMutableArray *_dataArray;
    UITableView *_tableView;

}

@end

@implementation SelectDeptmentViewController

-(id)initWithDefaultSelectedDeptModel:(DeptListModel *)selectedDeptModel selectDeptBlock:(SelectDeptBlock )block;
{
    self = [super init];
    
    if (self)
    {
        _selectedModel =selectedDeptModel;
        _block = block;
    }
    
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择部门";
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self initTableView];
    
    [self obtainData];
   
}

-(void)clickLeftNavMenu
{
    if (_block)
    {
        _block(_selectedModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)obtainData
{
    [self initMBHudWithTitle:nil];
    
    [CLYCCoreBizHttpRequest obtainDeptListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error) {
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_dataArray addObjectsFromArray:listArry];
            
            [_tableView reloadData];
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
    } keyArray:nil valueArray:nil];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"ApplyCarCell";
    
    SelectDeptmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[SelectDeptmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([_dataArray count]>0)
    {
        DeptListModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        cell.cellTitleLabel.text = model.deptName;
        
        if ([_selectedModel.deptId isEqualToString:model.deptId])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
   
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedModel = [_dataArray objectAtIndex:indexPath.row];

    [_tableView reloadData];
    
    if (_block)
    {
        _block(_selectedModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
