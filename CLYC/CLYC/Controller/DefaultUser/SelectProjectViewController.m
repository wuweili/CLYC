//
//  SelectProjectViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelectProjectViewController.h"
#import "SelectProjectTableViewCell.h"
#import "MJRefresh.h"

@interface SelectProjectViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    
    ProjectListModel *_selectedModel;
    
    SelectProjectBlock _block;
    
    BOOL _isSearch;//判断是否正在搜索的状态
    NSString *_searchString;//处理搜素界面的相关参数，显示搜索的字串
    NSString *_searchContentStr;//用此字串进行搜索
    
    NSMutableArray *_searchArray;
    
    NSString *_depId;
    
    BOOL _isDownPullLoading;
    BOOL _isUpPullLoading;
    
    int _currentDoctorPageIndex;
}

@property(nonatomic, strong)UISearchDisplayController *strongSearchDisplayController;
@property(nonatomic, strong)UISearchBar *searchBar;


@end

@implementation SelectProjectViewController


-(id)initWithDefaultSelectedProjectModel:(ProjectListModel *)model depId:(NSString *)depId selectProjectBlock:(SelectProjectBlock)block
{
    self = [super init];
    
    if (self)
    {
        _selectedModel = model;
        
        _depId = depId;
        
        _block = block;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择项目";
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _searchArray = [NSMutableArray arrayWithCapacity:0];
    _isSearch = NO;
    _currentDoctorPageIndex = 0;
    [self initSearchBar];
    
    [self initTableView];
    [self initRefreshView];
    
    
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kMainScreenWidth, kScreenHeightNoStatusAndNoNaviBarHeight-CGRectGetHeight(_searchBar.frame)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)initRefreshView
{
    [_tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    [self tableViewMJRefresh:_tableView];
}


-(void)initSearchBar
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"根据项目号搜索";
    _searchBar.tintColor = UIColorFromRGB(0xf3f3f3);
    _searchBar.backgroundColor = UIColorFromRGB(0xebecee);
    
    _searchBar.showsCancelButton = NO;
    [_searchBar sizeToFit];
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.strongSearchDisplayController.searchResultsDataSource = self;
    self.strongSearchDisplayController.searchResultsDelegate = self;
    self.strongSearchDisplayController.delegate = self;
    self.strongSearchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.strongSearchDisplayController setValue:STR_SEARCH_NO_RESULT forKey:@"noResultsMessage"];
    [self.view addSubview:_searchBar];

}

-(void)obtainData
{
    [self initMBHudWithTitle:nil];
    NSArray *keyArray = @[@"queryDeptId",@"queryProjectNo",@"queryProjectName",@"pageSize",@"pageNum"];
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    
    NSArray *valueArray = @[_depId,@"",@"",@"20",currentPage];
    
    [CLYCCoreBizHttpRequest obtainProjectListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        [self stopRefresh];
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableView])
    {
        return [_dataArray count];
    }
    else
    {
        if (_isSearch)
        {
            return [_searchArray count];
        }
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView)
    {
        return 55;
    }
    else
    {
        if (_isSearch)
        {
            return 55;
        }
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView)
    {
        NSString *identifier = @"ApplyCarCell";

        
        SelectProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[SelectProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([_dataArray count]>0)
        {
            ProjectListModel *model = [_dataArray objectAtIndex:indexPath.row];
            [cell setCellContentWithProjectModel:model];
            
            if ([_selectedModel.projectId isEqualToString:model.projectId]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;

            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;

            }
   
        }
        
        return cell;
        
        
        
    }
    else
    {
        if (_isSearch)
        {
            NSString *identifier = @"ApplyCarCell";
            
            
            SelectProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil)
            {
                cell = [[SelectProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.backgroundColor = [UIColor whiteColor];
            
            if ([_searchArray count]>0)
            {
                ProjectListModel *model = [_searchArray objectAtIndex:indexPath.row];
                [cell setCellContentWithProjectModel:model];
                
                if ([_selectedModel.projectId isEqualToString:model.projectId]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
                
            }
            
            return cell;
        }
        else
        {
            NSString *searchNoResultIdentifier = @"searchNoResultIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchNoResultIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchNoResultIdentifier];
            }
            
            cell.textLabel.text = _searchString;
            cell.textLabel.textColor = MAIN_GREEN_TITLE_COLOR;
            cell.textLabel.font = HEL_16;
            
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_tableView == tableView)
    {
        _selectedModel = [_dataArray objectAtIndex:indexPath.row];
        
        [_tableView reloadData];
        
        if (_block)
        {
            _block(_selectedModel);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        _selectedModel = [_searchArray objectAtIndex:indexPath.row];
        
        [_tableView reloadData];
        
        if (_block)
        {
            _block(_selectedModel);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

#pragma mark - UISearchBar Delegate -

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DDLogInfo(@"searBartextDidChange %@",searchBar.text);
    if ([searchBar.text length] > 0)
    {
        _searchString = [NSString stringWithFormat:@"搜索'%@'",searchText];
        _searchContentStr = searchText;
        
    }
    else
    {
        _isSearch = NO;
        [_searchArray removeAllObjects];
    }
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    _isSearch = NO;
    [_searchArray removeAllObjects];
    
}

//点击search button时的响应进行搜索并reload tableview

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self obtainDoctorBySearchWithSearchText:_searchContentStr];
    
    [self.strongSearchDisplayController.searchResultsTableView reloadData];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _searchBar.showsScopeBar = YES;
    [_searchBar setShowsCancelButton:YES animated:YES];
    //    [self changeSearchCancelButtton];
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [_searchArray removeAllObjects];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [_searchArray removeAllObjects];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setContentInset:UIEdgeInsetsZero];
    
    [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
}

#pragma mark - change search bar cancel button

- (void)changeSearchCancelButtton{
    for (UIView *view in _searchBar.subviews)
    {
        if (view != nil && [view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:STR_CANCEL forState:UIControlStateNormal];
            break;
        }
    }
}

-(void)obtainDoctorBySearchWithSearchText:(NSString *)searchText
{
    if ([NSString isBlankString:searchText])
    {
        return;
    }
    
    
    _isSearch = YES;//标志着正在搜索

    [_searchArray removeAllObjects];
    
    [self initMBHudWithTitle:nil];
    NSArray *keyArray = @[@"queryDeptId",@"queryProjectNo",@"queryProjectName",@"pageSize",@"pageNum"];
    
    NSArray *valueArray = @[_depId,searchText,@"",@"20",@"0"];
    
    [CLYCCoreBizHttpRequest obtainProjectListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_searchArray addObjectsFromArray:listArry];
            
            [self.strongSearchDisplayController.searchResultsTableView reloadData];
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
            
            [self.strongSearchDisplayController.searchResultsTableView reloadData];
        }
    } keyArray:keyArray valueArray:valueArray];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)footerRefreshing
{
    _isUpPullLoading = YES;
    [self obtainData];
  
    
}

//如果有更多数据，
-(void)stopRefresh
{
    
    if (_isUpPullLoading)
    {
        _isUpPullLoading = NO;
        [_tableView footerEndRefreshing];
    }
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
