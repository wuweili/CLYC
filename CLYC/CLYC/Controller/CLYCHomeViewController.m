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



@interface CLYCHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_imageUrlArray;
    
    SDCycleScrollView *_imageScrollView;
    
    NSMutableArray *_section1Array;

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
    
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"轻松约车";
    
    
}

-(void)initData
{
    _imageUrlArray = [NSMutableArray arrayWithCapacity:0];
    
    _section1Array = [NSMutableArray arrayWithCapacity:0];
    
    
    
    [_section1Array addObjectsFromArray:@[
                                          XCCenterPage_yiwu,
                                          XCCenterPage_xiewa,
                                          XCCenterPage_shechi,
                                          XCCenterPage_jujia,
                                          XCCenterPage_pibao]];
    
    
    
    
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
