//
//  SelecteCarViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelecteCarViewController.h"
#import "SelectCarTableViewCell.h"

@interface SelecteCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    SelectCarBlock _selectCarBlock;
    
    SelectCarInfoModel *_selectedCarModel;
    
    NSString *_beginTime;
    
    NSString *_endTime;
    
}

@end

@implementation SelecteCarViewController

-(void)clickLeftNavMenu
{
    if (_selectCarBlock)
    {
        _selectCarBlock(_selectedCarModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(id)initWithDefaultSelectedCarModel:(SelectCarInfoModel *)selectedCarModel beginTime:(NSString *)beginTime endTime:(NSString *)endTime selectCarBlock:(SelectCarBlock )block
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择车辆";
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    
    [self initTableView];
    
    [self obtainData];
    
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
    if ([NSString isBlankString:_beginTime])
    {
        _beginTime = @"";
        
    }
    
    if ([NSString isBlankString:_endTime])
    {
        _endTime = @"";
    }
    
    NSArray *keyArray = @[@"queryCarCode",@"queryCarModelId",@"queryBeginTime",@"queryEndTime",@"pageSize",@"pageNum"];
    
    NSArray *valueArray = @[@"",@"",_beginTime,_endTime,@"20",@"0"];
    
    [_dataArray removeAllObjects];
    
    [self searchCarWithKeyArray:keyArray valueArray:valueArray];
}

-(void)searchCarWithKeyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray
{
    
    [self initMBHudWithTitle:nil];
    
    [CLYCCoreBizHttpRequest selectCarInfoListWithBlock:^(NSMutableArray *ListArry, NSString *retcode, NSString *retmessage, NSError *error,NSString *totalNum) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            [_dataArray addObjectsFromArray:ListArry];

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
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"ApplyCarCell";
    
    SelectCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[SelectCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([_dataArray count]>0)
    {
        SelectCarInfoModel *model = [_dataArray objectAtIndex:indexPath.row];
        [cell setCellContentWithSelectedModel:model];
  
    }
    
    return cell;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedCarModel = [_dataArray objectAtIndex:indexPath.row];
    
    if (_selectCarBlock)
    {
        _selectCarBlock(_selectedCarModel);
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
