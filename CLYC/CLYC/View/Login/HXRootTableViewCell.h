//
//  HXRootTableViewCell.h
//  BJXH-patient
//
//  Created by wuweili on 14-11-22.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXRootTableViewCell : UITableViewCell

@property(nonatomic,strong)UITextField *contentTextField;

@property(nonatomic,strong)UIImageView *headImageView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;



@end
