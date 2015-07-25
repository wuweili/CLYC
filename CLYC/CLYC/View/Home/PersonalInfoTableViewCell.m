//
//  PersonalInfoTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/25.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "PersonalInfoTableViewCell.h"

@implementation PersonalInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 2, 80, 40)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_14;
        _cellTitleLabel.numberOfLines = 0;
        _cellTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];
        
        _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width, 7, kMainScreenWidth-15-CGRectGetMaxX(_cellTitleLabel.frame), 30)];
        _cellTextView.textColor = [UIColor blackColor];
        _cellTextView.scrollEnabled = YES;
        _cellTextView.font = HEL_14;
        _cellTextView.returnKeyType = UIReturnKeyDone;
        _cellTextView.showsVerticalScrollIndicator = NO;
        _cellTextView.userInteractionEnabled = NO;
        
        _cellTextView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_cellTextView];
        
        
    }
    
    return self;
    
}

-(void)setCellContentWithText:(NSString *)text
{
    _cellTextView.text = text;
    [self changeheightForTextView:_cellTextView];
}

-(void)changeheightForTextView:(UITextView *)textView
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(CGRectGetWidth(textView.frame) - fPadding, CGFLOAT_MAX);
    CGSize size = [textView.text sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat heightTextView = size.height + 16.0;
    
    if (heightTextView <30)
    {
        heightTextView = 30;
    }
    
    [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, heightTextView)];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, kMainScreenWidth, heightTextView+14)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
