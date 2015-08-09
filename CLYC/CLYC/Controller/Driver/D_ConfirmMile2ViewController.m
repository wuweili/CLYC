//
//  D_ConfirmMile2ViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "D_ConfirmMile2ViewController.h"
#import "D_ConfirmMile2TableViewCell.h"
#import "CLYCLocationManager.h"

@interface D_ConfirmMile2ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_secondDataArray;
    
    ApplyCarDetailModel *_applyCarModel;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    UIView *_editFootView;
}

@end

@implementation D_ConfirmMile2ViewController

-(id)initWithApplyCarDetailModel:(ApplyCarDetailModel *)model;
{
    self = [super init];
    
    if (self)
    {
        _applyCarModel = model;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification
     object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initData];
    
    [self initTableView];
    
    [self initEditFootView];
    
    [self obtainData];
}

-(void)initUI
{
//    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.title = @"里程确认";
    
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"用车人：",@"用车时间：",@"出发地：",@"目的地：",@"用车部门：",@"项目名称：",@"单价：", nil];
    _secondDataArray = [NSMutableArray arrayWithCapacity:0];
    
    if (!_applyCarModel)
    {
        _applyCarModel = [[ApplyCarDetailModel alloc]init];
    }
    _currentFirstRespondIndexPath = nil;
    
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

-(void)initEditFootView
{
    _editFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 70)];
    
    _editFootView.backgroundColor =UIColorFromRGB(0xf3f3f3);
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, kMainScreenWidth-30, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
    
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [_editFootView addSubview:startSearchButton];
    
    
    
    _tableView.tableFooterView = _editFootView;
    
}

