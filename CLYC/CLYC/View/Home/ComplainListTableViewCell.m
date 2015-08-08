//
//  ComplainListTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/8/8.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ComplainListTableViewCell.h"

@implementation ComplainListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.complainApplyUserTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 20)];
        
        self.complainApplyUserTitleLabel.font = HEL_12;
        
        self.complainApplyUserTitleLabel.textColor = [UIColor blackColor];
        
        self.complainApplyUserTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.complainApplyUserTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.complainApplyUserTitleLabel.text = @"投诉申请人：";
        
        [self.contentView addSubview:self.complainApplyUserTitleLabel];
        
        
        self.complainApplyUserLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.complainApplyUserTitleLabel.frame), CGRectGetMinY(self.complainApplyUserTitleLabel.frame), 90, 20)];
        
        self.complainApplyUserLabel.font = HEL_12;
        
        self.complainApplyUserLabel.textColor = [UIColor blackColor];
        
        self.complainApplyUserLabel.textAlignment = NSTextAlignmentLeft;
        
        self.complainApplyUserLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.complainApplyUserLabel];
        
        
        self.applyTelTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.complainApplyUserLabel.frame), CGRectGetMinY(self.complainApplyUserLabel.frame), 40, 20)];
        
        self.applyTelTitleLabel.font = HEL_12;
        
        self.applyTelTitleLabel.textColor = [UIColor blackColor];
        
        self.applyTelTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.applyTelTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.applyTelTitleLabel.text = @"电话：";
        
        [self.contentView addSubview:self.applyTelTitleLabel];
        
        self.applyTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.applyTelTitleLabel.frame), CGRectGetMinY(self.applyTelTitleLabel.frame), 100, 20)];
        
        self.applyTelLabel.font = HEL_12;
        
        self.applyTelLabel.textColor = [UIColor blackColor];
        
        self.applyTelLabel.textAlignment = NSTextAlignmentLeft;
        
        self.applyTelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.applyTelLabel];
        
        
        self.timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.complainApplyUserTitleLabel.frame), 80, 20)];
        self.timeTitleLabel.font = HEL_12;
        
        self.timeTitleLabel.numberOfLines = 0;
        
        self.timeTitleLabel.textColor = [UIColor blackColor];
        
        self.timeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.timeTitleLabel.text = @"创建时间：";
        
        [self.contentView addSubview:self.timeTitleLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), CGRectGetMaxY(self.complainApplyUserTitleLabel.frame), kMainScreenWidth-10-CGRectGetWidth(self.timeTitleLabel.frame), 20)];
        self.timeLabel.font = HEL_12;
        
        self.timeLabel.textColor = [UIColor blackColor];
        
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.timeLabel];
        
        
        self.statusTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.timeLabel.frame), 80, 20)];
        self.statusTitleLabel.font = HEL_12;
        
        self.statusTitleLabel.numberOfLines = 0;
        
        self.statusTitleLabel.textColor = [UIColor blackColor];
        
        self.statusTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.statusTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.statusTitleLabel.text = @"状态：";
        
        [self.contentView addSubview:self.statusTitleLabel];
        
        self.statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), CGRectGetMaxY(self.timeLabel.frame), kMainScreenWidth-10-CGRectGetWidth(self.timeTitleLabel.frame), 20)];
        self.statusLabel.font = HEL_12;
        
        self.statusLabel.textColor = [UIColor blackColor];
        
        self.statusLabel.textAlignment = NSTextAlignmentLeft;
        
        self.statusLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.statusLabel];
    
    }
    
    return self;
   
}

-(void)setCellContentWithComplainListModel:(ComplainListModel *)model
{
    self.complainApplyUserLabel.text = model.createPersonName;
    self.applyTelLabel.text = model.createPersonTel;
    self.timeLabel.text = model.createTime;
    self.statusLabel.text = model.statusName;
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
