//
//  ConfirmMileViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/8.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ConfirmMileViewController.h"
#import "MJRefresh.h"
#import "ConfirmMileTableViewCell.h"
#import "ConfirmMile2ViewController.h"


@interface ConfirmMileViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    
    UITableView *_tableView;
    
    BOOL _isDownPullLoading;
    BOOL _isUpPullLoading;
    
    int _currentDoctorPageIndex;
    
    
    
}

@end

@implementation ConfirmMileViewController

- (void)viewDidLoad
{
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
    self.title = @"里程确认";
    
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
    
    NSArray *keyArray = @[@"queryBeginTime",@"queryEndTime",@"queryCarAppUserId",@"pageSize",@"pageNum"];
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    NSArray *valueArray = @[@"",@"",[HXUserModel shareInstance].userId,@"20",currentPage];
    [CLYCCoreBizHttpRequest obtainMileOrderConfirmListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        
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
    if ([_dataArray count]>0)
    {
        ApplyCarDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
        
        CGFloat height = [ConfirmMileTableViewCell CellHeightWithApplyCarListModel:model];
        
        return height;
    }
    else
        return 0;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([_dataArray count]>0)
    {
        ApplyCarDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
        ConfirmMile2ViewController *confirm2MVC=  [[ConfirmMile2ViewController alloc]initWithApplyCarDetailModel:model];
        [self.navigationController pushViewController:confirm2MVC animated:YES];
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"ApplyCarHistoryCell";
    
    ConfirmMileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[ConfirmMileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
