//
//  SelectCarTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/5.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelectCarTableViewCell.h"

@implementation SelectCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 30, 30)];
        _headImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_headImageView];
        
        self.carCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame), 5, 100, 20)];
        self.carCodeLabel.font = HEL_10;
        
        self.carCodeLabel.textColor = [UIColor blackColor];
        
        self.carCodeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carCodeLabel];
        
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carCodeLabel.frame)+10, 5, 100, 20)];
        
        
        self.priceLabel.font = HEL_10;
        
        self.priceLabel.textColor = [UIColor blackColor];
        
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        
        self.priceLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.priceLabel];
        
        
        self.driverLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame), CGRectGetMaxY(self.carCodeLabel.frame), 100, 20)];
        
        self.driverLabel.font = HEL_10;
        
        self.driverLabel.textColor = [UIColor blackColor];
        
        self.driverLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverLabel];
        
        self.driverTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverLabel.frame), CGRectGetMaxY(self.carCodeLabel.frame), 100, 20)];
        
        self.driverTelLabel.font = HEL_10;
        
        self.driverTelLabel.textColor = [UIColor blackColor];
        
        self.driverTelLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverTelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverTelLabel];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(18, 49.5, kMainScreenWidth -18, 0.5)];
        lineView.backgroundColor = UIColorFromRGB(0x709981);
        
        [self.contentView addSubview:lineView];
        
        
        
        
    }
    
    return self;
    
}

-(void)setCellContentWithSelectedModel:(SelectCarInfoModel *)model
{
    _headImageView.image = [UIImage imageNamed:@"car_temp.png"];
    
    if ([model.catType isEqualToString:@"2"])
    {
        self.carCodeLabel.text = [NSString stringWithFormat:@"车牌：%@(外)",model.carCode];
    }
    else
    {
        self.carCodeLabel.text = [NSString stringWithFormat:@"车牌：%@",model.carCode];
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"单价：%@元/公里",model.price];
    
    self.driverLabel.text = [NSString stringWithFormat:@"司机：%@",model.driver];
    
    self.driverTelLabel.text = [NSString stringWithFormat:@"电话：%@",model.driverTel];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
