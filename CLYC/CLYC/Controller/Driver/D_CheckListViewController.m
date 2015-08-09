//
//  D_CheckListViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "D_CheckListViewController.h"
#import "MJRefresh.h"
#import "D_driverCheckTableViewCell.h"

@interface D_CheckListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    
    UITableView *_tableView;
    
    BOOL _isDownPullLoading;
    BOOL _isUpPullLoading;
    
    int _currentDoctorPageIndex;
}

@end

@implementation D_CheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initData];
    
    [self initTableView];
    
    [self initRefreshView];
    
    [self obtainDataWithUpPull:NO];
    
}

-(void)initUI
{
    self.title = @"考核查询";
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _currentDoctorPageIndex = 0;
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

-(void)obtainDataWithUpPull:(BOOL)upPull
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"queryDriverId",@"pageSize",@"pageNum"];
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    NSArray *valueArray = @[[HXUserModel shareInstance].userId,@"20",currentPage];
    
    [CLYCCoreBizHttpRequest driverCheckListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
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
    return 70;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"ApplyCarHistoryCell";
    
    D_driverCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[D_driverCheckTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([_dataArray count]>0)
    {
        DriverCheckModel *model = [_dataArray objectAtIndex:indexPath.row];
        [cell setCellContentWithCheckModel:model];
        
        
    }
    
    return cell;
    
    
}

#pragma mark - 下拉刷新 -

-(void)headerRefreshing
{
    _isDownPullLoading = YES;
    
    _currentDoctorPageIndex = 0;
    
    [self obtainDataWithUpPull:NO];
    
}

#pragma mark - 上拉刷新 -

-(void)footerRefreshing
{
    _isUpPullLoading = YES;
    
    [self obtainDataWithUpPull:YES];
}

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

#pragma mark - UIlabel 高度变化及cell高度


@end
