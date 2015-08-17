//
//  HXAlertView.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-27.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>


const static int HXAlert_bgImageView_tag = 20141208;

const static int bgImageView_tag = 20141017;

@protocol HXAlertViewDelegate <NSObject>

-(void)textViewEndEditingWithText:(NSString *)text;

-(void)inputTextLengthAboveStandardWithMsg:(NSString *)tipMsg;

@end





@interface HXAlertView : UIView<UITextViewDelegate,UITextFieldDelegate>
{
    BOOL _leftLeave;
    float _alertWidth;
    float _alertHeight;
    UIScrollView* bgImageView;
    
    UISwitch *_switchButton;
    UITextField *_friendNameField;
    UITextField *_friendTelNumField;
    
    UILabel *_selfFaceTitleLabel;
    UILabel *_friendsTitleLabel;
    
    UIView *_evaView;
    NSInteger _evaItegerValue;
    
    
    UILabel *_addLeaveMsgLabel;
    UIButton *_uploadImageBtn;
    UIImageView *_leaveImageView;
    
    BOOL isExitAlertView ;
    
    
}

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t bottomBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, copy) dispatch_block_t closeBlock;


@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UIView *backImageView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *greenLine;
@property (nonatomic, strong) UITextView *refuseTextView;



@property(nonatomic,weak)id<HXAlertViewDelegate>delegate;

- (void)show;


#pragma mark - 一般的提示信息弹窗
-(id)initRemindInfoWithTitle:(NSString *)title contentText:(NSString *)contentText leftBtnTitle:(NSString *)leftTltle rightBtnTitle:(NSString *)rightTitle haveCloseButton:(BOOL)haveCloseButton;

@end
