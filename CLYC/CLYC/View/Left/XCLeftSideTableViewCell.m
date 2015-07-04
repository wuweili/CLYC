//
//  XCLeftSideTableViewCell.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/15.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCLeftSideTableViewCell.h"
#import "UIImageView+Avatar.h"

@implementation XCLeftSideTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 13, 24, 24)];
        _headImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_headImageView];
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.frame.origin.x+_headImageView.frame.size.width +10, _headImageView.frame.origin.y, self.frame.size.width, 24)];
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellTitleLabel.font = HEL_18;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        _cellTitleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_cellTitleLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(18, 49.5, kMainScreenWidth -18, 0.5)];
        lineView.backgroundColor = UIColorFromRGB(0x709981);
        
        [self.contentView addSubview:lineView];
        
        
        
        
    }
    
    return self;
    
}

-(void)setCellContentWithIndexPath:(NSIndexPath *)indexPath imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    UIImage *image = [imageArray objectAtIndex:indexPath.row ];
    NSString *title = [titleArray objectAtIndex:indexPath.row];
    _headImageView.image = image;
    _cellTitleLabel.text = title;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
