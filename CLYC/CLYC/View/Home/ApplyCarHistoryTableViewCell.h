//
//  ApplyCarHistoryTableViewCell.h
//  CLYC
//
//  Created by weili.wu on 15/7/6.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyCarHistoryTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *projectTitleLabel;

@property(nonatomic,strong)UILabel *projectNameLabel;

@property(nonatomic,strong)UILabel *timeTitleLabel;

@property(nonatomic,strong)UILabel *timeLabel;


@property(nonatomic,strong)UILabel *carCodeTitleLabel;


@property(nonatomic,strong)UILabel *carCodeLabel;

@property(nonatomic,strong)UILabel *mileTitleLabel;

@property(nonatomic,strong)UILabel *mileLabel;

@property(nonatomic,strong)UILabel *driverTitleLabel;

@property(nonatomic,strong)UILabel *driverLabel;

@property(nonatomic,strong)UILabel *driverTelTitleLabel;

@property(nonatomic,strong)UILabel *driverTelLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithApplyCarListModel:(ApplyCarListModel *)model;

@end
