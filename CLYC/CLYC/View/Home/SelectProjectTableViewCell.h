//
//  SelectProjectTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectProjectTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *projectNumTitleLabel;
@property(nonatomic,strong)UILabel *projectNumContentLabel;

@property(nonatomic,strong)UILabel *projectNameTitleLabel;
@property(nonatomic,strong)UILabel *projectNameContentLabel;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithProjectModel:(ProjectListModel *)model;
@end
