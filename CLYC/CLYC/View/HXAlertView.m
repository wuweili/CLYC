//
//  HXAlertView.m
//  BJXH-patient
//
//  Created by wu weili on 14-7-27.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "HXAlertView.h"




const static int space_to_screen = 30;

const static int button_height = 44;

const static int space_to_left = 15;

const static int space_to_top = 5;

const static int space_to_bottom = 5;

const static int titleLabel_width = 80;

const static int titleLabel_height = 30;

const static int apply_titleLabel_width = 40;

const static int upLoadImage_tag = 900;
const static int deleteImage_tag = 901;


const static int refuseTextView_tag = 2014819;
const static int addLeaveMsgTextView_tag = 2014820;





@implementation HXAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)show
{
//    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
//    self.frame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - _alertWidth) * 0.5, - _alertHeight - 30, _alertWidth, _alertHeight);
//    [shareWindow addSubview:self];

    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in shareWindow.subviews)
    {
        if (view.tag == bgImageView_tag)
        {
            isExitAlertView = YES;
            break;
        }
    }
    
    
    
    bgImageView = [[UIScrollView alloc]init];
    bgImageView.frame = shareWindow.frame;
    bgImageView.scrollEnabled = NO;
    bgImageView.tag = HXAlert_bgImageView_tag;
    self.center = shareWindow.center;
    [bgImageView addSubview:self];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.backgroundColor = [UIColor clearColor];
    [shareWindow addSubview:bgImageView];
}



-(void)dealloc
{
    
}

#pragma mark - 一般的提示信息弹窗
-(id)initRemindInfoWithTitle:(NSString *)title contentText:(NSString *)contentText leftBtnTitle:(NSString *)leftTltle rightBtnTitle:(NSString *)rightTitle haveCloseButton:(BOOL)haveCloseButton
{
    if (self = [super init])
    {
        
        CGSize size = CGSizeMake(kMainScreenWidth - space_to_screen , 100 + button_height *2);
        
        
        if (size.width > 290)
        {
            CGSize reNewSize = CGSizeMake(290, size.height);
            
            size = reNewSize;
        }
        
        
        [self setCommonHeaderViewByTitle:title size:size haveCloseButton:haveCloseButton];
        
        
        //中间内容
        CGFloat contentLabelWidth = size.width - 30;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((size.width - contentLabelWidth) * 0.5, self.greenLine.frame.origin.y + self.greenLine.frame.size.height + 1, contentLabelWidth, size.height-button_height*2 -2)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.backgroundColor=[UIColor clearColor];
        self.alertContentLabel.textAlignment =  NSTextAlignmentLeft;
        self.alertContentLabel.textColor = [UIColor blackColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:15.0f];
        self.alertContentLabel.text = contentText;
        
        [self heightForRemindInfoUILabel:self.alertContentLabel];
        
        [self addSubview:self.alertContentLabel];
        
        float height = button_height *2 + self.alertContentLabel.frame.size.height +2;
        
        
        [self setBottomViewWithSize:CGSizeMake(kMainScreenWidth - space_to_screen, height) LeftBtnTitle:leftTltle rightBtnTitle:rightTitle bottomBtnTitle:nil];
        
    }
    return self;
}


#pragma mark - 共同部分
-(void)setCommonHeaderViewByTitle:(NSString *)title size:(CGSize)size haveCloseButton:(BOOL)haveCloseButton
{
    if (size.width > 290)
    {
        CGSize reNewSize = CGSizeMake(290, size.height);
        
        size = reNewSize;
    }
    //标题
    self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, button_height -1)];
    self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    self.alertTitleLabel.textColor = [UIColor blackColor];
    self.alertTitleLabel.text = title;
    self.alertTitleLabel.backgroundColor=[UIColor clearColor];
    self.alertTitleLabel.textAlignment =NSTextAlignmentCenter;
    [self addSubview:self.alertTitleLabel];
    
    //关闭按钮
    if (haveCloseButton)
    {
        
        UIView *topSepLine = [[UIView alloc]initWithFrame:CGRectMake(size.width - 80, 5, 0.5, button_height - 10)];
        topSepLine.backgroundColor= UIColorFromRGB(0xAFAFBC);
        [self addSubview:topSepLine];
        
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(size.width - 80, 0, 80, button_height - 1);
        self.closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.closeBtn setTitleColor:UIColorFromRGB(0xEE5933) forState:UIControlStateNormal];
        [self.closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        
        [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeBtn];
        
    }
    

    //绿线
    self.greenLine=[[UIView alloc]initWithFrame:CGRectMake(0, self.alertTitleLabel.frame.origin.y + self.alertTitleLabel.frame.size.height , size.width, 1)];
    self.greenLine.backgroundColor= MAIN_GREEN_TITLE_COLOR;
    [self addSubview:self.greenLine];
    
}


