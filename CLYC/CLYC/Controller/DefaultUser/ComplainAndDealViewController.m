//
//  ComplainAndDealViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/27.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ComplainAndDealViewController.h"
#import "MJRefresh.h"
#import "D_ApplyCarListTableViewCell.h"
#import "D_ConfirmMile2ViewController.h"
#import "ComplainListTableViewCell.h"
#import "SaveComplainViewController.h"



@interface ComplainAndDealViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *_headView;
    
    UITextField *_startTimeField;
    
    UITextField *_endTimeField;
    
    UITextField *_carNumberField;
    
    UITextField *_carTypeField;
    
    UILabel *_carNumberLabel;
    
    UILabel *_carTypeLabel;
    
    UIDatePicker *_startTimeDatePicker;
    
    UIDatePicker *_endTimeDatePicker;
    
    BOOL expandMoreSearchCondition;
    
    UIView *_startSearchBackGroundView;
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    BOOL _isDownPullLoading;
    BOOL _isUpPullLoading;
    
    int _currentDoctorPageIndex;
}

@end

@implementation ComplainAndDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initData];
    
    [self initTableView];
    
    [self initRefreshView];
    
    [self obtainDefaultDataWithUpPull:NO];
    
}

-(void)initUI
{
    self.title = @"我的投诉";
    
    expandMoreSearchCondition = NO;
    
    [self initHeadView];
    
    [self initStartSearchView];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addComplain)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void)initData
{
    _currentDoctorPageIndex = 0;
    
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startSearchBackGroundView.frame),kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight-110-35) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)initHeadView
{
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 110)];
    _headView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_headView];
    
    
    
    UIView *searchTipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    searchTipView.backgroundColor = UIColorFromRGB(0xEFEFEF);
    
    [_headView addSubview:searchTipView];
    
    
    
    UILabel *searchTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 20)];
    
    searchTipLabel.backgroundColor = [UIColor clearColor];
    
    searchTipLabel.textColor = [UIColor grayColor];
    
    searchTipLabel.font = HEL_12;
    
    searchTipLabel.text = @"查询条件";
    
    [searchTipView addSubview:searchTipLabel];
    
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth-30-5, 5, 30, 20)];
    
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    
    moreButton.titleLabel.font = HEL_12;
    
    [moreButton setTitleColor:UIColorFromRGB(0x184356) forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [moreButton addTarget:self action:@selector(clickMoreSearchConditions) forControlEvents:UIControlEventTouchUpInside];
    
    //    [searchTipView addSubview:moreButton];
    
    
    //开始时间
    
    UILabel *startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(searchTipView.frame)+5, 70, 30)];
    startTimeLabel.font = HEL_14;
    startTimeLabel.textColor = [UIColor blackColor];
    startTimeLabel.textAlignment = NSTextAlignmentRight;
    startTimeLabel.backgroundColor = [UIColor clearColor];
    startTimeLabel.text = @"开始时间：";
    [_headView addSubview:startTimeLabel];
    
    UIButton *startTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth - 15-30, CGRectGetMinY(startTimeLabel.frame), 30, 30)];
    [startTimeButton setImage:[UIImage imageNamed:@"starttime.png"] forState:UIControlStateNormal];
    [startTimeButton addTarget:self  action:@selector(clickStartTimeButton) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:startTimeButton];
    
    
    
    
    _startTimeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startTimeLabel.frame), startTimeLabel.frame.origin.y , kMainScreenWidth-CGRectGetMaxX(startTimeLabel.frame)- (15+startTimeButton.frame.size.width)-10, 30)];
    _startTimeField.placeholder=@"请输入开始时间";
    _startTimeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _startTimeField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _startTimeField.font = HEL_15;
    _startTimeField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _startTimeField.layer.cornerRadius = 4.0;
    _startTimeField.layer.borderWidth = 1.0;
    _startTimeField.delegate = self;
    _startTimeField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_headView addSubview:_startTimeField];
    
    
    
    UIToolbar *toolBar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
    toolBar1.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:236.0/255.0 alpha:1];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickStartTimeDatePicker)];
    
    toolBar1.items = [NSArray arrayWithObject:right1];
    
    _startTimeDatePicker=[[UIDatePicker alloc]init];
    _startTimeDatePicker.frame=CGRectMake(0, self.view.frame.size.height, kMainScreenWidth, 216);
    _startTimeDatePicker.backgroundColor = UIColorFromRGB(0xEFEFEF);
    _startTimeDatePicker.datePickerMode=UIDatePickerModeDateAndTime;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    _startTimeDatePicker.locale = locale;
    
    [_startTimeDatePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];//中国是标准加8
    [_startTimeDatePicker addTarget:self action:@selector(startTimeDateChanged) forControlEvents:UIControlEventValueChanged];
    _startTimeField.inputView=_startTimeDatePicker;
    _startTimeField.inputAccessoryView=toolBar1;
    
    //end
    
    //结束时间
    
    
    UILabel *endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(startTimeLabel.frame)+5, 70, 30)];
    endTimeLabel.font = HEL_14;
    endTimeLabel.textColor = [UIColor blackColor];
    endTimeLabel.textAlignment = NSTextAlignmentRight;
    endTimeLabel.backgroundColor = [UIColor clearColor];
    endTimeLabel.text = @"结束时间：";
    [_headView addSubview:endTimeLabel];
    
    UIButton *endTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth - 15-30, CGRectGetMinY(endTimeLabel.frame), 30, 30)];
    [endTimeButton setImage:[UIImage imageNamed:@"endtime.png"] forState:UIControlStateNormal];
    [endTimeButton addTarget:self  action:@selector(clickEndTimeButton) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:endTimeButton];
    
    _endTimeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(endTimeLabel.frame), endTimeLabel.frame.origin.y , kMainScreenWidth-CGRectGetMaxX(endTimeLabel.frame)- (15+endTimeButton.frame.size.width)-10, 30)];
    _endTimeField.placeholder=@"请输入结束时间";
    _endTimeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _endTimeField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _endTimeField.font = HEL_15;
    _endTimeField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _endTimeField.layer.cornerRadius = 4.0;
    _endTimeField.layer.borderWidth = 1.0;
    _endTimeField.delegate = self;
    _endTimeField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_headView addSubview:_endTimeField];
    
    
    UIToolbar *toolBarEnd = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
    toolBar1.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:236.0/255.0 alpha:1];
    UIBarButtonItem *rightEnd = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickEndTimeDatePicker)];
    
    toolBarEnd.items = [NSArray arrayWithObject:rightEnd];
    
    _endTimeDatePicker=[[UIDatePicker alloc]init];
    _endTimeDatePicker.frame=CGRectMake(0, self.view.frame.size.height, kMainScreenWidth, 216);
    _endTimeDatePicker.backgroundColor = UIColorFromRGB(0xEFEFEF);
    _endTimeDatePicker.datePickerMode=UIDatePickerModeDateAndTime;
    _endTimeDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];;
    
    [_endTimeDatePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];//中国是标准加8
    [_endTimeDatePicker addTarget:self action:@selector(endTimeDateChanged) forControlEvents:UIControlEventValueChanged];
    _endTimeField.inputView=_endTimeDatePicker;
    _endTimeField.inputAccessoryView=toolBarEnd;
    
    //end
    
    
    //车辆号
    
    _carNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(endTimeLabel.frame)+5, 70, 30)];
    _carNumberLabel.font = HEL_14;
    _carNumberLabel.textColor = [UIColor blackColor];
    _carNumberLabel.textAlignment = NSTextAlignmentRight;
    _carNumberLabel.backgroundColor = [UIColor clearColor];
    _carNumberLabel.text = @"项目号：";
    _carNumberLabel.hidden = !expandMoreSearchCondition;
    [_headView addSubview:_carNumberLabel];
    
    
    _carNumberField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_carNumberLabel.frame), _carNumberLabel.frame.origin.y , kMainScreenWidth-CGRectGetMaxX(_carNumberLabel.frame)-10, 30)];
    _carNumberField.placeholder=@"请输入项目号";
    _carNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _carNumberField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _carNumberField.font = HEL_15;
    _carNumberField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _carNumberField.layer.cornerRadius = 4.0;
    _carNumberField.layer.borderWidth = 1.0;
    _carNumberField.delegate = self;
    _carNumberField.borderStyle = UITextBorderStyleRoundedRect;
    _carNumberField.hidden = !expandMoreSearchCondition;
    [_headView addSubview:_carNumberField];
    
    //车辆类型
    _carTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_carNumberLabel.frame)+5, 70, 30)];
    _carTypeLabel.font = HEL_14;
    _carTypeLabel.textColor = [UIColor blackColor];
    _carTypeLabel.textAlignment = NSTextAlignmentRight;
    _carTypeLabel.backgroundColor = [UIColor clearColor];
    _carTypeLabel.text = @"实际用车人：";
    _carTypeLabel.hidden = !expandMoreSearchCondition;
    [_headView addSubview:_carTypeLabel];
    
    
    _carTypeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_carTypeLabel.frame), _carTypeLabel.frame.origin.y , kMainScreenWidth-CGRectGetMaxX(_carTypeLabel.frame)-10, 30)];
    _carTypeField.placeholder=@"请输入实际用车人";
    _carTypeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _carTypeField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _carTypeField.font = HEL_15;
    _carTypeField.layer.borderColor=[UIColorFromRGB(0xcccccc) CGColor];
    _carTypeField.layer.cornerRadius = 4.0;
    _carTypeField.layer.borderWidth = 1.0;
    _carTypeField.delegate = self;
    _carTypeField.borderStyle = UITextBorderStyleRoundedRect;
    _carTypeField.hidden = !expandMoreSearchCondition;
    [_headView addSubview:_carTypeField];
    
    
    
}

