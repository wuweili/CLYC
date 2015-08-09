//
//  D_driverCheckTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/8/9.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "D_driverCheckTableViewCell.h"

@implementation D_driverCheckTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        self.driverTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 90, 20)];
        self.driverTitleLabel.textColor = [UIColor blackColor];
        self.driverTitleLabel.font = HEL_14;
        self.driverTitleLabel.textAlignment = NSTextAlignmentRight;
        self.driverTitleLabel.backgroundColor = [UIColor clearColor];
        self.driverTitleLabel.text = @"司机：";
        [self.contentView addSubview:self.driverTitleLabel];
        
        self.driverLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.driverTitleLabel.frame), CGRectGetMinY(self.driverTitleLabel.frame), kMainScreenWidth-10-CGRectGetMaxX(self.driverTitleLabel.frame), 20)];
        self.driverLabel.textColor = [UIColor blackColor];
        self.driverLabel.font = HEL_14;
        self.driverLabel.textAlignment = NSTextAlignmentLeft;
        self.driverLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driverLabel];
        
        
        self.checkTimeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.driverTitleLabel.frame), 90, 20)];
        self.checkTimeTitleLabel.textColor = [UIColor blackColor];
        self.checkTimeTitleLabel.font = HEL_14;
        self.checkTimeTitleLabel.textAlignment = NSTextAlignmentRight;
        self.checkTimeTitleLabel.text = @"考核时间：";
        self.checkTimeTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.checkTimeTitleLabel];
        
        self.checkTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.checkTimeTitleLabel.frame), CGRectGetMinY(self.checkTimeTitleLabel.frame), kMainScreenWidth-10-CGRectGetMaxX(self.checkTimeTitleLabel.frame), 20)];
        self.checkTimeLabel.textColor = [UIColor blackColor];
        self.checkTimeLabel.font = HEL_14;
        self.checkTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.checkTimeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.checkTimeLabel];
        
        self.gradeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.checkTimeTitleLabel.frame), 90, 20)];
        self.gradeTitleLabel.textColor = [UIColor blackColor];
        self.gradeTitleLabel.font = HEL_14;
        self.gradeTitleLabel.textAlignment = NSTextAlignmentRight;
        self.gradeTitleLabel.backgroundColor = [UIColor clearColor];
        self.gradeTitleLabel.text = @"等级：";
        [self.contentView addSubview:self.gradeTitleLabel];
        
        self.gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.gradeTitleLabel.frame), CGRectGetMinY(self.gradeTitleLabel.frame), kMainScreenWidth-10-CGRectGetMaxX(self.gradeTitleLabel.frame), 20)];
        self.gradeLabel.textColor = [UIColor blackColor];
        self.gradeLabel.font = HEL_14;
        self.gradeLabel.textAlignment = NSTextAlignmentLeft;
        self.gradeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.gradeLabel];
   
    }
    
    return self;
}

-(void)setCellContentWithCheckModel:(DriverCheckModel *)model
{
    self.driverLabel.text = model.driverName;
    self.checkTimeLabel.text = model.checkTime;
    self.gradeLabel.text = model.gradeName;
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
