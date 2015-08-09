//
//  EditApplyCarViewController.m
//  CLYC
//
//  Created by weili.wu on 15/7/24.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "EditApplyCarViewController.h"
#import "SaveApplyCarTableViewCell.h"
#import "SelecteCarViewController.h"
#import "SelectDeptmentViewController.h"
#import "SelectProjectViewController.h"
#import "DateFormate.h"
#import "SaveApplyCarViewController.h"

@interface EditApplyCarViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_secondDataArray;
    
    ApplyCarDetailModel *_applyCarModel;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    UIView *_editFootView;
    UIView *_cancleFootView;
    
    

}

@end

@implementation EditApplyCarViewController

-(id)initWithApplyCarDetailModel:(ApplyCarDetailModel *)model;
{
    self = [super init];
    
    if (self)
    {
        _applyCarModel = model;
    }
    
    return self;
}

-(void)clickLeftNavMenu
{
    NSArray *array = self.navigationController.viewControllers;
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:array];
    
    for (int index = 0; index < [resultArray count];index ++)
    {
        UIViewController *temp = [resultArray objectAtIndex:index];
        if ([temp isKindOfClass:[SaveApplyCarViewController class]])
        {
            [resultArray removeObjectAtIndex:index];
            break;
        }
        
    }
    [self.navigationController setViewControllers:resultArray animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    
    [self initTableView];
    [self initEditFootView];
    [self initCancleFootView];
    
    [self obtainData];
    
}

-(void)initUI
{
//    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.title = @"约车申请";
    
    [IMUnitsMethods drawTheRightBarBtn:self function:@selector(updateApplyCarStatus) btnTitle:@"提交" bgImage:nil];
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"用车时间：",@"车牌号：",@"用车部门：",@"项目名称：",@"出发地：",@"目的地：",@"车辆用途：",@"实际用车人：",@"单价：", nil];
    
    if (!_applyCarModel)
    {
        _applyCarModel = [[ApplyCarDetailModel alloc]init];
    }
    
    _secondDataArray = [NSMutableArray arrayWithCapacity:0];
    
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
//    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
//    {
//        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 97, 0, 0)];
//    }
    
    
    [self.view addSubview:_tableView];
}

-(void)initEditFootView
{
    _editFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    
    _editFootView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, kMainScreenWidth-30, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
    
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"修改" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickEditButton) forControlEvents:UIControlEventTouchUpInside];
    [_editFootView addSubview:startSearchButton];
    
    _tableView.tableFooterView = _editFootView;
    
}

