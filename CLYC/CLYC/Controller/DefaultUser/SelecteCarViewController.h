//
//  SelecteCarViewController.h
//  CLYC
//
//  Created by weili.wu on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXBJHXBaseViewController.h"


typedef void(^SelectCarBlock)(SelectCarInfoModel *model);

@interface SelecteCarViewController : HXBJHXBaseViewController


-(id)initWithDefaultSelectedCarModel:(SelectCarInfoModel *)selectedCarModel beginTime:(NSString *)beginTime endTime:(NSString *)endTime selectCarBlock:(SelectCarBlock )block;

@end
