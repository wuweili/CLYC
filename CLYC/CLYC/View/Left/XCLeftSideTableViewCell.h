//
//  XCLeftSideTableViewCell.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/15.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCLeftSideTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *cellTitleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setCellContentWithIndexPath:(NSIndexPath *)indexPath imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray;

@end
