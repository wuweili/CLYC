//
//  ApplyCarHistoryViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/5.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ApplyCarHistoryViewController.h"
#import "MJRefresh.h"
#import "ApplyCarHistoryTableViewCell.h"
#import "EditApplyCarViewController.h"


@interface ApplyCarHistoryViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl *_segmentedSwitchView;
    
    NSInteger switchIndex;
    
    UIView *_conditionView;
    
    UITextField *_projectNumTextField;
    
    UITextField *_carNumTextField;
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    BOOL _isDownPullLoading;
    BOOL _isUpPullLoading;
    
    int _currentDoctorPageIndex;



}

@end

@implementation ApplyCarHistoryViewController

-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"约车记录";
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    switchIndex = 0;
    
    _currentDoctorPageIndex = 0;
    
    [self initSwitchView];
    
    [self initConditionView];
    
    [self initTableView];
    
    [self initRefreshView];
    
    [_segmentedSwitchView setSelectedSegmentIndex:switchIndex];
    
    [self switchViewValueChanged:switchIndex];
  
    
}

-(void)initSwitchView
{
    NSArray* titles=[[NSArray alloc]initWithObjects: @"已出行",@"未出行", @"已取消", nil];
    
    _segmentedSwitchView = [[UISegmentedControl alloc]initWithItems:titles];
    
    _segmentedSwitchView.frame = CGRectMake(8, 8, kMainScreenWidth-16, 30);
    
    [_segmentedSwitchView addTarget:self action:@selector(segmentChanges:) forControlEvents:UIControlEventValueChanged];
    
    _segmentedSwitchView.tintColor = UIColorFromRGB(0x4fc1e9);
    
    [self.view addSubview:_segmentedSwitchView];
}


-(void)initConditionView
{
    _conditionView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentedSwitchView.frame)+8, kMainScreenWidth
                                                             , 120)];
    
    _conditionView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_conditionView];
    
    //项目号
    
    UILabel *startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 30)];
    startTimeLabel.font = HEL_14;
    startTimeLabel.textColor = [UIColor blackColor];
    startTimeLabel.textAlignment = NSTextAlignmentRight;
    startTimeLabel.backgroundColor = [UIColor clearColor];
    startTimeLabel.text = @"项目号：";
    [_conditionView addSubview:startTimeLabel];

    
    _projectNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startTimeLabel.frame), startTimeLabel.frame.origin.y , kMainScreenWidth-CGRectGetMaxX(startTimeLabel.frame)-10, 30)];
    _projectNumTextField.placeholder=@"请输入项目号";
    _projectNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _projectNumTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _projectNumTextField.font = HEL_15;
    _projectNumTextField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _projectNumTextField.layer.cornerRadius = 4.0;
    _projectNumTextField.layer.borderWidth = 1.0;
    _projectNumTextField.delegate = self;
    _projectNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_conditionView addSubview:_projectNumTextField];

    
    
    //车辆号
    
    
    UILabel *endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(startTimeLabel.frame)+5, 70, 30)];
    endTimeLabel.font = HEL_14;
    endTimeLabel.textColor = [UIColor blackColor];
    endTimeLabel.textAlignment = NSTextAlignmentRight;
    endTimeLabel.backgroundColor = [UIColor clearColor];
    endTimeLabel.text = @"车辆号：";
    [_conditionView addSubview:endTimeLabel];
    
  
    
    _carNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(endTimeLabel.frame), endTimeLabel.frame.origin.y , kMainScreenWidth-CGRectGetMaxX(endTimeLabel.frame)-10, 30)];
    _carNumTextField.placeholder=@"请输入车辆号";
    _carNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _carNumTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _carNumTextField.font = HEL_15;
    _carNumTextField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _carNumTextField.layer.cornerRadius = 4.0;
    _carNumTextField.layer.borderWidth = 1.0;
    _carNumTextField.delegate = self;
    _carNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_conditionView addSubview:_carNumTextField];
    
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(endTimeLabel.frame)+10, kMainScreenWidth-20, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
    
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"查询" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickStartSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [_conditionView addSubview:startSearchButton];
    
}

-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_conditionView.frame),kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight-166) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}


