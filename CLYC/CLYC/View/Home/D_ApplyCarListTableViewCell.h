//
//  D_ApplyCarListTableViewCell.h
//  CLYC
//
//  Created by wuweiqing on 15/7/26.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface D_ApplyCarListTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *carUserNameTitleLabel;
@property(nonatomic,strong)UILabel *carUserNameLabel;

@property(nonatomic,strong)UILabel *carUserTelTitleLabel;
@property(nonatomic,strong)UILabel *carUserTelLabel;

@property(nonatomic,strong)UILabel *timeTitleLabel;
@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *addressTitleLabel;
@property(nonatomic,strong)UILabel *addressLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCellContentWithApplyCarListModel:(ApplyCarDetailModel *)model;
+(CGFloat)CellHeightWithApplyCarListModel:(ApplyCarDetailModel *)model;
@end
