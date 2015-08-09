//
//  EditComplainViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/8/9.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "EditComplainViewController.h"
#import "SaveApplyCarTableViewCell.h"
#import "DateFormate.h"
#import "SaveComplainViewController.h"

@interface EditComplainViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_secondDataArray;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    UIView *_editFootView;
    UIView *_cancleFootView;
    ComplainListModel *_appComplainModel;
    
}

@end

@implementation EditComplainViewController

-(id)initWithComplainModel:(ComplainListModel *)model
{
    self = [super init];
    
    if (self)
    {
        _appComplainModel = model;
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
        if ([temp isKindOfClass:[SaveComplainViewController class]])
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
    self.title = @"投诉申请";
    
    [IMUnitsMethods drawTheRightBarBtn:self function:@selector(updateApplyCarStatus) btnTitle:@"提交" bgImage:nil];
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"投诉申请人：",@"申请时间：",@"状态：",@"联系电话：",@"投诉内容：", nil];
    
    if (!_appComplainModel)
    {
        _appComplainModel = [[ComplainListModel alloc]init];
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
    
    NSArray *keyArray = @[@"id"];
    NSArray *valueArray = @[_appComplainModel._id];
    
    [CLYCCoreBizHttpRequest obtainComplainDetailWithBlock:^(ComplainListModel *model, NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:nil finsh:nil];
            
            _appComplainModel = model;
            
            if (_appComplainModel.status.integerValue ==0 )
            {
                //暂存
//                _tableView.tableFooterView = nil;
//                self.navigationItem.rightBarButtonItem = nil;
//                _tableView.tableFooterView = _cancleFootView;
                
            }
            else if (_appComplainModel.status.integerValue == 1)
            {
                //提交
                _tableView.tableFooterView = nil;
                self.navigationItem.rightBarButtonItem = nil;
                _tableView.tableFooterView = _cancleFootView;
                
            }
            else if (_appComplainModel.status.integerValue == 2)
            {
                //已处理
                _tableView.tableFooterView = nil;
                self.navigationItem.rightBarButtonItem = nil;
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
        if (indexPath.row == 4)
        {
            
            return [self heightForRowWitUITextViewText:_appComplainModel.complaintContent] +14;
        }
        else
        {
            return 44;
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
        sectionLabel.text = @"";
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
        sectionLabel.text = @"";
        sectionLabel.font = HEL_13;
        [sectionHeadView addSubview:sectionLabel];
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
        SaveApplyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[SaveApplyCarTableViewCell alloc]initEditComplainWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
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
            
            celleStr = _appComplainModel.createPersonName;
        }
        else if (indexPath.row == 1)
        {
            celleStr = _appComplainModel.createTime;
        }
        else if (indexPath.row == 2)
        {
            celleStr = _appComplainModel.statusName;
        }
        else if (indexPath.row == 3)
        {
            celleStr = _appComplainModel.createPersonTel;
        }
        else
        {
            celleStr = _appComplainModel.complaintContent;
            
            if (_appComplainModel.status.integerValue ==0 )
            {
                cell.cellTextView.editable = YES;
                cell.userInteractionEnabled = YES;
            }
            else if (_appComplainModel.status.integerValue == 1)
            {
                //提交
                cell.cellTextView.editable = NO;
                cell.userInteractionEnabled = NO;

            }
            else if (_appComplainModel.status.integerValue == 2)
            {
                //已处理
                cell.cellTextView.editable = NO;
                cell.userInteractionEnabled = NO;

            }
            
            
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
    if (textView.tag == 1004)
    {
        _appComplainModel.complaintContent = textView.text;
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
    if ([NSString isBlankString:_appComplainModel.complaintContent])
    {
        [self displaySomeInfoWithInfo:@"请填写投诉内容" finsh:nil];
        
        return;
    }
    
    [self initMBHudWithTitle:nil];
    NSArray *keyArray = @[@"id",@"complaintContent",@"createPersonId",@"createPersonTel"];
 
    NSArray *valueArray = @[_appComplainModel._id,_appComplainModel.complaintContent,_appComplainModel.createPersonId,_appComplainModel.createPersonTel];
    
    [CLYCCoreBizHttpRequest editComplainApplyWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
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
    
    NSArray *keyArray = @[@"id",@"status"];
    NSArray *valueArray = @[_appComplainModel._id,@"1"];
    
    [CLYCCoreBizHttpRequest commitComplainApplyWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
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
    
    NSArray *keyArray = @[@"id"];
    NSArray *valueArray = @[_appComplainModel._id];
    
    [CLYCCoreBizHttpRequest deleteComplainApplyWithBlock:^(NSString *retcode, NSString *retmessage, NSError *error) {
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



@end