-(void)initCancleFootView
{
    _cancleFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    
    _cancleFootView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, kMainScreenWidth-30, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
    
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickCancleButton) forControlEvents:UIControlEventTouchUpInside];
    [_cancleFootView addSubview:startSearchButton];
    
    
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
            
            if (_applyCarModel.status.integerValue ==1 )
            {
//                NSString *currentTime = [NSString stringWithFormat:@"%lld",(long long)[[NSDate date]timeIntervalSince1970]*1000];
                
                NSString *currentTime = [DateFormate getTimeIntervalFromTimeStr:_applyCarModel.systemTime];
                
                NSString *appBeginTime = [DateFormate getTimeIntervalFromTimeStr:_applyCarModel.beginTime ];
                
                NSInteger residualDays = appBeginTime.longLongValue - currentTime.longLongValue;
                
                if (residualDays >0)
                {
                    _tableView.tableFooterView = nil;
                    self.navigationItem.rightBarButtonItem = nil;
                    _tableView.tableFooterView = _cancleFootView;
                    
                }
                else
                {
                    
                    _tableView.tableFooterView = nil;
                    self.navigationItem.rightBarButtonItem = nil;
                }
                
            }
            else if (_applyCarModel.status.integerValue != 0)
            {
                _tableView.tableFooterView = nil;
                self.navigationItem.rightBarButtonItem = nil;
            }
            
            
            if (_applyCarModel.beginMilStatus.integerValue != 0 )
            {
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
                
                
                NSDictionary *dic3 = @{@"mileInfoKey":@"开始里程备注：",@"mileInfoValue":_applyCarModel.beginMilRemark};
                
                [_secondDataArray addObject:dic3];
                
            }
           
            
            if (_applyCarModel.finishMilStatus.integerValue !=0)
            {
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
            NSString *timeStr = [NSString stringWithFormat:@"%@至%@",_applyCarModel.beginTime,_applyCarModel.endTime];
            return [self heightForRowWitUITextViewText:timeStr] +14;
        }
        else if (indexPath.row == 1)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.selectedCarModel.carCode] +14;
        }
        else if (indexPath.row == 2)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.deptModel.deptName] +14;
            
        }
        else if (indexPath.row == 3)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.projectModel.projectName] +14;
        }
        else if (indexPath.row == 4)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.beginAdrr] +14;
        }
        else if (indexPath.row == 5)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.endAdrr] +14;
            
        }
        else if (indexPath.row == 6)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.carUse] +14;
            
        }
        else if (indexPath.row == 7)
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.carAppUserName] +14;
            
        }
        else
        {
            return [self heightForRowWitUITextViewText:_applyCarModel.price] +14;
        }
    }
    else
    {
        
        if ([_secondDataArray count]>0)
        {
            NSDictionary *dic =[_secondDataArray objectAtIndex:indexPath.row];
            
            NSString *celleStr = dic[@"mileInfoValue"];
            return [self heightForSecondRowWitUITextViewText:celleStr] +14;
        }
        else
        {
            return 0;
        }
        
        
        return 44;
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
        
        UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kMainScreenWidth-10, 30)];
        sectionLabel.backgroundColor =UIColorFromRGB(0xf3f3f3);
        sectionLabel.textAlignment = NSTextAlignmentLeft;
        sectionLabel.text = @"里程信息";
        sectionLabel.font = HEL_13;
        [sectionHeadView addSubview:sectionLabel];
        return sectionHeadView;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1)
        {
            SelecteCarViewController *selectCarMVC = [[SelecteCarViewController alloc]initWithDefaultSelectedCarModel:_applyCarModel.selectedCarModel beginTime:_applyCarModel.beginTime endTime:_applyCarModel.endTime selectCarBlock:^(SelectCarInfoModel *model) {
                
                _applyCarModel.selectedCarModel = model;
                
                _applyCarModel.price = model.price;
                
                [_tableView reloadData];
                
                
            }];
            
            [self.navigationController pushViewController:selectCarMVC animated:YES];
            
        }
        else if (indexPath.row == 2)
        {
            
            SelectDeptmentViewController *selectDeptMVC = [[SelectDeptmentViewController alloc]initWithDefaultSelectedDeptModel:_applyCarModel.deptModel selectDeptBlock:^(DeptListModel *model) {
                _applyCarModel.deptModel = model;
                
                [_tableView reloadData];
                
            }];
            [self.navigationController pushViewController:selectDeptMVC animated:YES];
            
        }
        else if (indexPath.row == 3)
        {
            if ( [NSString isBlankString:_applyCarModel.deptModel.deptId ] ) {
                [self displaySomeInfoWithInfo:@"请先选择部门" finsh:nil];
                
                return;
                
            }
            
            SelectProjectViewController *selectProjectMVC = [[SelectProjectViewController alloc]initWithDefaultSelectedProjectModel:_applyCarModel.projectModel depId:_applyCarModel.deptModel.deptId  selectProjectBlock:^(ProjectListModel *model) {
                _applyCarModel.projectModel = model;
                
                [_tableView reloadData];
            }];
            
            [self.navigationController pushViewController:selectProjectMVC animated:YES];
        }
    }
    
    
    
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
        SaveApplyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[SaveApplyCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([_dataArray count]>0)
        {
            cell.cellTitleLabel.text = [_dataArray objectAtIndex:indexPath.row];
        }
        
        if (cell.cellTextView)
        {
            cell.cellTextView.delegate = self;
        }
        
        NSString *celleStr;
        
        if (indexPath.row == 0)
        {
            NSString *timeStr = [NSString stringWithFormat:@"%@至%@",_applyCarModel.beginTime,_applyCarModel.endTime];
            celleStr = timeStr;
        }
        else if (indexPath.row == 1)
        {
            celleStr = _applyCarModel.selectedCarModel.carCode;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 2)
        {
            celleStr = _applyCarModel.deptModel.deptName;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 3)
        {
            celleStr = _applyCarModel.projectModel.projectName;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 4)
        {
            celleStr = _applyCarModel.beginAdrr;
        }
        else if (indexPath.row == 5)
        {
            celleStr = _applyCarModel.endAdrr;
        }
        else if (indexPath.row == 6)
        {
            celleStr = _applyCarModel.carUse;
        }
        else if(indexPath.row == 7)
        {
            celleStr = _applyCarModel.carAppUserName;
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
        SaveApplyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[SaveApplyCarTableViewCell alloc]initMileInfoWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([_secondDataArray count]>0)
        {
            NSDictionary *dic =[_secondDataArray objectAtIndex:indexPath.row];
            
            cell.cellTitleLabel.text = dic[@"mileInfoKey"];
            
            NSString *celleStr = dic[@"mileInfoValue"];

            [cell setContentWithIndexPath:indexPath andContentStr:celleStr];
        }

        return cell;
    }
    
    
}


-(CGFloat)heightForRowWitUITextViewText:(NSString  *)text
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

