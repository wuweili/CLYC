//
//  D_ApplyCarListTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "D_ApplyCarListTableViewCell.h"

@implementation D_ApplyCarListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.carUserNameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 20)];
        
        self.carUserNameTitleLabel.font = HEL_12;
        
        self.carUserNameTitleLabel.textColor = [UIColor blackColor];
        
        self.carUserNameTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carUserNameTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carUserNameTitleLabel.text = @"用车人：";
        
        [self.contentView addSubview:self.carUserNameTitleLabel];
        
        self.carUserNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carUserNameTitleLabel.frame), CGRectGetMinY(self.carUserNameTitleLabel.frame), 100, 20)];
        
        self.carUserNameLabel.font = HEL_12;
        
        self.carUserNameLabel.textColor = [UIColor blackColor];
        
        self.carUserNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carUserNameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carUserNameLabel];
        
        self.carUserTelTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carUserNameLabel.frame)+10, CGRectGetMinY(self.carUserNameLabel.frame), 40, 20)];
        
        self.carUserTelTitleLabel.font = HEL_12;
        
        self.carUserTelTitleLabel.textColor = [UIColor blackColor];
        
        self.carUserTelTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carUserTelTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.carUserTelTitleLabel.text = @"电话：";
        
        [self.contentView addSubview:self.carUserTelTitleLabel];
        
        
        self.carUserTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carUserTelTitleLabel.frame), CGRectGetMinY(self.carUserTelTitleLabel.frame), 100, 20)];
        
        self.carUserTelLabel.font = HEL_12;
        
        self.carUserTelLabel.textColor = [UIColor blackColor];
        
        self.carUserTelLabel.textAlignment = NSTextAlignmentLeft;
        
        self.carUserTelLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.carUserTelLabel];
        
        
        self.timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.carUserTelLabel.frame), 40, 30)];
        self.timeTitleLabel.font = HEL_12;
        
        self.timeTitleLabel.numberOfLines = 0;
        
        self.timeTitleLabel.textColor = [UIColor blackColor];
        
        self.timeTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeTitleLabel.backgroundColor = [UIColor clearColor];
        
        self.timeTitleLabel.text = @"时间：";
        
        [self.contentView addSubview:self.timeTitleLabel];
        
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTitleLabel.frame), CGRectGetMaxY(self.carUserTelLabel.frame), kMainScreenWidth-10-CGRectGetWidth(self.timeTitleLabel.frame), 30)];
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
    self.carUserNameLabel.text = model.carAppUserName;
    self.carUserTelLabel.text = model.carAppUserTel;
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
    
    return 5+20+30+heightUILabel+5;
    
    
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
