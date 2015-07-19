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
        
        self.projectTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 40, 20)];
        self.projectTitleLabel.font = HEL_12;
        
        self.projectTitleLabel.textColor = [UIColor blackColor];
        
        self.projectTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.projectTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.projectTitleLabel.text = @"项目：";
        
        [self.contentView addSubview:self.projectTitleLabel];
        
        
        self.projectNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.projectTitleLabel.frame), 5, kMainScreenWidth-10-CGRectGetWidth(self.projectTitleLabel.frame), 20)];
        self.projectNameLabel.font = HEL_12;
        
        self.projectNameLabel.textColor = [UIColor blackColor];
        
        self.projectNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.projectNameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.projectNameLabel];
        

        
        self.timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.projectTitleLabel.frame), 40, 30)];
        self.timeTitleLabel.font = HEL_12;
        
        self.timeTitleLabel.numberOfLines = 0;
        
        self.timeTitleLabel.textColor = [UIColor blackColor];
        
        self.timeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeTitleLabel.backgroundColor = [UIColor clearColor];
        
         self.timeTitleLabel.text = @"时间：";
        
        [self.contentView addSubview:self.timeTitleLabel];
        
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), CGRectGetMaxY(self.projectTitleLabel.frame), kMainScreenWidth-10-CGRectGetWidth(self.timeTitleLabel.frame), 30)];
        self.timeLabel.font = HEL_12;
        
        self.timeLabel.textColor = [UIColor blackColor];
        
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.timeLabel];
        
        self.carCodeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.timeLabel.frame), 40, 20)];
        self.carCodeTitleLabel.font = HEL_12;
        
        self.carCodeTitleLabel.textColor = [UIColor blackColor];
        
        self.carCodeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carCodeTitleLabel.text = @"车牌：";
        
        [self.contentView addSubview:self.carCodeTitleLabel];
        
        
        self.carCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carCodeTitleLabel.frame), CGRectGetMaxY(self.timeLabel.frame), 100, 20)];
        self.carCodeLabel.font = HEL_12;
        
        self.carCodeLabel.textColor = [UIColor blackColor];
        
        self.carCodeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carCodeLabel];
        
        
        
        self.mileTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carCodeLabel.frame)+10, CGRectGetMaxY(self.timeLabel.frame), 90, 20)];
        
        self.mileTitleLabel.font = HEL_12;
        
        self.mileTitleLabel.textColor = [UIColor blackColor];
        
        self.mileTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.mileTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.mileTitleLabel.text = @"里程（公里）：";
        
        [self.contentView addSubview:self.mileTitleLabel];
        
        
        self.mileLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mileTitleLabel.frame), CGRectGetMaxY(self.timeLabel.frame), 70, 20)];
        
        
        self.mileLabel.font = HEL_12;
        
        self.mileLabel.textColor = [UIColor blackColor];
        
        self.mileLabel.textAlignment = NSTextAlignmentLeft;
        
        self.mileLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.mileLabel];
        
        
        
        self.driverTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.carCodeLabel.frame), 40, 20)];
        
        self.driverTitleLabel.font = HEL_12;
        
        self.driverTitleLabel.textColor = [UIColor blackColor];
        
        self.driverTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.driverTitleLabel.text = @"司机：";
        
        [self.contentView addSubview:self.driverTitleLabel];
        
        
        
        self.driverLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverTitleLabel.frame), CGRectGetMaxY(self.carCodeLabel.frame), 100, 20)];
        
        self.driverLabel.font = HEL_12;
        
        self.driverLabel.textColor = [UIColor blackColor];
        
        self.driverLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverLabel];
        
        
        self.driverTelTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverLabel.frame)+10, CGRectGetMaxY(self.carCodeLabel.frame), 40, 20)];
        
        self.driverTelTitleLabel.font = HEL_12;
        
        self.driverTelTitleLabel.textColor = [UIColor blackColor];
        
        self.driverTelTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverTelTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.driverTelTitleLabel.text = @"电话：";
        
        [self.contentView addSubview:self.driverTelTitleLabel];
        
        
        self.driverTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverTelTitleLabel.frame), CGRectGetMaxY(self.carCodeLabel.frame), 100, 20)];
        
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
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@",model.beginTime,model.endTime];

    self.carCodeLabel.text = [NSString stringWithFormat:@"%@",model.carCode];
    
    self.mileLabel.text = [NSString stringWithFormat:@"%@",model.totalMil];
    
    self.driverLabel.text = [NSString stringWithFormat:@"%@",model.driver];
    
    self.driverTelLabel.text = [NSString stringWithFormat:@"%@",model.driverTel];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
   
    CGContextSetStrokeColorWithColor(context, CELL_LINE_COLOR.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.5));
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
