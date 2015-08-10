//
//  CostSearchTableViewCell.m
//  CLYC
//
//  Created by weili.wu on 15/8/10.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "CostSearchTableViewCell.h"

@implementation CostSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.depTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 20)];
        self.depTitleLabel.font = HEL_12;
        
        self.depTitleLabel.textColor = [UIColor blackColor];
        
        self.depTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.depTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.depTitleLabel.text = @"用车部门：";
        
        [self.contentView addSubview:self.depTitleLabel];
        
        
        self.depLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.depTitleLabel.frame), CGRectGetMinY(self.depTitleLabel.frame), kMainScreenWidth-5-CGRectGetMaxX(self.depTitleLabel.frame), 20)];
        self.depLabel.font = HEL_12;
        
        self.depLabel.textColor = [UIColor blackColor];
        
        self.depLabel.textAlignment = NSTextAlignmentLeft;
        
        self.depLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.depLabel];
        
        
        
        
        self.projectTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.depTitleLabel.frame), 70, 20)];
        self.projectTitleLabel.font = HEL_12;
        
        self.projectTitleLabel.textColor = [UIColor blackColor];
        
        self.projectTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.projectTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.projectTitleLabel.text = @"项目名称：";
        
        [self.contentView addSubview:self.projectTitleLabel];
        
        
        self.projectNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.projectTitleLabel.frame), CGRectGetMinY(self.projectTitleLabel.frame), kMainScreenWidth-5-CGRectGetMaxX(self.projectTitleLabel.frame), 20)];
        self.projectNameLabel.font = HEL_12;
        
        self.projectNameLabel.textColor = [UIColor blackColor];
        
        self.projectNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.projectNameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.projectNameLabel];
        
        
        
        self.carCodeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.projectNameLabel.frame), 70, 20)];
        self.carCodeTitleLabel.font = HEL_12;
        
        self.carCodeTitleLabel.textColor = [UIColor blackColor];
        
        self.carCodeTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.carCodeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carCodeTitleLabel.text = @"车牌：";
        
        [self.contentView addSubview:self.carCodeTitleLabel];
        
        
        self.carCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carCodeTitleLabel.frame), CGRectGetMinY(self.carCodeTitleLabel.frame), kMainScreenWidth-5-CGRectGetMaxX(self.carCodeTitleLabel.frame), 20)];
        self.carCodeLabel.font = HEL_12;
        
        self.carCodeLabel.textColor = [UIColor blackColor];
        
        self.carCodeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carCodeLabel];
        
        
        
        
        self.timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.carCodeLabel.frame), 70, 20)];
        self.timeTitleLabel.font = HEL_12;
        
        self.timeTitleLabel.textColor = [UIColor blackColor];
        
        self.timeTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.timeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.timeTitleLabel.text = @"时间：";
        
        [self.contentView addSubview:self.timeTitleLabel];
        
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), CGRectGetMinY(self.timeTitleLabel.frame), kMainScreenWidth-5-CGRectGetMaxX(self.timeTitleLabel.frame), 20)];
        self.timeLabel.font = HEL_12;
        
        self.timeLabel.textColor = [UIColor blackColor];
        
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.timeLabel];
        
        
        
        
        self.carUserTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.timeTitleLabel.frame), 70, 20)];
        self.carUserTitleLabel.font = HEL_12;
        
        self.carUserTitleLabel.textColor = [UIColor blackColor];
        
        self.carUserTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.carUserTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carUserTitleLabel.text = @"用车人：";
        
        [self.contentView addSubview:self.carUserTitleLabel];
        
        
        self.carUserLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carUserTitleLabel.frame), CGRectGetMinY(self.carUserTitleLabel.frame), 80, 20)];
        self.carUserLabel.font = HEL_12;
        
        self.carUserLabel.textColor = [UIColor blackColor];
        
        self.carUserLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carUserLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carUserLabel];
        
        
        self.carUserTelTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carUserLabel.frame), CGRectGetMinY(self.carUserLabel.frame), 80, 20)];
        self.carUserTelTitleLabel.font = HEL_12;
        
        self.carUserTelTitleLabel.textColor = [UIColor blackColor];
        
        self.carUserTelTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.carUserTelTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carUserTelTitleLabel.text = @"用车人电话：";
        
        [self.contentView addSubview:self.carUserTelTitleLabel];
        
        
        self.carUserTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carUserTelTitleLabel.frame), CGRectGetMinY(self.carUserTelTitleLabel.frame), 100, 20)];
        self.carUserTelLabel.font = HEL_12;
        
        self.carUserTelLabel.textColor = [UIColor blackColor];
        
        self.carUserTelLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carUserTelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carUserTelLabel];
        
        
        
        
        
        self.driverTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.carUserLabel.frame), 70, 20)];
        self.driverTitleLabel.font = HEL_12;
        
        self.driverTitleLabel.textColor = [UIColor blackColor];
        
        self.driverTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.driverTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.driverTitleLabel.text = @"司机：";
        
        [self.contentView addSubview:self.driverTitleLabel];
        
        
        self.driverLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverTitleLabel.frame), CGRectGetMinY(self.driverTitleLabel.frame), 80, 20)];
        self.driverLabel.font = HEL_12;
        
        self.driverLabel.textColor = [UIColor blackColor];
        
        self.driverLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverLabel];
        
        
        self.driverTelTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverLabel.frame), CGRectGetMinY(self.driverLabel.frame), 80, 20)];
        self.driverTelTitleLabel.font = HEL_12;
        
        self.driverTelTitleLabel.textColor = [UIColor blackColor];
        
        self.driverTelTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.driverTelTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.driverTelTitleLabel.text = @"司机电话：";
        
        [self.contentView addSubview:self.driverTelTitleLabel];
        
        
        self.driverTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverTelTitleLabel.frame), CGRectGetMinY(self.driverTelTitleLabel.frame), 100, 20)];
        self.driverTelLabel.font = HEL_12;
        
        self.driverTelLabel.textColor = [UIColor blackColor];
        
        self.driverTelLabel.textAlignment = NSTextAlignmentLeft;
        
        self.driverTelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.driverTelLabel];
        
        
        
        
        
        self.mileTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.driverTelLabel.frame), 70, 20)];
        self.mileTitleLabel.font = HEL_12;
        
        self.mileTitleLabel.textColor = [UIColor blackColor];
        
        self.mileTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.mileTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.mileTitleLabel.text =@"里程(公里)：";
        
        [self.contentView addSubview:self.mileTitleLabel];
        
        
        self.mileLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mileTitleLabel.frame), CGRectGetMinY(self.mileTitleLabel.frame), 80, 20)];
        self.mileLabel.font = HEL_12;
        
        self.mileLabel.textColor = [UIColor blackColor];
        
        self.mileLabel.textAlignment = NSTextAlignmentLeft;
        
        self.mileLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.mileLabel];
        
        
        
        
        
        self.costTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mileLabel.frame), CGRectGetMinY(self.mileLabel.frame), 80, 20)];
        self.costTitleLabel.font = HEL_12;
        
        self.costTitleLabel.textColor = [UIColor blackColor];
        
        self.costTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.costTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.costTitleLabel.text = @"费用：";
        
        [self.contentView addSubview:self.costTitleLabel];
        
        
        self.costLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.costTitleLabel.frame), CGRectGetMinY(self.costTitleLabel.frame), 100, 20)];
        self.costLabel.font = HEL_12;
        
        self.costLabel.textColor = [UIColor blackColor];
        
        self.costLabel.textAlignment = NSTextAlignmentLeft;
        
        self.costLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.costLabel];
    
    }
    
    return self;
    
    
}

-(void)setCellContentWithApplyCarModel:(ApplyCarDetailModel *)model
{
    self.depLabel.text = model.deptModel.deptName;
    
    self.projectNameLabel.text = model.projectModel.projectName;
    
    self.carCodeLabel.text = [NSString stringWithFormat:@"%@",model.selectedCarModel.carCode];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@",model.beginTime,model.endTime];
    
    self.carUserLabel.text = model.carAppUserName;
    
    self.carUserTelLabel.text = model.carAppUserTel;
    
    self.driverLabel.text = model.driver;
    
    self.driverTelLabel.text = model.driverTel;
    
    self.mileLabel.text = model.totalMil;
    
    self.costLabel.text = model.cost;
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, CELL_LINE_COLOR.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.5));
    
}


@end
