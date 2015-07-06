//
//  ApplyCarHistoryTableViewCell.m
//  CLYC
//
//  Created by weili.wu on 15/7/6.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ApplyCarHistoryTableViewCell.h"

@implementation ApplyCarHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        
        self.projectTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 30, 20)];
        self.projectTitleLabel.font = HEL_12;
        
        self.projectTitleLabel.textColor = [UIColor blackColor];
        
        self.projectTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.projectTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.projectTitleLabel.text = @"项目";
        
        [self.contentView addSubview:self.projectTitleLabel];
        
        
        self.projectNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.projectTitleLabel.frame), 5, kMainScreenWidth-10-CGRectGetWidth(self.projectTitleLabel.frame), 20)];
        self.projectNameLabel.font = HEL_12;
        
        self.projectNameLabel.textColor = [UIColor blackColor];
        
        self.projectNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.projectNameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.projectNameLabel];
        

        
        self.timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.projectTitleLabel.frame)+5, 30, 30)];
        self.timeTitleLabel.font = HEL_12;
        
        self.timeTitleLabel.numberOfLines = 0;
        
        self.timeTitleLabel.textColor = [UIColor blackColor];
        
        self.timeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeTitleLabel.backgroundColor = [UIColor clearColor];
        
         self.timeTitleLabel.text = @"时间";
        
        [self.contentView addSubview:self.timeTitleLabel];
        
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), 5, kMainScreenWidth-10-CGRectGetWidth(self.timeTitleLabel.frame), 30)];
        self.timeLabel.font = HEL_12;
        
        self.timeLabel.textColor = [UIColor blackColor];
        
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.timeLabel];
        

        
        self.carCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.timeLabel.frame), 120, 20)];
        self.carCodeLabel.font = HEL_12;
        
        self.carCodeLabel.textColor = [UIColor blackColor];
        
        self.carCodeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carCodeLabel];
        
        
        self.mileLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carCodeLabel.frame)+10, 5, 120, 20)];
        
        
        self.mileLabel.font = HEL_12;
        
        self.mileLabel.textColor = [UIColor blackColor];
        
        self.mileLabel.textAlignment = NSTextAlignmentLeft;
        
        self.mileLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.mileLabel];
        
        
        self.driverLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.carCodeLabel.frame), 120, 20)];
        
        self.driverLabel.font = HEL_12;
        
        self.driverLabel.textColor = [UIColor blackColor];
        
        self.driverLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverLabel];
        
        self.driverTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverLabel.frame)+10, CGRectGetMaxY(self.carCodeLabel.frame), 120, 20)];
        
        self.driverTelLabel.font = HEL_12;
        
        self.driverTelLabel.textColor = [UIColor blackColor];
        
        self.driverTelLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverTelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverTelLabel];
     
    }
    
    return self;
    
}

-(void)setCellContentWithApplyCarListModel:(ApplyCarListModel *)model
{
    self.projectNameLabel.text = model.projectName;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@",model.beginTime,model.endTime];

    self.carCodeLabel.text = [NSString stringWithFormat:@"车牌：%@",model.carCode];
    
    self.mileLabel.text = [NSString stringWithFormat:@"里程（公里）：%@",model.totalMil];
    
    self.driverLabel.text = [NSString stringWithFormat:@"司机：%@",model.driver];
    
    self.driverTelLabel.text = [NSString stringWithFormat:@"电话：%@",model.driverTel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
