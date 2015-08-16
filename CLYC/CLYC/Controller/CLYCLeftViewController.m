//
//  CLYCLeftViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/4.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CLYCLeftViewController.h"
#import "XCLeftSideTableViewCell.h"
#import "AppDelegate.h"
#import "PersonalInfoViewController.h"
#import "D_CostSearchViewController.h"
#import "CarTrajectoryViewController.h"

@interface CLYCLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSArray *_dataArray;
    NSArray *_imageArray;
    
    UIView *_headView;
    
    UIImageView *_headImageView;
    
    UILabel *_nameLabel;
    
}

@end

@implementation CLYCLeftViewController


-(void)dealloc
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor clearColor];
    
    if (CurrentSystemVersion>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
        
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    if (IS_DefaultUser)
    {
//        _dataArray = [NSArray arrayWithObjects:@"首页",@"车辆信息",@"车辆轨迹",@"费用查询",@"版本更新",@"个人信息", nil];
//        
//        _imageArray = [NSArray arrayWithObjects:LEFT_menu_home_image,LEFT_menu_history_image,LEFT_menu_travel_way_image,LEFT_menu_mile_confirm_image,LEFT_menu_update_image,LEFT_menu_user_info_image, nil];
        
        _dataArray = [NSArray arrayWithObjects:@"首页",@"车辆轨迹",@"费用查询",@"个人信息", nil];
        
        _imageArray = [NSArray arrayWithObjects:LEFT_menu_home_image,LEFT_menu_travel_way_image,LEFT_menu_mile_confirm_image,LEFT_menu_user_info_image, nil];
    }
    else
    {
//        _dataArray = [NSArray arrayWithObjects:@"首页",@"费用查询",@"版本更新",@"个人信息", nil];
//        
//        _imageArray = [NSArray arrayWithObjects:LEFT_menu_home_image,LEFT_menu_mile_confirm_image,LEFT_menu_update_image,LEFT_menu_user_info_image, nil];
        
        _dataArray = [NSArray arrayWithObjects:@"首页",@"费用查询",@"个人信息", nil];
        
        _imageArray = [NSArray arrayWithObjects:LEFT_menu_home_image,LEFT_menu_mile_confirm_image,LEFT_menu_user_info_image, nil];
        
    }
    
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 220)];
    
    _headView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_headView];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 70, 80, 80)];
    _headImageView.layer.cornerRadius =_headImageView.frame.size.width/2;
    
    _headImageView.image = LEFT_USER_DEFAULT_image;
    
    [_headView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, CGRectGetMinY(_headImageView.frame), kMainScreenWidth - (CGRectGetMaxX(_headImageView.frame)+10) - 10 , 80)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = HEL_34;
    _nameLabel.text = [HXUserModel shareInstance].userName;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [_headView addSubview:_nameLabel];
    
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_headView.frame),kMainScreenWidth ,kScreenHeightNoStatusAndNoNaviBarHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    




}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (IS_DefaultUser)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [HXAPPDELEGATE.backgroundViewController showHome];
            }
                break;
//            case 1:
//            {
//                //车辆信息
//                [self displaySomeInfoWithInfo:@"即将推出，敬请期待" finsh:nil];
//            }
//                break;
                
            case 1:
            {
                //车辆轨迹
                
                CarTrajectoryViewController *personalMVC = [[CarTrajectoryViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];
                
            }
                break;
            case 2:
            {
                //费用查询
                
                D_CostSearchViewController *personalMVC = [[D_CostSearchViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];
                
            }
                break;
            case 3:
            {
                //版本更新
//                [self displaySomeInfoWithInfo:@"已是最新版本" finsh:nil];
                
                PersonalInfoViewController *personalMVC = [[PersonalInfoViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];

                
            }
                break;
            case 4:
            {
                //个人信息
                
                
                PersonalInfoViewController *personalMVC = [[PersonalInfoViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];

            }
                break;
            
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [HXAPPDELEGATE.backgroundViewController showHome];
            }
                break;
            case 1:
            {
                //费用查询
                
                D_CostSearchViewController *personalMVC = [[D_CostSearchViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];
                
            }
                break;
            case 2:
            {
                //版本更新
                
//                [self displaySomeInfoWithInfo:@"已是最新版本" finsh:nil];
                
                PersonalInfoViewController *personalMVC = [[PersonalInfoViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];

            }
                break;
            case 3:
            {
                //个人信息
                
                
                PersonalInfoViewController *personalMVC = [[PersonalInfoViewController alloc]init];
                UINavigationController *userInfoNav = [[UINavigationController alloc]initWithRootViewController:personalMVC];
                
                userInfoNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self.navigationController presentViewController:userInfoNav animated:YES completion:^{
                    
                }];
                
            }
                break;
                
                
            default:
                break;
        }
    }
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"leftSideCell%ld",(long)indexPath.row];
    
    XCLeftSideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[XCLeftSideTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
 
    [cell setCellContentWithIndexPath:indexPath imageArray:_imageArray titleArray:_dataArray];
  
    
    return cell;
    
    
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
