//
//  SaveApplyCarTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/21.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveApplyCarTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *cellTitleLabel;
@property(nonatomic,strong)UILabel *cellContentLabel;
@property(nonatomic,strong)UITextView *cellTextView;
@property(nonatomic,strong)NSIndexPath *indexPath;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

-(id)initMileInfoWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

-(id)initSaveComplainWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;


-(void)setContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text;

-(void)setMileInfoCellWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text;

-(void)setSaveComplainContentWithIndexPath:(NSIndexPath *)indexPath andContentStr:(NSString *)text;

@end
