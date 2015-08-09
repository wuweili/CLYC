//
//  SaveApplyCarTableViewCell.m
//  CLYC
//
//  Created by wuweiqing on 15/7/21.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "SaveApplyCarTableViewCell.h"


const static int titleLabelwidth = 90;


@implementation SaveApplyCarTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.indexPath = indexPath;
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, titleLabelwidth, 30)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_14;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];

        if (indexPath.row == 0)
        {
            //用车时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2 , 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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


-(id)initMileInfoWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.indexPath = indexPath;
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 100, 40)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_13;
        _cellTitleLabel.numberOfLines = 0;
        _cellTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];
        
        _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, 7, kMainScreenWidth-10-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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


-(id)initSaveComplainWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.indexPath = indexPath;
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, titleLabelwidth, 30)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_14;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];
        
        if (indexPath.row == 0)
        {
            //投诉申请人
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2 , 30)];
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
            //联系电话
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
        else
        {
            //用车人
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1002;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = YES;
            
            _cellTextView.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_cellTextView];
        }
        
    }
    
    return self;
}

-(id)initEditComplainWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.indexPath = indexPath;
        
        _cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, titleLabelwidth, 30)];
        _cellTitleLabel.textColor = [UIColor lightGrayColor];
        _cellTitleLabel.font = HEL_14;
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitleLabel];
        
        if (indexPath.row == 0)
        {
            //投诉申请人
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2 , 30)];
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
            //申请时间
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            //状态
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
            //联系电话
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
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
        else
        {
            //用车人
            _cellTextView = [[UITextView alloc]initWithFrame:CGRectMake(_cellTitleLabel.frame.origin.x+_cellTitleLabel.frame.size.width+2, _cellTitleLabel.frame.origin.y, kMainScreenWidth - 25-CGRectGetMaxX(_cellTitleLabel.frame)-2, 30)];
            _cellTextView.textColor = [UIColor blackColor];
            _cellTextView.scrollEnabled = YES;
            _cellTextView.font = HEL_14;
            _cellTextView.returnKeyType = UIReturnKeyDone;
            _cellTextView.tag = 1004;
            _cellTextView.showsVerticalScrollIndicator = NO;
            _cellTextView.userInteractionEnabled = YES;
            
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


-(void)setMileInfoCellWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text
{
    self.indexPath = indexPath;
    _cellTextView.text = text;
    [self changeheightForTextView:_cellTextView];
}

-(void)setSaveComplainContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text
{
    self.indexPath = indexPath;
    _cellTextView.text = text;
    [self changeheightForTextView:_cellTextView];
}

-(void)setEditComplainContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text
{
    self.indexPath = indexPath;
    _cellTextView.text = text;
    [self changeheightForTextView:_cellTextView];
}

#pragma mark - UITextView 高度变化及cell高度

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






- (void)drawRect:(CGRect)rect
{
    if (self.indexPath.section == 0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        
        CGContextSetStrokeColorWithColor(context, CELL_LINE_COLOR.CGColor);
        CGContextStrokeRect(context, CGRectMake(97, rect.size.height, rect.size.width-97, 0.5));
    }
    else
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        
        CGContextSetStrokeColorWithColor(context, CELL_LINE_COLOR.CGColor);
        CGContextStrokeRect(context, CGRectMake(107, rect.size.height, rect.size.width-107, 0.5));
    }
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
