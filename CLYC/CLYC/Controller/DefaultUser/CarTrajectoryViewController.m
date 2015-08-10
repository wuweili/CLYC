//
//  CarTrajectoryViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CarTrajectoryViewController.h"
#import "MJRefresh.h"
#import "ApplyCarHistoryTableViewCell.h"
#import "EditApplyCarViewController.h"
#import "CarTrajectoryMapViewController.h"

@interface CarTrajectoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    BOOL _isDownPullLoading;
    BOOL _isUpPullLoading;
    
    int _currentDoctorPageIndex;
}

@end

@implementation CarTrajectoryViewController

-(void)clickLeftNavMenu
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"车辆轨迹";
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _currentDoctorPageIndex = 0;
    
    [self initTableView];
    
    [self initRefreshView];
    
    [self searchHadAlreadyGoOutDataWithUpPull:NO];
   
    
}



-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
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
    
   
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    
    
    NSArray *valueArray = @[[HXUserModel shareInstance].deptId,@"",@"",@"",@"",@"",@"3",[HXUserModel shareInstance].userId,@"20",currentPage];
    
    [CLYCCoreBizHttpRequest obtainCarTrajectoryListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        [self stopRefresh];
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            if (!upPull)
            {
                [_dataArray removeAllObjects];
            }
            
            [_dataArray addObjectsFromArray:listArry];
            
            _currentDoctorPageIndex++;
           
            [_tableView reloadData];
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
    } keyArray:keyArray valueArray:valueArray];
    
    
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
        
        
        
        CarTrajectoryMapViewController *editMVC = [[CarTrajectoryMapViewController alloc]initWithApplyCarDetailModel:model];
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




#pragma mark - 下拉刷新 -

-(void)headerRefreshing
{
    _isDownPullLoading = YES;
    
    _currentDoctorPageIndex = 0;
    
    [self searchHadAlreadyGoOutDataWithUpPull:NO];
    
}

#pragma mark - 上拉刷新 -

-(void)footerRefreshing
{
    _isUpPullLoading = YES;
    
    [self searchHadAlreadyGoOutDataWithUpPull:YES];
    
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
