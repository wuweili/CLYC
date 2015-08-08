//
//  ComplainListTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/8/8.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplainListTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *complainApplyUserTitleLabel;

@property(nonatomic,strong)UILabel *complainApplyUserLabel;


@property(nonatomic,strong)UILabel *applyTelTitleLabel;

@property(nonatomic,strong)UILabel *applyTelLabel;

@property(nonatomic,strong)UILabel *timeTitleLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *statusTitleLabel;
@property(nonatomic,strong)UILabel *statusLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithComplainListModel:(ComplainListModel *)model;

@end
