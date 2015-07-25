//
//  ConfirmMileTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/25.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "ConfirmMileTableViewCell.h"

@implementation ConfirmMileTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        //车牌
        
        self.carCodeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 40, 20)];
        self.carCodeTitleLabel.font = HEL_12;
        
        self.carCodeTitleLabel.textColor = [UIColor blackColor];
        
        self.carCodeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carCodeTitleLabel.text = @"车牌：";
        
        [self.contentView addSubview:self.carCodeTitleLabel];
        
        self.carCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carCodeTitleLabel.frame), CGRectGetMinY(self.carCodeTitleLabel.frame), 200, 20)];
        self.carCodeLabel.font = HEL_12;
        
        self.carCodeLabel.textColor = [UIColor blackColor];
        
        self.carCodeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carCodeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carCodeLabel];
        
        //司机
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
        
        self.timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.driverTelLabel.frame), 40, 30)];
        self.timeTitleLabel.font = HEL_12;
        
        self.timeTitleLabel.numberOfLines = 0;
        
        self.timeTitleLabel.textColor = [UIColor blackColor];
        
        self.timeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.timeTitleLabel.text = @"时间：";
        
        [self.contentView addSubview:self.timeTitleLabel];
        
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), CGRectGetMaxY(self.driverTelLabel.frame), kMainScreenWidth-10-CGRectGetWidth(self.timeTitleLabel.frame), 30)];
        self.timeLabel.font = HEL_12;
        
        self.timeLabel.textColor = [UIColor blackColor];
        
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.timeLabel];
        
        
        //地点
        self.addressTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.timeLabel.frame), 40, 30)];
        self.addressTitleLabel.font = HEL_12;
        
        self.addressTitleLabel.numberOfLines = 0;
        
        self.addressTitleLabel.textColor = [UIColor blackColor];
        
        self.addressTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.addressTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.addressTitleLabel.text = @"地点：";
        
        [self.contentView addSubview:self.addressTitleLabel];
        
        
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressTitleLabel.frame), CGRectGetMinY(self.addressTitleLabel.frame), kMainScreenWidth-10-CGRectGetWidth(self.addressTitleLabel.frame), 30)];
        self.addressLabel.font = HEL_12;
        
        self.addressLabel.textColor = [UIColor blackColor];
        
        self.addressLabel.numberOfLines = 0;
        
        self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.addressLabel.textAlignment = NSTextAlignmentLeft;
        
        self.addressLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.addressLabel];
   
    }
    
    return self;
    
    
}

-(void)setCellContentWithApplyCarListModel:(ApplyCarDetailModel *)model
{
    self.carCodeLabel.text = [NSString stringWithFormat:@"%@",model.selectedCarModel.carCode];
    
    self.driverLabel.text = [NSString stringWithFormat:@"%@",model.driver];
    
    self.driverTelLabel.text = [NSString stringWithFormat:@"%@",model.driverTel];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@",model.beginTime,model.endTime];
    self.addressLabel.text = [NSString stringWithFormat:@"%@ 至 %@",model.beginAdrr,model.endAdrr];
    
    [self changeheightForLabel:self.addressLabel];
    
}

#pragma mark - UIlabel 高度变化及cell高度
-(void)changeheightForLabel:(UILabel *)label
{
    
    CGSize constraint = CGSizeMake(CGRectGetWidth(label.frame), CGFLOAT_MAX);
    CGSize size = [label.text sizeWithFont: label.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float heightUILabel = size.height;
    
    if (heightUILabel <30)
    {
        heightUILabel = 30;
    }

    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, heightUILabel)];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, kMainScreenWidth, CGRectGetMaxY(label.frame)+5)];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, CELL_LINE_COLOR.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.5));
    
}

+(CGFloat)CellHeightWithApplyCarListModel:(ApplyCarDetailModel *)model
{
    CGSize constraint = CGSizeMake(kMainScreenWidth-10-40, CGFLOAT_MAX);
    
    
    NSString *address =  [NSString stringWithFormat:@"%@ 至 %@",model.beginAdrr,model.endAdrr];
    
    CGSize size = [address sizeWithFont: HEL_12 constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float heightUILabel = size.height;
    
    if (heightUILabel <30)
    {
        heightUILabel = 30;
    }
    
    return 5+20+20+30+heightUILabel+5;
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
