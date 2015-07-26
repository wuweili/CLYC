//
//  XLYCHomeViewController.m
//  CLYC
//
//  Created by wuweiqing on 15/7/4.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CLYCHomeViewController.h"
#import "SDCycleScrollView.h"
#import "XCCenterFirstCollectionViewCell.h"
#import "XCCenterSecondCollectionViewCell.h"
#import "ApplyCarViewController.h"
#import "ApplyCarHistoryViewController.h"
#import "ConfirmMileViewController.h"
#import "D_ApplyCarListViewController.h"
#import "CLYCLocationManager.h"



@interface CLYCHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_imageUrlArray;
    
    SDCycleScrollView *_imageScrollView;
    
    NSMutableArray *_section1Array;

    UICollectionView *_collectionView;

}

@end

@implementation CLYCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self initData];
    
    [self initScrollImageView];
    
    [self initUICollectionView];
    

    if (!IS_DefaultUser)
    {
        
        NSString *carAppId = [[NSUserDefaults standardUserDefaults] objectForKey:CY_APPCAR_ID];
        
        if (![NSString isBlankString:carAppId])
        {
            [[CLYCLocationManager shareInstance] startLocation];
        }
    
    }
   
    
}

-(void)initUI
{
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"轻松约车";
    
    
}

-(void)initData
{
    _imageUrlArray = [NSMutableArray arrayWithCapacity:0];
    
    _section1Array = [NSMutableArray arrayWithCapacity:0];
    
    if (IS_DefaultUser)
    {
        [_section1Array addObjectsFromArray:@[
                                              FIRST_HOME_BOOK_CAR_image,
                                              FIRST_HOME_HISTORY_LIST_image,
                                              FIRST_HOME_MILE_CONFIRM_image,
                                              FIRST_HOME_COMPLAIN_image
                                              ]];
    }
    else
    {
        [_section1Array addObjectsFromArray:@[
                                              FIRST_HOME_ORDER_MANAGER_image,
                                              FIRST_HOME_COMMENT_image,
                                              FIRST_HOME_PERSONAL_INFO_image,
                                              FIRST_HOME_SETTING_image
                                              ]];
    }
   
    
    [_imageUrlArray addObjectsFromArray: @[
                                           FIRST_HOME_NVOD_1_image
                                           ]];
    
    
    
}

-(void)initScrollImageView
{
    
    _imageScrollView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150) imagesGroup:_imageUrlArray];
    _imageScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _imageScrollView.delegate = self;
    _imageScrollView.autoScrollTimeInterval = 4.0;
    
}

-(void)initUICollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeightNoStatusAndNoNaviBarHeight) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.view addSubview:_collectionView];
    
//    [_collectionView registerClass:[XCCenterFirstCollectionViewCell class] forCellWithReuseIdentifier:@"section0Cell"];
    
    [_collectionView registerClass:[XCCenterSecondCollectionViewCell class] forCellWithReuseIdentifier:@"section1Cell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DDLogInfo(@"---点击了第%d张图片", index);
}

#pragma mark - UICollectionViewDataSource -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_section1Array count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *identifier = @"section1Cell";
    
    XCCenterSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell sizeToFit];
    
    
    if (cell == nil)
    {
        DDLogInfo(@"----------");
    }
    
    
    cell.cellImageView.image =[_section1Array objectAtIndex:indexPath.row];
    
    return cell;
    
    
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [headerView addSubview:_imageScrollView];
    
    return headerView;
    
    
}


#pragma mark - UICollectionViewDelegateFlowLayout -

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.view.bounds.size.width-20-10)/2, (self.view.bounds.size.width-20-10)/2);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 150);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDLogInfo(@"选择%ld",(long)indexPath.row);
    
    if (IS_DefaultUser)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                ApplyCarViewController *applyCarMVC = [[ApplyCarViewController alloc]init];
                [self.navigationController pushViewController:applyCarMVC animated:YES];
                
                
            }
                break;
            case 1:
            {
                ApplyCarHistoryViewController *applyCarMVC = [[ApplyCarHistoryViewController alloc]init];
                [self.navigationController pushViewController:applyCarMVC animated:YES];
            }
                break;
                
            case 2:
            {
                ConfirmMileViewController *confirmMVC = [[ConfirmMileViewController alloc]init];
                [self.navigationController pushViewController:confirmMVC animated:YES];
            }
                break;
                
            case 3:
            {
            }
                break;
                
            case 4:
            {
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
                D_ApplyCarListViewController *applyCarMVC = [[D_ApplyCarListViewController alloc]init];
                [self.navigationController pushViewController:applyCarMVC animated:YES];
                
                
            }
                break;
            case 1:
            {
                ApplyCarHistoryViewController *applyCarMVC = [[ApplyCarHistoryViewController alloc]init];
                [self.navigationController pushViewController:applyCarMVC animated:YES];
            }
                break;
                
            case 2:
            {
                ConfirmMileViewController *confirmMVC = [[ConfirmMileViewController alloc]init];
                [self.navigationController pushViewController:confirmMVC animated:YES];
            }
                break;
                
            case 3:
            {
            }
                break;
                
            case 4:
            {
            }
                break;
                
                
            default:
                break;
        }
    }
    
    

    
    
    
    
    
    
    
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor clearColor]];
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
