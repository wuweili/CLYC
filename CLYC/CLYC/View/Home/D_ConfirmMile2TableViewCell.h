//
//  D_ConfirmMile2TableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface D_ConfirmMile2TableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *cellTitleLabel;
@property(nonatomic,strong)UITextView *cellTextView;
@property(nonatomic,strong)NSIndexPath *indexPath;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

-(id)initMileInfoWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

-(void)setContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text;

-(void)setMileInfoCellWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text;

@end
