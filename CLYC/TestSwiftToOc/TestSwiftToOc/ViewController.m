//
//  ViewController.m
//  TestSwiftToOc
//
//  Created by weili.wu on 15/5/20.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "YBTabBarViewController.h"

@interface ViewController ()
{
    CGFloat proportionOfLeftView;
    
    CGFloat distanceOfLeftView;
    
    CGFloat FullDistance ;
    
    CGFloat Proportion ;
    
    CGFloat distance;
    
    CGFloat screenWidth;
    
    CGFloat screenHeight;
    
    
    LeftViewController *leftViewController;
    
    UINavigationController *leftNavigationController;
    
    
    CGPoint centerOfLeftViewAtBeginning ;
    
    UIView *blackCover;
    
    UIView  *mainView;
    
    
    YBTabBarViewController *_tabbarController;
    
    UITapGestureRecognizer *tapGesture;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    imageView.image = [UIImage imageNamed:@"back"];
    
    [self.view addSubview:imageView];
    
    proportionOfLeftView = 1;
    
    distanceOfLeftView = 50;
    
    FullDistance = 0.78;
    
    Proportion = 0.77;
    
    distance = 0;
    
    
    screenWidth = [UIScreen mainScreen].applicationFrame.size.width;
    
    screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
    
    if (screenWidth>320)
    {
        proportionOfLeftView = screenWidth / 320;
        distanceOfLeftView += (screenWidth - 320) * FullDistance / 2;
    }
    
    leftViewController = [[LeftViewController alloc]init];
    
    leftViewController.view.center = CGPointMake(leftViewController.view.center.x - 50, leftViewController.view.center.y);
    
    leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    
    centerOfLeftViewAtBeginning = leftViewController.view.center;
    
    leftNavigationController = [[UINavigationController alloc]initWithRootViewController:leftViewController];

    [self.view  addSubview:leftNavigationController.view];
    
    
    // 增加黑色遮罩层，实现视差特效
    blackCover =  [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, 0)];
    blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackCover];
    
    
    
    mainView = [[UIView alloc]initWithFrame:self.view.frame];
    
    _tabbarController = [[YBTabBarViewController alloc]init];
    [mainView addSubview:_tabbarController.view];
    [self.view addSubview:mainView];
    

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [mainView setUserInteractionEnabled:YES];
    [mainView addGestureRecognizer:pan];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHome)];
    
    
}

-(void)handlePan: (UIPanGestureRecognizer *)recongnizer
{
    CGFloat x = [recongnizer translationInView:self.view].x;
    
    CGFloat trueDistance = distance +x;// 实时距离
    
    CGFloat trueProportion = trueDistance /(screenHeight*FullDistance);
    
    if (recongnizer.state == UIGestureRecognizerStateEnded)
    {
        if (trueDistance>screenWidth *(Proportion/3))
        {
            [self showLeft];
        }
        else if (trueDistance < screenWidth*-(Proportion/3))
        {
            [self showRight];
        }
        else
        {
            [self showHome];
        }
        
        return;
    }
    
    
    
    // 计算缩放比例
    CGFloat proportion = recongnizer.view.frame.origin.x >= 0 ? -1 : 1;
    proportion *= trueDistance / screenWidth;
    proportion *= 1 - Proportion;
    proportion /= FullDistance + Proportion/2 - 0.5;
    proportion += 1;
    if (proportion <= Proportion)
    { // 若比例已经达到最小，则不再继续动画
        return;
    }
    
    // 执行视差特效
    blackCover.alpha = (proportion - Proportion) / (1 - Proportion);
    
    // 执行平移和缩放动画
    recongnizer.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    recongnizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
   
    CGFloat pro = 0.8 + (proportionOfLeftView - 0.8) * trueProportion;
    leftNavigationController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView * trueProportion, centerOfLeftViewAtBeginning.y - (proportionOfLeftView - 1) * leftNavigationController.view.frame.size.height * trueProportion / 2 );
    leftNavigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
    
    
}

-(void)showLeft
{
    [mainView addGestureRecognizer:tapGesture];

    distance = self.view.center.x * (FullDistance*2 + Proportion - 1);
    
    [self doTheAnimateProportion:Proportion showWhat:@"left"];
    
    
 
}

-(void)showHome
{
   [mainView removeGestureRecognizer:tapGesture];
    
    distance = 0;
    
   [self doTheAnimateProportion:1 showWhat:@"home"];
    
}

-(void)showRight
{
    [mainView addGestureRecognizer:tapGesture];
    distance = self.view.center.x * -(FullDistance*2 + Proportion - 1);
    [self doTheAnimateProportion:Proportion showWhat:@"right"];
}


-(void)doTheAnimateProportion:(CGFloat)proportion showWhat:(NSString *)showWhat
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
//        () -> Void in;
        mainView.center = CGPointMake(self.view.center.x + distance, self.view.center.y);
        mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        if ([showWhat isEqualToString: @"left"])
        {
            leftNavigationController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView, leftNavigationController.view.center.y);
            leftNavigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportionOfLeftView, proportionOfLeftView);
        }
        
        
        blackCover.alpha = [showWhat isEqualToString:@"home"] ? 1 : 0;
        
        leftNavigationController.view.alpha = [showWhat isEqualToString: @"right" ]? 0 : 1;
        
        
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
