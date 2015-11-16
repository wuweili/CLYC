//
//  SelectProjectTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SelectProjectTableViewCell.h"

@implementation SelectProjectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _projectNumTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        _projectNumTitleLabel.textColor = [UIColor blackColor];
        _projectNumTitleLabel.font = HEL_14;
        _projectNumTitleLabel.textAlignment = NSTextAlignmentRight;
        _projectNumTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_projectNumTitleLabel];
        
        _projectNumContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_projectNumTitleLabel.frame), 5, kMainScreenWidth-50-CGRectGetMaxX(_projectNumTitleLabel.frame), 20)];
        _projectNumContentLabel.textColor = [UIColor blackColor];
        _projectNumContentLabel.font = HEL_14;
        _projectNumContentLabel.textAlignment = NSTextAlignmentLeft;
        _projectNumContentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_projectNumContentLabel];
        
        _projectNameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_projectNumTitleLabel.frame)+5, 80, 20)];
        _projectNameTitleLabel.textColor = [UIColor blackColor];
        _projectNameTitleLabel.font = HEL_14;
        _projectNameTitleLabel.textAlignment = NSTextAlignmentRight;
        _projectNameTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_projectNameTitleLabel];
        
        _projectNameContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_projectNameTitleLabel.frame), CGRectGetMinY(_projectNameTitleLabel.frame), kMainScreenWidth-10-CGRectGetMaxX(_projectNameTitleLabel.frame), 20)];
        _projectNameContentLabel.textColor = [UIColor blackColor];
        _projectNameContentLabel.font = HEL_14;
        _projectNameContentLabel.textAlignment = NSTextAlignmentLeft;
        _projectNameContentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_projectNameContentLabel];
        
    }
    
    return self;
}

-(void)setCellContentWithProjectModel:(ProjectListModel *)model
{
    _projectNumTitleLabel.text = @"项目号：";
    _projectNumContentLabel.text = model.projectNo;
    
    _projectNameTitleLabel.text = @"项目名称：";
    _projectNameContentLabel.text = model.projectName;
    
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
