//
//  SaveApplyCarTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/21.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SaveApplyCarTableViewCell.h"

const static int contentMaxWidth = 200;

const static int heigth_weigth_Width = 60;

const static int titleLabelwidth = 80;


@implementation SaveApplyCarTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.indexPath = indexPath;
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, titleLabelwidth, 30)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_15;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];

        if (indexPath.row == 0)
        {
            
        }
        else if (indexPath.row == 1)
        {
            
        }
        else if (indexPath.row == 2)
        {
            
        }
        else if (indexPath.row == 3)
        {
            
        }
        else if (indexPath.row == 4)
        {
            
        }
        else if (indexPath.row == 5)
        {
            
        }
        else if (indexPath.row == 6)
        {
            
        }
        
        
        
        
    }
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