-(void)initStartSearchView
{
    _startSearchBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kMainScreenWidth, 35)];
    
    _startSearchBackGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_startSearchBackGroundView];
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, _startSearchBackGroundView.frame.size.width-20, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
    
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"查询" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickStartSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [_startSearchBackGroundView addSubview:startSearchButton];
    
    
    
}

-(void)initRefreshView
{
    [_tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    
    [_tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    [self tableViewMJRefresh:_tableView];
}




-(void)obtainDefaultDataWithUpPull:(BOOL)upPull
{
    //得到当前选中的时间
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"queryBeginTime",@"queryEndTime",@"queryUserId",@"pageSize",@"pageNum"];
    
    
    NSString *currentPage = [NSString stringWithFormat:@"%d",_currentDoctorPageIndex];
    
    
    NSString *startTimeStr = _startTimeField.text;
    
    if ([NSString isBlankString:startTimeStr])
    {
        startTimeStr = @"";
    }
    
    NSString *endTimeStr = _endTimeField.text;
    if ([NSString isBlankString:endTimeStr])
    {
        endTimeStr = @"";
    }
  
    NSArray *valueArray = @[startTimeStr,endTimeStr,[HXUserModel shareInstance].userId,@"20",currentPage];
    
    [CLYCCoreBizHttpRequest complainListWithBlock:^(NSMutableArray *listArry, NSString *retcode, NSString *retmessage, NSError *error, NSString *totalNum) {
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




#pragma mark - 点击更多

-(void)clickMoreSearchConditions
{
    expandMoreSearchCondition = ! expandMoreSearchCondition;
    
    if (expandMoreSearchCondition)
    {
        _headView.frame = CGRectMake(0, 0, kMainScreenWidth, 180);
    }
    else
    {
        _headView.frame = CGRectMake(0, 0, kMainScreenWidth, 110);
        
    }
    
    _startSearchBackGroundView.frame =CGRectMake(0, CGRectGetMaxY(_headView.frame), kMainScreenWidth, 32);
    
    _tableView.frame=CGRectMake(0,CGRectGetMaxY(_startSearchBackGroundView.frame),kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight);
    
    _carNumberField.hidden = !expandMoreSearchCondition;
    
    _carTypeField.hidden = !expandMoreSearchCondition;
    
    _carNumberLabel.hidden = !expandMoreSearchCondition;
    
    _carTypeLabel.hidden = !expandMoreSearchCondition;
    
    
    
    
    
}

#pragma mark - 点击开始时间 -

-(void)clickStartTimeButton
{
    [_startTimeField becomeFirstResponder];
}

#pragma mark - 点击 开始时间 弹出时间滚轮 完成按钮 -

-(void)clickStartTimeDatePicker
{
    NSDate *currDate=[_startTimeDatePicker date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:currDate ];
    _startTimeField.text=str;
    
    if ([self.view endEditing:NO])
    {
        [_startTimeField resignFirstResponder];
        
        
    }
}

#pragma mark - 开始时间 滚轮方法 -

-(void)startTimeDateChanged
{
    //得到当前选中的时间
    NSDate *currDate=[_startTimeDatePicker date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:currDate ];
    _startTimeField.text=str;
}

#pragma mark - 点击结束时间 按钮-

-(void)clickEndTimeButton
{
    [_endTimeField becomeFirstResponder];
}

#pragma mark - 点击 结束时间 弹出时间滚轮 完成按钮 -

-(void)clickEndTimeDatePicker
{
    NSDate *currDate=[_endTimeDatePicker date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:currDate ];
    _endTimeField.text=str;
    
    
    if ([self.view endEditing:NO])
    {
        [_endTimeField resignFirstResponder];
        
        
    }
}

#pragma mark - 结束时间 滚轮方法 -

-(void)endTimeDateChanged
{
    NSDate *currDate=[_endTimeDatePicker date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:currDate ];
    _endTimeField.text=str;
}


#pragma mark - 发起搜索

-(void)clickStartSearchButton
{
    
    if ([NSString isBlankString:_startTimeField.text])
    {
        
        [self displaySomeInfoWithInfo:@"请输入开始时间" finsh:nil];
        
        return;
        
    }
    
    if ([NSString isBlankString:_endTimeField.text])
    {
        
        [self displaySomeInfoWithInfo:@"请输入结束时间" finsh:nil];
        
        return;
        
    }

    _currentDoctorPageIndex = 0;
    
    [self obtainDefaultDataWithUpPull:NO];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_dataArray count]>0)
    {
        ComplainListModel *model = [_dataArray objectAtIndex:indexPath.row];
      
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"complainCell";
    
    ComplainListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[ComplainListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([_dataArray count]>0)
    {
        ComplainListModel *model = [_dataArray objectAtIndex:indexPath.row];
        [cell setCellContentWithComplainListModel:model];
    }
    
    return cell;
    
    
}


#pragma mark - 下拉刷新 -

-(void)headerRefreshing
{
    _isDownPullLoading = YES;
    
    _currentDoctorPageIndex = 0;
    
    [self obtainDefaultDataWithUpPull:NO];
    
}

#pragma mark - 上拉刷新 -

-(void)footerRefreshing
{
    _isUpPullLoading = YES;
    
    [self obtainDefaultDataWithUpPull:YES];
    
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


-(void)addComplain
{
    SaveComplainViewController *saveMVC = [[SaveComplainViewController alloc]init];
    [self.navigationController pushViewController:saveMVC animated:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