-(CGFloat)heightForSecondRowWitUITextViewText:(NSString  *)text
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(kMainScreenWidth - 10-2-105 - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:HEL_14 constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    if (fHeight<30)
    {
        fHeight = 30;
    }
    return fHeight;
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _currentFirstRespondIndexPath = [NSIndexPath indexPathForRow:textView.tag-1000 inSection:0];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textView becomeFirstResponder];
    
}



- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [textView resignFirstResponder];
    if (textView.tag == 1000)
    {
    }
    else if (textView.tag == 1004)
    {
        _applyCarModel.beginAdrr = textView.text;
    }
    else if (textView.tag == 1005)
    {
        _applyCarModel.endAdrr = textView.text;
        
    }
    else if (textView.tag == 1006)
    {
        _applyCarModel.carUse = textView.text;
    }
    
    
    [self reloadRowsWithRowTag:textView.tag];
}

-(void)reloadRowsWithRowTag:(NSInteger)tag
{
    
    //    [_detailInfoTableView reloadData];
    
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:tag-1000 inSection:0];
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
    NSInteger numberOfCells = [_tableView.dataSource tableView:_tableView numberOfRowsInSection:0];
    
    for (NSInteger counter = 0;counter < numberOfCells;counter++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:counter inSection:0];
        
        SaveApplyCarTableViewCell *cell = (SaveApplyCarTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.cellTextView)
        {
            [cell.cellTextView resignFirstResponder];
        }
        
    }
    
}

-(void)clickEditButton
{
    if ([NSString isBlankString:_applyCarModel.selectedCarModel.carId])
    {
        [self displaySomeInfoWithInfo:@"请选择车辆" finsh:nil];
        
        return;
    }
    
    if ([NSString isBlankString:_applyCarModel.deptModel.deptId])
    {
        [self displaySomeInfoWithInfo:@"请选择用车部门" finsh:nil];
        
        return;
    }
    
    if ([NSString isBlankString:_applyCarModel.projectModel.projectId])
    {
        [self displaySomeInfoWithInfo:@"请选择项目" finsh:nil];
        
        return;
    }
    
    if ([NSString isBlankString:_applyCarModel.beginAdrr])
    {
        [self displaySomeInfoWithInfo:@"请选择出发地" finsh:nil];
        
        return;
    }
    
    if ([NSString isBlankString:_applyCarModel.endAdrr])
    {
        [self displaySomeInfoWithInfo:@"请选择目的地" finsh:nil];
        
        return;
    }
    
    
    
    if ([NSString isBlankString:_applyCarModel.carAppUserName])
    {
        [self displaySomeInfoWithInfo:@"请填写实际用车人" finsh:nil];
        
        return;
    }
    
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"appId",@"carAppDeptId",@"projectId",@"projectNo",@"projectName",@"carId",@"beginAdrr",@"endAdrr",@"beginTime",@"endTime",@"carAppUserId",@"carUse",@"status",@"appTime",@"appUserId",@"appDeptId"];
    
    
    //得到当前选中的时间
    NSDate *currDate=[NSDate date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    NSString *str=[dateFormatter stringFromDate:currDate ];
    
    NSArray *valueArray = @[_applyCarModel.appId,_applyCarModel.deptModel.deptId,_applyCarModel.projectModel.projectId,_applyCarModel.projectModel.projectNo,_applyCarModel.projectModel.projectName,_applyCarModel.selectedCarModel.carId,_applyCarModel.beginAdrr,_applyCarModel.endAdrr,_applyCarModel.beginTime,_applyCarModel.endTime,[HXUserModel shareInstance].userId,_applyCarModel.carUse,@"0",str,[HXUserModel shareInstance].userId,[HXUserModel shareInstance].deptId];
    
    [CLYCCoreBizHttpRequest editApplyCarWithBlock:^( NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"修改成功" finsh:nil];
 
            [_tableView reloadData];
     
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
    
    
}

-(void)updateApplyCarStatus
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"appId",@"status"];
    NSArray *valueArray = @[_applyCarModel.appId,@"1"];
    
    [CLYCCoreBizHttpRequest commitApplyCarWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"提交成功" finsh:nil];
            
            _tableView.tableFooterView = nil;
            self.navigationItem.rightBarButtonItem = nil;
            _tableView.tableFooterView = _cancleFootView;
            
            [_tableView reloadData];
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
    } keyArray:keyArray valueArray:valueArray];
    
}

-(void)clickCancleButton
{
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"appId"];
    NSArray *valueArray = @[_applyCarModel.appId];
    
    [CLYCCoreBizHttpRequest deleteApplyCarWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"取消成功" finsh:nil];
            
            _tableView.tableFooterView = nil;
            self.navigationItem.rightBarButtonItem = nil;
            
            [_tableView reloadData];
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
    
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
