//
//  SelectCarTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/5.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectCarTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *carCodeLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *driverLabel;

@property(nonatomic,strong)UILabel *driverTelLabel;

@property(nonatomic,strong)UIImageView *headImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithSelectedModel:(SelectCarInfoModel *)model;

@end