-(void)setBottomViewWithSize:(CGSize)size LeftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle bottomBtnTitle:(NSString *)bottomTitle
{
    
    if (size.width > 290)
    {
        CGSize reNewSize = CGSizeMake(290, size.height);
        
        size = reNewSize;
    }
    
    _alertWidth=size.width;
    _alertHeight=size.height;
    
    self.frame = CGRectMake(0, 0, size.width, size.height);
    self.layer.cornerRadius = 8.0;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = UIColorFromRGB(0x43a5ef).CGColor;
    self.layer.borderWidth = 0.5f;
    self.alpha=0.9;
    
    if ([NSString isBlankString:bottomTitle])
    {
        //说明没有三个按钮
        //下面灰色线
        UIView *grayLine=[[UIView alloc]initWithFrame:CGRectMake(0, size.height-button_height, size.width, 0.5)];
        grayLine.backgroundColor=UIColorFromRGB(0xAFAFBC);
        [self addSubview:grayLine];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
        if ([NSString isBlankString:leftTitle])
        {
            rightBtnFrame=CGRectMake(0, size.height-button_height, size.width, button_height);
            
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = rightBtnFrame;
        }
        else
        {
            //下面按钮间的分割线
            UIView *bottombtnSepLine=[[UIView alloc]initWithFrame:CGRectMake(size.width/2-0.5, size.height-button_height, 0.5, button_height)];
            bottombtnSepLine.backgroundColor=UIColorFromRGB(0xAFAFBC);
            [self addSubview:bottombtnSepLine];
            
            //左边按钮
            leftBtnFrame = CGRectMake(0, size.height-button_height, size.width/2-0.5, button_height);
            rightBtnFrame = CGRectMake(size.width/2 , size.height-button_height, size.width/2, button_height);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
        }
        

        if ([NSString isBlankString:leftTitle])
        {
            [self.rightBtn setBackgroundImage:ALERT_SINGLE_RIGHT_BTN_IMAG forState:UIControlStateHighlighted];
        }
        else
        {
            [self.leftBtn setBackgroundImage:ALERT_LEFT_BTN_IMAG forState:UIControlStateHighlighted];
            [self.rightBtn setBackgroundImage:ALERT_RIGHT_BTN_IMAG forState:UIControlStateHighlighted];
        }
        
        
        [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        [self.leftBtn setTitleColor:UIColorFromRGB(0xEE5933) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:UIColorFromRGB(0x22BD9B) forState:UIControlStateNormal];
        
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        
    }
    else
    {
        //下面灰色线
        UIView *bottomFirstGrayLine=[[UIView alloc]initWithFrame:CGRectMake(0, size.height-button_height*2, size.width, 0.5)];
        bottomFirstGrayLine.backgroundColor=UIColorFromRGB(0xAFAFBC);
        [self addSubview:bottomFirstGrayLine];
        
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        CGRect buttonBtnFrame;
        
        //下面按钮键分割线
        UIView *bottomSepLine=[[UIView alloc]initWithFrame:CGRectMake(size.width/2-0.5, size.height-button_height*2, 1, button_height)];
        bottomSepLine.backgroundColor=UIColorFromRGB(0xAFAFBC);
        [self addSubview:bottomSepLine];
        
        //最下面灰色线
        
        UIView *bottomLastGrayLine=[[UIView alloc]initWithFrame:CGRectMake(0, size.height-button_height, size.width, 0.5)];
        bottomLastGrayLine.backgroundColor=UIColorFromRGB(0xAFAFBC);
        [self addSubview:bottomLastGrayLine];
        
        //三个按钮
        leftBtnFrame = CGRectMake(0, bottomFirstGrayLine.frame.origin.y+bottomFirstGrayLine.frame.size.height, size.width/2-0.5, button_height);
        
        rightBtnFrame = CGRectMake(size.width/2 , bottomFirstGrayLine.frame.origin.y+bottomFirstGrayLine.frame.size.height, size.width/2, button_height);
        
        buttonBtnFrame = CGRectMake(0, bottomLastGrayLine.frame.origin.y+bottomLastGrayLine.frame.size.height, 300, button_height);
        
        self.leftBtn.frame = leftBtnFrame;
        self.rightBtn.frame = rightBtnFrame;
        self.bottomBtn.frame = buttonBtnFrame;
        
        [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [self.bottomBtn setTitle:bottomTitle forState:UIControlStateNormal];
        
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = self.bottomBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        
        [self.leftBtn setTitleColor:UIColorFromRGB(0xEE5933) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:UIColorFromRGB(0x22BD9B) forState:UIControlStateNormal];
        [self.bottomBtn setTitleColor:UIColorFromRGB(0x47B9C8) forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomBtn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.bottomBtn];
        
        
    }
    
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    
    if (self.leftBlock)
    {
        [self dismissAlert];
        self.leftBlock();
    }

}


- (void)rightBtnClicked:(id)sender
{

    _leftLeave = NO;
    
    
    
    if (self.rightBlock)
    {
        [self dismissAlert];
        self.rightBlock();
    }
}

- (void)bottomBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.bottomBlock)
    {
        self.bottomBlock();
    }
}