-(void)obtainData
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"appId"];
    NSArray *valueArray = @[_applyCarModel.appId];
    
    [CLYCCoreBizHttpRequest obtainApplyCarDetailWithBlock:^(ApplyCarDetailModel *model, NSString *retcode, NSString *retmessage, NSError *error) {
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            _applyCarModel = model;
            
            if (_applyCarModel.beginMilStatus.integerValue == 0)
            {
                //此时需要司机还未提交里程
                
                
                NSDictionary *dic1 = @{@"mileInfoKey":@"开始里程(公里)：",@"mileInfoValue":_applyCarModel.beginMil};
                
                [_secondDataArray addObject:dic1];
                
            }
            else if (_applyCarModel.beginMilStatus.integerValue == 1)
            {
                //此时需要司机已提交开始里程，但是用户还没有确认
                
                NSDictionary *dic1 = @{@"mileInfoKey":@"开始里程(公里)：",@"mileInfoValue":_applyCarModel.beginMil};
                
                [_secondDataArray addObject:dic1];
                
                _tableView.tableFooterView = nil;
                
            }
            
            else if (_applyCarModel.beginMilStatus.integerValue == 3)
            {
                //未通过
                
                NSDictionary *dic1 = @{@"mileInfoKey":@"开始里程(公里)：",@"mileInfoValue":_applyCarModel.beginMil};
                
                [_secondDataArray addObject:dic1];
                
                NSString *confirmStr = @"";
                if ([_applyCarModel.beginMilStatus isEqualToString:@"1"])
                {
                    confirmStr =@"提交";
                }
                else if ([_applyCarModel.beginMilStatus isEqualToString:@"2"])
                {
                    confirmStr =@"通过";
                }
                else if ([_applyCarModel.beginMilStatus isEqualToString:@"3"])
                {
                    confirmStr =@"未通过";
                }
                
                NSDictionary *dic2 = @{@"mileInfoKey":@"开始里程状态：",@"mileInfoValue":confirmStr};
                
                [_secondDataArray addObject:dic2];
                
                
                if ([NSString isBlankString:_applyCarModel.beginMilRemark])
                {
                    if (_applyCarModel.beginMilStatus.integerValue != 1)
                    {
                        _applyCarModel.beginMilRemark = @"无";
                        
                    }
                    
                }
                
                NSDictionary *dic3 = @{@"mileInfoKey":@"开始里程备注：",@"mileInfoValue":_applyCarModel.beginMilRemark};
                
                [_secondDataArray addObject:dic3];
                
            }
            else if(_applyCarModel.beginMilStatus.integerValue == 2)
            {
                
                //此时说明用户已经确认过且同意开始里程
                
                NSDictionary *dic1 = @{@"mileInfoKey":@"开始里程(公里)：",@"mileInfoValue":_applyCarModel.beginMil};
                
                [_secondDataArray addObject:dic1];
                
                NSString *confirmStr = @"";
                if ([_applyCarModel.beginMilStatus isEqualToString:@"1"])
                {
                    confirmStr =@"提交";
                }
                else if ([_applyCarModel.beginMilStatus isEqualToString:@"2"])
                {
                    confirmStr =@"通过";
                }
                else if ([_applyCarModel.beginMilStatus isEqualToString:@"3"])
                {
                    confirmStr =@"未通过";
                }
                
                NSDictionary *dic2 = @{@"mileInfoKey":@"开始里程状态：",@"mileInfoValue":confirmStr};
                
                [_secondDataArray addObject:dic2];
                
                
                if ([NSString isBlankString:_applyCarModel.beginMilRemark])
                {
                    if (_applyCarModel.beginMilStatus.integerValue != 1)
                    {
                        _applyCarModel.beginMilRemark = @"无";
                        
                    }
                    
                }
                
                NSDictionary *dic3 = @{@"mileInfoKey":@"开始里程备注：",@"mileInfoValue":_applyCarModel.beginMilRemark};
                
                [_secondDataArray addObject:dic3];
                
                
                if (_applyCarModel.finishMilStatus.integerValue ==0)
                {
                    //说明司机还未提交结束里程
                    NSDictionary *dic4 = @{@"mileInfoKey":@"结束里程(公里)：",@"mileInfoValue":_applyCarModel.finishMil};
                    [_secondDataArray addObject:dic4];
                    
                    NSDictionary *dic5 = @{@"mileInfoKey":@"附加里程(公里)：",@"mileInfoValue":_applyCarModel.addMil};
                    [_secondDataArray addObject:dic5];
                    
                    NSDictionary *dic6 = @{@"mileInfoKey":@"出差天数(天)：",@"mileInfoValue":_applyCarModel.driverTraveldays};
                    [_secondDataArray addObject:dic6];
                    
                    
                }
                else if (_applyCarModel.finishMilStatus.integerValue ==1)
                {
                    //说明司机提交结束里程，但是用户还没有确认
                    
                    NSDictionary *dic4 = @{@"mileInfoKey":@"结束里程(公里)：",@"mileInfoValue":_applyCarModel.finishMil};
                    [_secondDataArray addObject:dic4];
                    
                    NSDictionary *dic5 = @{@"mileInfoKey":@"附加里程(公里)：",@"mileInfoValue":_applyCarModel.addMil};
                    [_secondDataArray addObject:dic5];
                    
                    NSDictionary *dic6 = @{@"mileInfoKey":@"出差天数(天)：",@"mileInfoValue":_applyCarModel.driverTraveldays};
                    [_secondDataArray addObject:dic6];
                    
                    _tableView.tableFooterView = nil;
                    
                }
                else if (_applyCarModel.finishMilStatus.integerValue ==3)
                {
                    //说明用户不同意结束里程
                    
                    NSDictionary *dic4 = @{@"mileInfoKey":@"结束里程(公里)：",@"mileInfoValue":_applyCarModel.finishMil};
                    [_secondDataArray addObject:dic4];
                    
                    NSDictionary *dic5 = @{@"mileInfoKey":@"附加里程(公里)：",@"mileInfoValue":_applyCarModel.addMil};
                    [_secondDataArray addObject:dic5];
                    
                    NSString *confirmStr = @"";
                    if ([_applyCarModel.finishMilStatus isEqualToString:@"1"])
                    {
                        confirmStr =@"提交";
                    }
                    else if ([_applyCarModel.finishMilStatus isEqualToString:@"2"])
                    {
                        confirmStr =@"通过";
                    }
                    else if ([_applyCarModel.finishMilStatus isEqualToString:@"3"])
                    {
                        confirmStr =@"未通过";
                    }
                    
                    NSDictionary *dic6 = @{@"mileInfoKey":@"结束里程状态：",@"mileInfoValue":confirmStr};
                    
                    [_secondDataArray addObject:dic6];
                    
                    float realMile = [_applyCarModel.finishMil floatValue] - [_applyCarModel.beginMil floatValue]+[_applyCarModel.addMil floatValue];
                    
                    NSString *realMileStr = [NSString stringWithFormat:@"%.1f",realMile];
                    
                    NSDictionary *dic7 = @{@"mileInfoKey":@"实际里程(公里)：",@"mileInfoValue":realMileStr};
                    
                    [_secondDataArray addObject:dic7];
                    
                    NSDictionary *dic8 = @{@"mileInfoKey":@"结束里程备注：",@"mileInfoValue":_applyCarModel.finishMilRemark};
                    
                    [_secondDataArray addObject:dic8];
                    
                    NSDictionary *dic9 = @{@"mileInfoKey":@"出差天数(天)：",@"mileInfoValue":_applyCarModel.driverTraveldays};
                    [_secondDataArray addObject:dic9];
                    
                }
                else if (_applyCarModel.finishMilStatus.integerValue ==2)
                {
                    //用户同意结束里程
                    
                    NSDictionary *dic4 = @{@"mileInfoKey":@"结束里程(公里)：",@"mileInfoValue":_applyCarModel.finishMil};
                    [_secondDataArray addObject:dic4];
                    
                    NSDictionary *dic5 = @{@"mileInfoKey":@"附加里程(公里)：",@"mileInfoValue":_applyCarModel.addMil};
                    [_secondDataArray addObject:dic5];
                    
                    NSString *confirmStr = @"";
                    if ([_applyCarModel.finishMilStatus isEqualToString:@"1"])
                    {
                        confirmStr =@"提交";
                    }
                    else if ([_applyCarModel.finishMilStatus isEqualToString:@"2"])
                    {
                        confirmStr =@"通过";
                    }
                    else if ([_applyCarModel.finishMilStatus isEqualToString:@"3"])
                    {
                        confirmStr =@"未通过";
                    }
                    
                    NSDictionary *dic6 = @{@"mileInfoKey":@"结束里程状态：",@"mileInfoValue":confirmStr};
                    
                    [_secondDataArray addObject:dic6];
                    
                    float realMile = [_applyCarModel.finishMil floatValue] - [_applyCarModel.beginMil floatValue]+[_applyCarModel.addMil floatValue];
                    
                    NSString *realMileStr = [NSString stringWithFormat:@"%.1f",realMile];
                    
                    NSDictionary *dic7 = @{@"mileInfoKey":@"实际里程(公里)：",@"mileInfoValue":realMileStr};
                    
                    [_secondDataArray addObject:dic7];
                    
                    NSDictionary *dic8 = @{@"mileInfoKey":@"结束里程备注：",@"mileInfoValue":_applyCarModel.finishMilRemark};
                    
                    [_secondDataArray addObject:dic8];
                    
                    NSDictionary *dic9 = @{@"mileInfoKey":@"出差天数(天)：",@"mileInfoValue":_applyCarModel.driverTraveldays};
                    [_secondDataArray addObject:dic9];
                    
                    _tableView.tableFooterView = nil;
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
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
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return [self heightForOneSectionRowWitUITextViewText:_applyCarModel.carAppUserName] +14;
        }
        else if (indexPath.row == 1)
        {
            NSString *timeStr = [NSString stringWithFormat:@"%@至%@",_applyCarModel.beginTime,_applyCarModel.endTime];
            return [self heightForOneSectionRowWitUITextViewText:timeStr] +14;
        }
        else if (indexPath.row == 2)
        {
            //出发地
            return [self heightForOneSectionRowWitUITextViewText:_applyCarModel.beginAdrr] +14;
        }
        else if (indexPath.row == 3)
        {
            //目的地
            
            return [self heightForOneSectionRowWitUITextViewText:_applyCarModel.endAdrr] +14;
        }
        else if (indexPath.row == 4)
        {
            //用车部门
            return [self heightForOneSectionRowWitUITextViewText:_applyCarModel.deptModel.deptName] +14;
            
        }
        else if(indexPath.row == 5)
        {
            //项目名称
            return [self heightForOneSectionRowWitUITextViewText:_applyCarModel.projectModel.projectName] +14;
        }
        else
        {
            //单价
            return [self heightForOneSectionRowWitUITextViewText:_applyCarModel.price] +14;
            
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            //开始里程
            return 44;
            
        }
        else if (indexPath.row == 1)
        {
            //开始里程状态
            return 44;
        }
        else if (indexPath.row == 2)
        {
            //开始里程备注
            return [self heightForSecondSectionSectionRowWitUITextViewText:_applyCarModel.beginMilRemark]+14;
        }
        else if (indexPath.row == 3)
        {
            //结束里程
            return 44;
        }
        else if (indexPath.row == 4)
        {
            //加价里程
            return 44;
            
        }
        else if (indexPath.row == 5)
        {
            //结束里程状态 或者出差天数
            return 44;
        }
        else if (indexPath.row == 6)
        {
            //实际里程
            return 44;
        }
        else if (indexPath.row == 7)
        {
            //结束里程备注
            return [self heightForSecondSectionSectionRowWitUITextViewText:_applyCarModel.finishMilRemark]+14;
            
        }
        else
        {
            //出差天数
            return 44;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *sectionHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
        sectionHeadView.backgroundColor = UIColorFromRGB(0xf3f3f3);
        
        UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kMainScreenWidth-10, 30)];
        sectionLabel.backgroundColor =UIColorFromRGB(0xf3f3f3);
        sectionLabel.textAlignment = NSTextAlignmentLeft;
        sectionLabel.text = @"约车信息";
        sectionLabel.font = HEL_13;
        [sectionHeadView addSubview:sectionLabel];
        return sectionHeadView;
    }
    else
    {
        
        UIView *sectionHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
        sectionHeadView.backgroundColor = UIColorFromRGB(0xf3f3f3);
        
        UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
        sectionLabel.backgroundColor =UIColorFromRGB(0xf3f3f3);
        sectionLabel.textAlignment = NSTextAlignmentLeft;
        sectionLabel.text = @"里程信息";
        sectionLabel.font = HEL_13;
        sectionLabel.backgroundColor = [UIColor clearColor];
        [sectionHeadView addSubview:sectionLabel];
        
        UILabel *section2Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sectionLabel.frame), 0, kMainScreenWidth-10-CGRectGetMaxX(sectionLabel.frame), 30)];
        section2Label.backgroundColor =UIColorFromRGB(0xf3f3f3);
        section2Label.textAlignment = NSTextAlignmentLeft;
        section2Label.font = HEL_11;
        section2Label.backgroundColor = [UIColor clearColor];
        section2Label.textColor = UIColorFromRGB(0xf48871);
        [sectionHeadView addSubview:section2Label];
        
        NSString *tipString= @"";
        
        if (_applyCarModel.beginMilStatus.integerValue == 0)
        {
            //此时需要司机还未提交开始里程
            
            tipString = @"(请填写提交开始里程)";
        }
        else if (_applyCarModel.beginMilStatus.integerValue == 1)
        {
            //此时需要司机已提交开始里程，但是用户还没有确认
            tipString = @"(开始里程已提交，等待用车人确认)";
            
        }
        
        else if (_applyCarModel.beginMilStatus.integerValue == 3)
        {
            //未通过
            tipString = @"(用车人不同意开始里程，请重填)";
          
            
        }
        else if(_applyCarModel.beginMilStatus.integerValue == 2)
        {
            
            //此时说明用户已经确认过且同意开始里程
            
            
            
            if (_applyCarModel.finishMilStatus.integerValue ==0)
            {
                //说明司机还未提交结束里程
               tipString = @"(请填写提交结束里程(附加里程不能大于80))";
                
                
            }
            else if (_applyCarModel.finishMilStatus.integerValue ==1)
            {
                //说明司机提交结束里程，但是用户还没有确认
                tipString = @"(结束里程(附加里程)已提交，等待用车人确认)";
              
            }
            else if (_applyCarModel.finishMilStatus.integerValue ==3)
            {
                //说明用户不同意结束里程
                tipString = @"(用车人不同意结束里程(附加里程)，请重填)";
               
                
            }
            else if (_applyCarModel.finishMilStatus.integerValue ==2)
            {
                //用户同意结束里程
                
            }
        
        }
        
        section2Label.text =tipString;
        
        
        
        return sectionHeadView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_secondDataArray && [_secondDataArray count]>0)
    {
        return 2;
    }
    
    else
        
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_dataArray count];
    }
    else
    {
        return [_secondDataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSString *identifier = [NSString stringWithFormat:@"detailInfo%ld%ld",(long)indexPath.section,(long)indexPath.row];
        D_ConfirmMile2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[D_ConfirmMile2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([_dataArray count]>0)
        {
            cell.cellTitleLabel.text = [_dataArray objectAtIndex:indexPath.row];
        }
        
        if (cell.cellTextView)
        {
            cell.cellTextView.editable = NO;
            cell.cellTextView.userInteractionEnabled = NO;
        }
        
        NSString *celleStr;
        
        if (indexPath.row == 0)
        {
            
            celleStr = _applyCarModel.carAppUserName;
        }
        else if (indexPath.row == 1)
        {
            NSString *timeStr = [NSString stringWithFormat:@"%@至%@",_applyCarModel.beginTime,_applyCarModel.endTime];
            celleStr = timeStr;
            
        }
        else if (indexPath.row == 2)
        {
            celleStr = _applyCarModel.beginAdrr;
        }
        else if (indexPath.row == 3)
        {
            celleStr = _applyCarModel.endAdrr;
        }
        else if (indexPath.row == 4)
        {
            celleStr = _applyCarModel.deptModel.deptName;
        }
        else if (indexPath.row == 5)
        {
            celleStr = _applyCarModel.projectModel.projectName;
        }
        else
        {
            celleStr = _applyCarModel.price;

        }
                
        [cell setContentWithIndexPath:indexPath andContentStr:celleStr];
        
        return cell;
    }
    else
    {
        NSString *identifier = [NSString stringWithFormat:@"detailInfo%ld%ld",(long)indexPath.section,(long)indexPath.row];
        D_ConfirmMile2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[D_ConfirmMile2TableViewCell alloc]initMileInfoWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([_secondDataArray count]>0)
        {
            NSDictionary *dic =[_secondDataArray objectAtIndex:indexPath.row];
            
            cell.cellTitleLabel.text = dic[@"mileInfoKey"];
            
            NSString *celleStr = dic[@"mileInfoValue"];
            
            [cell setContentWithIndexPath:indexPath andContentStr:celleStr];
        }
        
       
        if (_applyCarModel.beginMilStatus.integerValue == 0)
        {
            //此时需要司机还未提交开始里程
            
            if (indexPath.row == 0)
            {
                cell.cellTextView.editable = YES;
                cell.cellTextView.userInteractionEnabled = YES;
                cell.cellTextView.delegate = self;
                cell.cellTextView.tag = 2000;
            }
           
            
        }
        else if (_applyCarModel.beginMilStatus.integerValue == 3)
        {
            //未通过
            
            if (indexPath.row == 0)
            {
                cell.cellTextView.editable = YES;
                cell.cellTextView.userInteractionEnabled = YES;
                cell.cellTextView.delegate = self;
                cell.cellTextView.tag = 2000;
            }
  
        }
        else if(_applyCarModel.beginMilStatus.integerValue == 2)
        {
            
            //此时说明用户已经确认过且同意开始里程
            
            if (_applyCarModel.finishMilStatus.integerValue ==0)
            {
                //说明司机还未提交结束里程
                if (indexPath.row == 3)
                {
                    cell.cellTextView.editable = YES;
                    cell.cellTextView.userInteractionEnabled = YES;
                    cell.cellTextView.delegate = self;
                    cell.cellTextView.tag = 2003;
                }
                else if (indexPath.row == 4)
                {
                    cell.cellTextView.editable = YES;
                    cell.cellTextView.userInteractionEnabled = YES;
                    cell.cellTextView.delegate = self;
                    cell.cellTextView.tag = 2004;
                }
                else if(indexPath.row == 5)
                {
                    //出差天数
                    cell.cellTextView.editable = YES;
                    cell.cellTextView.userInteractionEnabled = YES;
                    cell.cellTextView.delegate = self;
                    cell.cellTextView.tag = 2005;
                }
                
            }
            else if (_applyCarModel.finishMilStatus.integerValue ==3)
            {
                //说明用户不同意结束里程
                
                if (indexPath.row == 3)
                {
                    cell.cellTextView.editable = YES;
                    cell.cellTextView.userInteractionEnabled = YES;
                    cell.cellTextView.delegate = self;
                    cell.cellTextView.tag = 2003;
                }
                else if (indexPath.row == 4)
                {
                    cell.cellTextView.editable = YES;
                    cell.cellTextView.userInteractionEnabled = YES;
                    cell.cellTextView.delegate = self;
                    cell.cellTextView.tag = 2004;
                }
                else if (indexPath.row == 8)
                {
                    cell.cellTextView.editable = YES;
                    cell.cellTextView.userInteractionEnabled = YES;
                    cell.cellTextView.delegate = self;
                    cell.cellTextView.tag = 2008;
                }
         
            }
            else if (_applyCarModel.finishMilStatus.integerValue ==2)
            {
                //用户同意结束里程
            }
        }
        return cell;
    }
}


-(CGFloat)heightForOneSectionRowWitUITextViewText:(NSString  *)text
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(kMainScreenWidth-25-2-95 - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:HEL_14 constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    if (fHeight<30)
    {
        fHeight = 30;
    }
    return fHeight;
}

-(CGFloat)heightForSecondSectionSectionRowWitUITextViewText:(NSString  *)text
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(kMainScreenWidth - 10-2-105  - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:HEL_14 constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    if (fHeight<30)
    {
        fHeight = 30;
    }
    return fHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIKeyboardNotification-
- (void) handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    NSDictionary *userInfo = [paramNotification userInfo];
    
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(window.frame, keyboardEndRect);
    CGFloat bottomInset = intersectionOfKeyboardRectAndWindowRect.size.height;
    _tableView.contentInset = UIEdgeInsetsMake(0.0f,
                                               0.0f,
                                               bottomInset,
                                               0.0f);
    
    [UIView commitAnimations];
    
    if (_currentFirstRespondIndexPath != nil)
    {
        [_tableView scrollToRowAtIndexPath:_currentFirstRespondIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
}

- (void) handleKeyboardWillHide:(NSNotification *)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject =[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]; NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve]; [animationDurationObject getValue:&animationDuration]; [keyboardEndRectObject getValue:&keyboardEndRect];
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    _tableView.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];
    
    
    
    //    [_detailInfoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:13 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(void)moveKeyBoardDown
{
    NSInteger numberOfCells = [_tableView.dataSource tableView:_tableView numberOfRowsInSection:1];
    
    for (NSInteger counter = 0;counter < numberOfCells;counter++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:counter inSection:1];
        
        D_ConfirmMile2TableViewCell *cell = (D_ConfirmMile2TableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.cellTextView)
        {
            [cell.cellTextView resignFirstResponder];
        }
        
    }
    
}

