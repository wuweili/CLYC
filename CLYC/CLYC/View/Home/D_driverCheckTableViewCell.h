//
//  D_driverCheckTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/8/9.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface D_driverCheckTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *driverTitleLabel;

@property(nonatomic,strong)UILabel *driverLabel;


@property(nonatomic,strong)UILabel *checkTimeTitleLabel;

@property(nonatomic,strong)UILabel *checkTimeLabel;


@property(nonatomic,strong)UILabel *gradeTitleLabel;

@property(nonatomic,strong)UILabel *gradeLabel;

@property(nonatomic,strong)NSIndexPath *indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithCheckModel:(DriverCheckModel *)model;


@end
