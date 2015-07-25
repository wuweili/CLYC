//
//  PersonalInfoTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/25.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *cellTitleLabel;
@property(nonatomic,strong)UITextView *cellTextView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithText:(NSString *)text;
@end
