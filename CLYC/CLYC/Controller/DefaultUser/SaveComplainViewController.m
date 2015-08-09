//
//  SaveComplainViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/8/9.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SaveComplainViewController.h"
#import "SaveApplyCarTableViewCell.h"
#import "SelecteCarViewController.h"
#import "SelectDeptmentViewController.h"
#import "SelectProjectViewController.h"
#import "EditApplyCarViewController.h"

@interface SaveComplainViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSIndexPath *_currentFirstRespondIndexPath;
    
    
    ComplainListModel *_applyComplainModel;
    
}

@end

@implementation SaveComplainViewController

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
    self.title = @"投诉申请";
    
    
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"投诉申请人：",@"联系电话：",@"投诉内容：", nil];
    
    if (!_applyComplainModel)
    {
        _applyComplainModel = [[ComplainListModel alloc]init];
    }

    _applyComplainModel.createPersonId =[HXUserModel shareInstance].userId;
    _applyComplainModel.createPersonName =[HXUserModel shareInstance].userName;
    _applyComplainModel.createPersonTel =[HXUserModel shareInstance].telphone;
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
        return 44;
    }
    else if (indexPath.row == 1)
    {
        return 44;
    }
    
    else
    {
        return [self heightForRowWitUITextViewText:_applyComplainModel.complaintContent] +14;
        
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
    sectionLabel.text = @"";
    sectionLabel.font = HEL_13;
    [sectionHeadView addSubview:sectionLabel];
    return sectionHeadView;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        cell = [[SaveApplyCarTableViewCell alloc]initSaveComplainWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath];
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
        celleStr = _applyComplainModel.createPersonName;
    }
    else if (indexPath.row == 1)
    {
        celleStr = _applyComplainModel.createPersonTel;
        
    }
    else
    {
        celleStr =_applyComplainModel.complaintContent;
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
    if (textView.tag == 1002)
    {
        _applyComplainModel.complaintContent = textView.text;
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
    if ([NSString isBlankString:_applyComplainModel.complaintContent])
    {
        [self displaySomeInfoWithInfo:@"请填写投诉内容" finsh:nil];
        
        return;
    }
    
    [self initMBHudWithTitle:nil];
    
    NSArray *keyArray = @[@"complaintContent",@"createPersonId",@"createPersonTel"];
    
    
    NSArray *valueArray = @[_applyComplainModel.complaintContent,_applyComplainModel.createPersonId,_applyComplainModel.createPersonTel];
    
    [CLYCCoreBizHttpRequest saveComplainApplyWithBlock:^(NSString *appId, NSString *retcode, NSString *retmessage, NSError *error) {
        
        if ([retcode isEqualToString:YB_HTTP_CODE_OK])
        {
            [self stopMBHudAndNSTimerWithmsg:@"保存成功" finsh:nil];
            
           _applyComplainModel._id =appId;
            
//            EditApplyCarViewController *editMVC = [[EditApplyCarViewController alloc]initWithApplyCarDetailModel:_applyCarModel];
//            [self.navigationController pushViewController:editMVC animated:YES];
            
        }
        else
        {
            [self stopMBHudAndNSTimerWithmsg:retmessage finsh:nil];
        }
        
        
    } keyArray:keyArray valueArray:valueArray];
  
    
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
