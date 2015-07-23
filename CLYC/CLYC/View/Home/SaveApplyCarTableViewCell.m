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
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, titleLabelwidth, 30)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_14;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];

        if (indexPath.row == 0)
        {
            //用车时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1000;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];

            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 1)
        {
            //车牌号
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1001;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 2)
        {
            //用车部门
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1002;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 3)
        {
            //项目名称
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1003;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 4)
        {
            //出发地
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            //            _cellTextView.delegate = self;
            _cellTextView.tag = 1004;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
//            if (CurrentSystemVersion >= 7.0) {
//                
//                UIEdgeInsets inset = _cellTextView.textContainerInset;
//                
//                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
//            }
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 5)
        {
            //目的地
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1005;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
//            if (CurrentSystemVersion >= 7.0) {
//                
//                UIEdgeInsets inset = _cellTextView.textContainerInset;
//                
//                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
//            }
            [self.contentView addSubview:_cellTextView];
        }
        else if (indexPath.row == 6)
        {
            //车辆用途
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1006;
            _cellTextView.showsVerticalScrollIndicator = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
//            if (CurrentSystemVersion >= 7.0) {
//                
//                UIEdgeInsets inset = _cellTextView.textContainerInset;
//                
//                _cellTextView.textContainerInset = UIEdgeInsetsMake(inset.top,-4,inset.bottom,-4);
//            }
            [self.contentView addSubview:_cellTextView];
        }
        else
        {
            //用车人
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, contentMaxWidth, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1007;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = NO;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_cellTextView];
        }
        
        
        
    }
    
    return self;
}

-(void)setContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text
{
    self.indexPath = indexPath;

    if (indexPath.row == 0)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];
    }
    else if (indexPath.row == 1)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];

    }
    else if (indexPath.row == 2)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];


    }
    else if (indexPath.row == 3)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];


    }
    else if (indexPath.row == 4)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];

    }
    else if (indexPath.row == 5)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];

    }
    else if (indexPath.row == 6)
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];

    }
    else
    {
        _cellTextView.text = text;
        [self changeheightForTextView:_cellTextView];


    }
    
    
    
}



#pragma mark - UITextView 高度变化及cell高度

-(void)changeheightForTextView:(UITextView *)textView
{
    CGFloat heightTextView = [self heightForTextViewWithText:textView.text andFont:textView.font];
    
    [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, heightTextView)];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, kMainScreenWidth, heightTextView+10)];
    
}

- (CGFloat)heightForTextViewWithText:(NSString *)text andFont:(UIFont *)font
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(contentMaxWidth - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont: font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    
    if (fHeight <30)
    {
        fHeight = 30;
    }
    
    return fHeight;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
