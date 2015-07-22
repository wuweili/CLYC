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
            //用车时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_15;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.userInteractionEnabled = NO;
            //            _cellTextView.delegate = self;
            _cellTextView.tag = 1000;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            if (CurrentSystemVersion >= 7.0) {
                
                UIEdgeInsets inset = _cellTextView.textContainerInset;
                
                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
            }
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 1)
        {
            _cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            
            _cellContentLabel.textColor = [UIColor blackColor];
            _cellContentLabel.font = HEL_15;
            _cellContentLabel.textAlignment = NSTextAlignmentLeft;
            _cellContentLabel.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_cellContentLabel];
        }
        else if (indexPath.row == 2)
        {
            _cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            
            _cellContentLabel.textColor = [UIColor blackColor];
            _cellContentLabel.font = HEL_15;
            _cellContentLabel.textAlignment = NSTextAlignmentLeft;
            _cellContentLabel.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_cellContentLabel];
        }
        else if (indexPath.row == 3)
        {
            _cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            
            _cellContentLabel.textColor = [UIColor blackColor];
            _cellContentLabel.font = HEL_15;
            _cellContentLabel.textAlignment = NSTextAlignmentLeft;
            _cellContentLabel.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_cellContentLabel];
        }
        else if (indexPath.row == 4)
        {
            //用车时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_15;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.userInteractionEnabled = NO;
            //            _cellTextView.delegate = self;
            _cellTextView.tag = 1004;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            if (CurrentSystemVersion >= 7.0) {
                
                UIEdgeInsets inset = _cellTextView.textContainerInset;
                
                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
            }
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 5)
        {
            //用车时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_15;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.userInteractionEnabled = NO;
            //            _cellTextView.delegate = self;
            _cellTextView.tag = 1005;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            if (CurrentSystemVersion >= 7.0) {
                
                UIEdgeInsets inset = _cellTextView.textContainerInset;
                
                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
            }
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 6)
        {
            //用车时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_15;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.userInteractionEnabled = NO;
            _cellTextView.tag = 1006;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            if (CurrentSystemVersion >= 7.0) {
                
                UIEdgeInsets inset = _cellTextView.textContainerInset;
                
                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
            }
            [self.contentView addSubview:_cellTextView];
        }
        else
        {
            _cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            
            _cellContentLabel.textColor = [UIColor blackColor];
            _cellContentLabel.font = HEL_15;
            _cellContentLabel.textAlignment = NSTextAlignmentLeft;
            _cellContentLabel.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_cellContentLabel];
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