-(void)unEnableAllTextView
{
    NSInteger numberOfCells = [_tableView.dataSource tableView:_tableView numberOfRowsInSection:1];
    
    for (NSInteger counter = 0;counter < numberOfCells;counter++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:counter inSection:1];
        
        D_ConfirmMile2TableViewCell *cell = (D_ConfirmMile2TableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.cellTextView)
        {
            [cell.cellTextView resignFirstResponder];
            cell.cellTextView.userInteractionEnabled = NO;
        }
        
    }
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textView.tag-2000 inSection:1];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textView becomeFirstResponder];
    
}



- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [textView resignFirstResponder];
    if (textView.tag == 2000)
    {
        _applyCarModel.beginMil =textView.text;
        
        NSDictionary *dic0 = @{@"mileInfoKey":@"开始里程(公里)：",@"mileInfoValue":_applyCarModel.beginMil};
        
        [_secondDataArray replaceObjectAtIndex:0 withObject:dic0];
    }
    else if (textView.tag == 2003)
    {
        _applyCarModel.finishMil = textView.text;
        
        NSDictionary *dic3 = @{@"mileInfoKey":@"结束里程(公里)：",@"mileInfoValue":_applyCarModel.finishMil};
      
        [_secondDataArray replaceObjectAtIndex:3 withObject:dic3];
        
    }
    else if (textView.tag == 2004)
    {
        _applyCarModel.addMil = textView.text;
        
        NSDictionary *dic4 = @{@"mileInfoKey":@"附加里程(公里)：",@"mileInfoValue":_applyCarModel.addMil};
        
        [_secondDataArray replaceObjectAtIndex:4 withObject:dic4];
        
    }
    else if (textView.tag == 2005)
    {
        _applyCarModel.driverTraveldays =textView.text;
        
        NSDictionary *dic5 = @{@"mileInfoKey":@"出差天数(天)：",@"mileInfoValue":_applyCarModel.driverTraveldays};
        [_secondDataArray replaceObjectAtIndex:5 withObject:dic5];
    }
    else if (textView.tag == 2008)
    {
        _applyCarModel.driverTraveldays =textView.text;
        
        NSDictionary *dic8 = @{@"mileInfoKey":@"出差天数(天)：",@"mileInfoValue":_applyCarModel.driverTraveldays};
        [_secondDataArray replaceObjectAtIndex:8 withObject:dic8];
    }
    
    [self reloadRowsWithRowTag:textView.tag];
}