-(void)closeBtnClick
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.closeBlock)
    {
        self.closeBlock();
    }
    
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    
    if (self.dismissBlock)
    {
        self.dismissBlock();
    }
    
}

- (void)removeFromSuperview
{
    
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    CGRect afterFrame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - _alertWidth) * 0.5, CGRectGetHeight(shareWindow.bounds), _alertWidth, _alertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        if (_leftLeave)
        {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }
        else
        {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished)
    {
        [bgImageView removeFromSuperview];
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:shareWindow.bounds];
        self.backImageView.tag =bgImageView_tag;
    }
    
    if (isExitAlertView) {
        self.backImageView.backgroundColor = [UIColor clearColor];
        
    }
    else
    {
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
    }
    
    
//    self.backImageView.backgroundColor = [UIColor blackColor];
//    self.backImageView.alpha = 0.6f;
    [shareWindow addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - _alertWidth) * 0.5, (CGRectGetHeight(shareWindow.bounds) - _alertHeight) * 0.5, _alertWidth, _alertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - uitextView高度改变

- (CGFloat)heightForTextView:(UITextView *)textView
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.frame.size.width - fPadding, CGFLOAT_MAX);
    CGSize size = [textView.text sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    
    if (fHeight <30)
    {
        fHeight = 30;
    }
    
    if (fHeight > 45)
    {
        fHeight = 45;
    }
    
    CGRect textFrame = textView.frame;
    textFrame.size.height  = fHeight;
    textView.frame = textFrame;

    return fHeight;
}


- (CGFloat)heightForRefuseDiagnoseTextView:(UITextView *)textView
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.frame.size.width - fPadding, CGFLOAT_MAX);
    CGSize size = [textView.text sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    
    if (fHeight <30)
    {
        fHeight = 30;
    }
    
    if (fHeight > 80)
    {
        fHeight = 80;
    }
    
    CGRect textFrame = textView.frame;
    textFrame.size.height  = fHeight;
    textView.frame = textFrame;
    
    return fHeight;
}





#pragma mark - uilabel 高度改变
- (CGFloat)heightForUILabel:(UILabel *)label
{
    
    CGSize constraint = CGSizeMake(label.frame.size.width , CGFLOAT_MAX);
    CGSize size = [label.text sizeWithFont: label.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height;
    
    if (fHeight <30)
    {
        fHeight = 30;
    }
    
    CGRect labelFrame = label.frame;
    labelFrame.size.height  = fHeight;
    label.frame = labelFrame;
    
    return fHeight;
}

#pragma mark - 一般提示类消息的label 高度改变

- (CGFloat)heightForRemindInfoUILabel:(UILabel *)label
{
    
    CGSize constraint = CGSizeMake(label.frame.size.width , CGFLOAT_MAX);
    CGSize size = [label.text sizeWithFont: label.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height;
    
    if (fHeight <label.frame.size.height)
    {
        fHeight = label.frame.size.height;
    }
    
    CGRect labelFrame = label.frame;
    labelFrame.size.height  = fHeight;
    label.frame = labelFrame;
    
    return fHeight;
}

@end
