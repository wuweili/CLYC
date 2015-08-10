//
//  CostSearchTableViewCell.h
//  CLYC
//
//  Created by weili.wu on 15/8/10.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostSearchTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *depTitleLabel;
@property(nonatomic,strong)UILabel *depLabel;

@property(nonatomic,strong)UILabel *projectTitleLabel;
@property(nonatomic,strong)UILabel *projectNameLabel;

@property(nonatomic,strong)UILabel *carCodeTitleLabel;
@property(nonatomic,strong)UILabel *carCodeLabel;

@property(nonatomic,strong)UILabel *timeTitleLabel;
@property(nonatomic,strong)UILabel *timeLabel;


@property(nonatomic,strong)UILabel *carUserTitleLabel;
@property(nonatomic,strong)UILabel *carUserLabel;


@property(nonatomic,strong)UILabel *carUserTelTitleLabel;
@property(nonatomic,strong)UILabel *carUserTelLabel;

@property(nonatomic,strong)UILabel *driverTitleLabel;
@property(nonatomic,strong)UILabel *driverLabel;

@property(nonatomic,strong)UILabel *driverTelTitleLabel;
@property(nonatomic,strong)UILabel *driverTelLabel;

@property(nonatomic,strong)UILabel *mileTitleLabel;
@property(nonatomic,strong)UILabel *mileLabel;

@property(nonatomic,strong)UILabel *costTitleLabel;
@property(nonatomic,strong)UILabel *costLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setCellContentWithApplyCarModel:(ApplyCarDetailModel *)model;

@end