-(void)reloadRowsWithRowTag:(NSInteger)tag
{
    
    //    [_detailInfoTableView reloadData];
    
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:tag-2000 inSection:1];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
}

#pragma mark - 点击提交按钮-
-(void)clickCommitButton
{
    [self moveKeyBoardDown];
    
    if (_applyCarModel.beginMilStatus.intValue ==0 || _applyCarModel.beginMilStatus.intValue ==3)
    {
        
        
        if (_applyCarModel.beginMil.doubleValue <0)
        {
            [self displaySomeInfoWithInfo:@"请输入合理的开始里程" finsh:nil];
            
            return;
        }
        

        [self initMBHudWithTitle:nil];
        //开始里程提交状态
        NSArray *keyArray = @[@"appId",@"beginMil",@"price"];
        
        NSString *beginMileValueStr = [NSString getFormatStr:_applyCarModel.beginMil];
        _applyCarModel.beginMil =beginMileValueStr;
        
        NSArray *valueArray = @[_applyCarModel.appId,_applyCarModel.beginMil,_applyCarModel.price];
        
        [CLYCCoreBizHttpRequest driverCommitBeginMileWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
            
            
            if ([retcode isEqualToString:YB_HTTP_CODE_OK])
            {
                [self stopMBHudAndNSTimerWithmsg:@"提交操作成功" finsh:nil];
           
                if (![NSString isBlankString:_applyCarModel.appId])
                {
                    [[NSUserDefaults standardUserDefaults ]setValue:_applyCarModel.appId forKey:CY_APPCAR_ID];
                    [[NSUserDefaults standardUserDefaults] synchronize];                    
                    
                    [[CLYCLocationManager shareInstance] startLocation];
                }
                
                _tableView.tableFooterView = nil;
                
                [_tableView reloadData];
                
                [self unEnableAllTextView];
            }
            else
            {
                [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
            }
            
            
        } keyArray:keyArray valueArray:valueArray];
        
    }
    else if (_applyCarModel.finishMilStatus.intValue == 0|| _applyCarModel.finishMilStatus.intValue ==3)
    {
        if (_applyCarModel.addMil.integerValue >80)
        {
            [self displaySomeInfoWithInfo:@"附加里程不能大于80" finsh:nil];
            
            return;
        }
 
        //结束里程提交状态
        [self initMBHudWithTitle:nil];
        
        NSArray *keyArray = @[@"appId",@"finishMil",@"addMil",@"driverTravelDays"];
        
        NSString *finishMileValueStr =[NSString getFormatStr:_applyCarModel.finishMil] ;
        _applyCarModel.finishMil =finishMileValueStr;
        
        NSString *addMileValueStr =[NSString getFormatStr:_applyCarModel.addMil] ;
        _applyCarModel.addMil =addMileValueStr;
        
        
        NSString *driverTraveValueStr =[NSString getFormatStr:_applyCarModel.driverTraveldays] ;
        _applyCarModel.driverTraveldays =driverTraveValueStr;
        
        
        

        NSArray *valueArray = @[_applyCarModel.appId,_applyCarModel.finishMil,_applyCarModel.addMil,_applyCarModel.driverTraveldays];
        
        [CLYCCoreBizHttpRequest driverCommitFinishMileWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
            if ([retcode isEqualToString:YB_HTTP_CODE_OK])
            {
                [self stopMBHudAndNSTimerWithmsg:@"提交操作成功" finsh:nil];
                
                if (![NSString isBlankString:_applyCarModel.appId])
                {
                    [[NSUserDefaults standardUserDefaults ]removeObjectForKey:CY_APPCAR_ID];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [[CLYCLocationManager shareInstance] stopLocationTimer];
                }
                
                _tableView.tableFooterView = nil;
                
                [_tableView reloadData];
                
                [self unEnableAllTextView];
            }
            else
            {
                [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
            }
        } keyArray:keyArray valueArray:valueArray];
  
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
