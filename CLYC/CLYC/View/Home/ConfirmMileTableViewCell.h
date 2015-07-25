//
//  ConfirmMileTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/25.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmMileTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *carCodeTitleLabel;

@property(nonatomic,strong)UILabel *carCodeLabel;

@property(nonatomic,strong)UILabel *driverTitleLabel;

@property(nonatomic,strong)UILabel *driverLabel;

@property(nonatomic,strong)UILabel *driverTelTitleLabel;

@property(nonatomic,strong)UILabel *driverTelLabel;

@property(nonatomic,strong)UILabel *timeTitleLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *addressTitleLabel;

@property(nonatomic,strong)UILabel *addressLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithApplyCarListModel:(ApplyCarDetailModel *)model;

+(CGFloat)CellHeightWithApplyCarListModel:(ApplyCarDetailModel *)model;

@end
