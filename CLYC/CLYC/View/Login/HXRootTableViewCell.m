//
//  HXRootTableViewCell.m
//  BJXH-patient
//
//  Created by wuweili on 14-11-22.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import "HXRootTableViewCell.h"

@implementation HXRootTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (indexPath.row == 0)
        {
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 12.0, 21, 21)];
            _headImageView.backgroundColor = [UIColor clearColor];
            _headImageView.image = ICON_LOGIN_PHONE;
            [self.contentView addSubview:_headImageView];
            
            _contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width+14, 0.0, 240, 44.0)];
            
            _contentTextField.placeholder=@"工号";
            
            _contentTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _contentTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
            _contentTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _contentTextField.returnKeyType = UIReturnKeyDone;

            _contentTextField.font = HEL_15;
            _contentTextField.backgroundColor = [UIColor clearColor];
            _contentTextField.tag = 500;
            [self.contentView addSubview:_contentTextField];
            
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, kMainScreenWidth, 1)];
            line.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
            [self.contentView addSubview:line];
            
        }
        else
        {
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 12.0, 21, 21)];
            _headImageView.backgroundColor = [UIColor clearColor];
            _headImageView.image = ICON_LONGIN_PASSWORD;
            [self.contentView addSubview:_headImageView];
            
            _contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width+14, 0.0, 240, 44.0)];
            
            _contentTextField.placeholder=@"密码";
            
            _contentTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _contentTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
            _contentTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _contentTextField.returnKeyType = UIReturnKeyDone;
            _contentTextField.secureTextEntry=YES;
            _contentTextField.font = HEL_15;
            _contentTextField.backgroundColor = [UIColor clearColor];
            _contentTextField.tag = 500;
            [self.contentView addSubview:_contentTextField];
        }
        
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