-(void)initRefreshView
{
    [_tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    
    [_tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    [self tableViewMJRefresh:_tableView];
}




#pragma mark - 查询已出行

-(void)searchHadAlreadyGoOutDataWithUpPull:(BOOL)upPull
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"queryDeptId",@"queryProjectNo",@"queryCarCode",@"queryBeginTime",@"queryEndTime",@"queryState",@"queryTravelstate",@"queryCarAppUserId",@"pageSize",@"pageNum"];
    
    NSString *projectNumStr = _projectNumTextField.text;
    
    if ([NSString isBlankString:_projectNumTextField.text])
    {
        projectNumStr = @"";
    }
    
    NSString *carNumStr = _carNumTextField.text;
    
    if ([NSString isBlankString:_carNumTextField.text])
    {
        carNumStr = @"";
    }
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    
    
    NSArray *valueArray = @[[HXUserModel shareInstance].deptId,projectNumStr,carNumStr,@"",@"",@"",@"1",[HXUserModel shareInstance].userId,@"20",currentPage];
    
    
    [CLYCCoreBizHttpRequest obtainApplyCarHistorWithBlock:^(NSMutableArray *ListArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        
        [self stopRefresh];
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            if (!upPull)
            {
                [_dataArray removeAllObjects];
            }
            
            [_dataArray addObjectsFromArray:ListArry];
            
            _currentDoctorPageIndex++;
            
            
            
            [_tableView reloadData];
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
    
}


#pragma mark - 查询未出行

-(void)searchHadNotAlreadyGoOutDataWithUpPull:(BOOL)upPull
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"queryDeptId",@"queryProjectNo",@"queryCarCode",@"queryBeginTime",@"queryEndTime",@"queryState",@"queryTravelstate",@"queryCarAppUserId",@"pageSize",@"pageNum"];
    
    NSString *projectNumStr = _projectNumTextField.text;
    
    if ([NSString isBlankString:_projectNumTextField.text])
    {
        projectNumStr = @"";
    }
    
    NSString *carNumStr = _carNumTextField.text;
    
    if ([NSString isBlankString:_carNumTextField.text])
    {
        carNumStr = @"";
    }
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    
    NSArray *valueArray = @[[HXUserModel shareInstance].deptId,projectNumStr,carNumStr,@"",@"",@"",@"2",[HXUserModel shareInstance].userId,@"20",currentPage];
    
    
    [CLYCCoreBizHttpRequest obtainApplyCarHistorWithBlock:^(NSMutableArray *ListArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        
        [self stopRefresh];
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
          
            if (!upPull)
            {
                [_dataArray removeAllObjects];
            }
            
            [_dataArray addObjectsFromArray:ListArry];
            
            _currentDoctorPageIndex++;
            
            [_tableView reloadData];
  
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
}





#pragma mark - 查询已取消

-(void)searchHadAlreadyCancleDataWithUpPull:(BOOL)upPull
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"queryDeptId",@"queryProjectNo",@"queryCarCode",@"queryBeginTime",@"queryEndTime",@"queryState",@"queryTravelstate",@"queryCarAppUserId",@"pageSize",@"pageNum"];
    
    NSString *projectNumStr = _projectNumTextField.text;
    
    if ([NSString isBlankString:_projectNumTextField.text])
    {
        projectNumStr = @"";
    }
    
    NSString *carNumStr = _carNumTextField.text;
    
    if ([NSString isBlankString:_carNumTextField.text])
    {
        carNumStr = @"";
    }
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    
    NSArray *valueArray = @[[HXUserModel shareInstance].deptId,projectNumStr,carNumStr,@"",@"",@"2",@"",[HXUserModel shareInstance].userId,@"20",currentPage];
    
    
    [CLYCCoreBizHttpRequest obtainApplyCarHistorWithBlock:^(NSMutableArray *ListArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        
        [self stopRefresh];
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            if (!upPull)
            {
                [_dataArray removeAllObjects];
            }
            
            [_dataArray addObjectsFromArray:ListArry];
            
            _currentDoctorPageIndex++;
            [_tableView reloadData];
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
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
    
    _currentDoctorPageIndex = 0;
    
    [self switchViewValueChanged:selectedSegmentIndex];
    
    
    
}

-(void)switchViewValueChanged:(NSInteger)index
{
    
    if (index == 0)
    {
        [self searchHadAlreadyGoOutDataWithUpPull:NO];
    }
    else if (index == 1)
    {
        [self searchHadNotAlreadyGoOutDataWithUpPull:NO];
    }
    else
    {
        [self searchHadAlreadyCancleDataWithUpPull:NO];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([_dataArray count]>0)
    {
        ApplyCarDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        EditApplyCarViewController *editMVC = [[EditApplyCarViewController alloc]initWithApplyCarDetailModel:model];
        [self.navigationController pushViewController:editMVC animated:YES];
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"ApplyCarHistoryCell";
    
    ApplyCarHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[ApplyCarHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([_dataArray count]>0)
    {
        ApplyCarDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
        [cell setCellContentWithApplyCarListModel:model];
        
        
    }
    
    return cell;
    
    
}

#pragma mark - 点击查询 - 

-(void)clickStartSearchButton
{
    _currentDoctorPageIndex = 0;
    
    [self switchViewValueChanged:switchIndex];
}


#pragma mark - 下拉刷新 -

-(void)headerRefreshing
{
    _isDownPullLoading = YES;
    
    _currentDoctorPageIndex = 0;
    
    if (switchIndex == 0)
    {
        [self searchHadAlreadyGoOutDataWithUpPull:NO];
    }
    else if (switchIndex == 1)
    {
        
        
        [self searchHadNotAlreadyGoOutDataWithUpPull:NO];
    }
    else
    {
        [self searchHadAlreadyCancleDataWithUpPull:NO];
    }
    
}

#pragma mark - 上拉刷新 -

-(void)footerRefreshing
{
    _isUpPullLoading = YES;
    
    if (switchIndex == 0)
    {
        [self searchHadAlreadyGoOutDataWithUpPull:YES];
    }
    else if (switchIndex == 1)
    {
        
        
        [self searchHadNotAlreadyGoOutDataWithUpPull:YES];
    }
    else
    {
        [self searchHadAlreadyCancleDataWithUpPull:YES];
    }
    
}



//如果有更多数据，
-(void)stopRefresh
{
    if (_isDownPullLoading)
    {
        _isDownPullLoading = NO;
        [_tableView headerEndRefreshing];
    }
    
    if (_isUpPullLoading)
    {
        _isUpPullLoading = NO;
        [_tableView footerEndRefreshing];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
