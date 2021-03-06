//
//  SaveApplyCarViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/21.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SaveApplyCarViewController.h"
#import "SaveApplyCarTableViewCell.h"
#import "SelecteCarViewController.h"
#import "SelectDeptmentViewController.h"
#import "SelectProjectViewController.h"
#import "EditApplyCarViewController.h"

@interface SaveApplyCarViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *_tableView;

    NSMutableArray *_dataArray;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    ApplyCarDetailModel *_applyCarModel;

   
}

@end

@implementation SaveApplyCarViewController


-(void)clickLeftNavMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(id)initWithStartTime:(NSString *)beginTime endTime:(NSString *)endTime selectedCarModel:(SelectCarInfoModel *)selectedCarModel
{
    self = [super init];
    
    if (self)
    {
        if (!_applyCarModel)
        {
            _applyCarModel = [[ApplyCarDetailModel alloc]init];
        }
        
        _applyCarModel.beginTime =beginTime;
        _applyCarModel.endTime =endTime;
        _applyCarModel.selectedCarModel =selectedCarModel;
        
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    
    [self initTableView];
    [self initFootView];
    
}

-(void)initUI
{
//    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.title = @"约车申请";
    
    
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"用车时间：",@"车牌号：",@"用车部门：",@"项目名称：",@"出发地：",@"目的地：",@"车辆用途：",@"实际用车人：", nil];
    
    if (!_applyCarModel)
    {
        _applyCarModel = [[ApplyCarDetailModel alloc]init];
    }
    
    _applyCarModel.deptModel.deptId = [HXUserModel shareInstance].deptId;
    _applyCarModel.deptModel.deptName =[HXUserModel shareInstance].deptName;
    
    _applyCarModel.applyDeptModel.deptId = [HXUserModel shareInstance].deptId;
    _applyCarModel.applyDeptModel.deptName = [HXUserModel shareInstance].deptName;
    
    
    _applyCarModel.carAppUserName =[HXUserModel shareInstance].userName;
    
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

-(void)initFootView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    
    footView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, kMainScreenWidth-30, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search.png"] forState:UIControlStateNormal];
    
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:startSearchButton];
    
    _tableView.tableFooterView = footView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    else
    {
        return [self heightForRowWitUITextViewText:_applyCarModel.carAppUserName] +14;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1)
    {
        SelecteCarViewController *selectCarMVC = [[SelecteCarViewController alloc]initWithDefaultSelectedCarModel:_applyCarModel.selectedCarModel beginTime:_applyCarModel.beginTime endTime:_applyCarModel.endTime selectCarBlock:^(SelectCarInfoModel *model) {
            
            _applyCarModel.selectedCarModel = model;
            
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
        
        SelectProjectViewController *selectProjectMVC = [[SelectProjectViewController alloc]initWithDefaultSelectedProjectModel:_applyCarModel.projectModel depId:_applyCarModel.deptModel.deptId selectProjectBlock:^(ProjectListModel *model) {
            _applyCarModel.projectModel = model;
            
            [_tableView reloadData];
        }];
        
        [self.navigationController pushViewController:selectProjectMVC animated:YES];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"detailInfo%ld",(long)indexPath.row];
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
    else
    {
        celleStr = _applyCarModel.carAppUserName;
    }
    
    
    [cell setContentWithIndexPath:indexPath andContentStr:celleStr];
    
    return cell;
}


-(CGFloat)heightForRowWitUITextViewText:(NSString  *)text
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(kMainScreenWidth - 25-2-95 - fPadding, CGFLOAT_MAX);
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

-(void)clickSaveButton
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
    
    NSArray *keyArray = @[@"carAppDeptId",@"projectId",@"projectNo",@"projectName",@"carId",@"beginAdrr",@"endAdrr",@"beginTime",@"endTime",@"carAppUserId",@"carUse",@"status",@"appTime",@"appUserId",@"appDeptId"];
    
    
    //得到当前选中的时间
    NSDate *currDate=[NSDate date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    NSString *str=[dateFormatter stringFromDate:currDate ];
    
    NSArray *valueArray = @[_applyCarModel.deptModel.deptId,_applyCarModel.projectModel.projectId,_applyCarModel.projectModel.projectNo,_applyCarModel.projectModel.projectName,_applyCarModel.selectedCarModel.carId,_applyCarModel.beginAdrr,_applyCarModel.endAdrr,_applyCarModel.beginTime,_applyCarModel.endTime,[HXUserModel shareInstance].userId,_applyCarModel.carUse,@"0",str,[HXUserModel shareInstance].userId,_applyCarModel.applyDeptModel.deptId];
    
    [CLYCCoreBizHttpRequest saveApplyCarWithBlock:^(NSString *appId, NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"保存成功" finsh:nil];
            
            _applyCarModel.appId =appId;
            
            EditApplyCarViewController *editMVC = [[EditApplyCarViewController alloc]initWithApplyCarDetailModel:_applyCarModel];
            [self.navigationController pushViewController:editMVC animated:YES];
   
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
    
    
}


@end
