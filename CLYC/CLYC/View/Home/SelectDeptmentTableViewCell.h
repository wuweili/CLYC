//
//  SelectDeptmentTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDeptmentTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *cellTitleLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
