//
//  PersonalInfoViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/25.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoTableViewCell.h"
#import "AppDelegate.h"

@interface PersonalInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    NSMutableArray *_valueArray;
    
    UIView *_editFootView;
    
    UIView *_headerView;

    
}

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人信息";

    [self initTableView];
    
    [self initHeaderView];
    
    [self initEditFootView];
    
    
}

-(void)initData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"电子邮箱：",@"手机号：",@"角色：",@"部门名称：", nil];
    
    NSString *jueseStr = @"";
    
    if (IS_DefaultUser)
    {
        jueseStr = @"用车人";
    }
    else
    {
        jueseStr = @"司机";
    }
    
    _valueArray = [NSMutableArray arrayWithObjects:[HXUserModel shareInstance].email,[HXUserModel shareInstance].telphone,jueseStr,[HXUserModel shareInstance].deptName, nil];
}

-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)initHeaderView
{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120)];
    _headerView.backgroundColor = UIColorFromRGB(0x69d25c);
    
    UIButton *headButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 60, 60)];
    headButton.backgroundColor = [UIColor clearColor];
    
    headButton.layer.cornerRadius = headButton.frame.size.width/2;
    
    [headButton setBackgroundImage:LEFT_USER_DEFAULT_image forState:UIControlStateNormal];
    
    [_headerView addSubview:headButton];
    
    
    UILabel *nameLabe = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headButton.frame)+20, CGRectGetMinY(headButton.frame), kMainScreenWidth- CGRectGetMaxX(headButton.frame)-20-15, 20)];
    nameLabe.backgroundColor = [UIColor clearColor];
    nameLabe.textAlignment = NSTextAlignmentLeft;
    nameLabe.font = HEL_14;
    nameLabe.textColor = [UIColor whiteColor];
    nameLabe.text = [HXUserModel shareInstance].userName;
    [_headerView addSubview:nameLabe];
    
    UILabel *loginIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headButton.frame)+20, CGRectGetMaxY(nameLabe.frame)+5, kMainScreenWidth- CGRectGetMaxX(headButton.frame)-20-15, 20)];
    loginIdLabel.backgroundColor = [UIColor clearColor];
    loginIdLabel.textAlignment = NSTextAlignmentLeft;
    loginIdLabel.font = HEL_14;
    loginIdLabel.textColor = [UIColor whiteColor];
    loginIdLabel.text = [HXUserModel shareInstance].loginId;
    [_headerView addSubview:loginIdLabel];
    
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxY(headButton.frame)+20, CGRectGetMaxY(loginIdLabel.frame)+5, kMainScreenWidth- CGRectGetMaxX(headButton.frame)-20-15, 20)];
    sexLabel.backgroundColor = [UIColor clearColor];
    sexLabel.textAlignment = NSTextAlignmentLeft;
    sexLabel.font = HEL_14;
    sexLabel.textColor = [UIColor whiteColor];
    sexLabel.text = [HXUserModel shareInstance].sex;
    [_headerView addSubview:sexLabel];
    
    _tableView.tableHeaderView = _headerView;
}

-(void)initEditFootView
{
    _editFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 70)];
    
    _editFootView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
    UIButton *startSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, kMainScreenWidth-30, 30)];
    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"hx_icon_register.png"] forState:UIControlStateNormal];
    
//    [startSearchButton setBackgroundImage:[UIImage imageNamed:@"button_search_select.png"] forState:UIControlStateHighlighted];
    
    [startSearchButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    
    [startSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startSearchButton addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
    [_editFootView addSubview:startSearchButton];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_valueArray count]>0)
    {
        NSString *cellStr =[_valueArray objectAtIndex:indexPath.row];
        
        return [self heightForOneSectionRowWitUITextViewText:cellStr]+14;
    }
    else
    {
        return 0;
    }
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
    PersonalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[PersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    if ([_dataArray count]>0)
    {
        cell.cellTitleLabel.text = [_dataArray objectAtIndex:indexPath.row];
        
        cell.cellTextView.text = [_valueArray objectAtIndex:indexPath.row];
   
    }
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)heightForOneSectionRowWitUITextViewText:(NSString  *)text
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(kMainScreenWidth-15-95 - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:HEL_14 constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    if (fHeight<30)
    {
        fHeight = 30;
    }
    return fHeight;
}

-(void)clickLogoutButton
{
    [HXAPPDELEGATE logOut];
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
