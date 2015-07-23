//
//  SelectDeptmentTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelectDeptmentTableViewCell.h"

@implementation SelectDeptmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, kMainScreenWidth-30-20, 30)];
        _cellTitleLabel.textColor = [UIColor blackColor];
        _cellTitleLabel.font = HEL_14;
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];
    }
    return self;
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
