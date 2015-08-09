//
//  SelectProjectViewController.h
//  CLYC
//
//  Created by wuweiqing on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXBJHXBaseViewController.h"

typedef void(^SelectProjectBlock)(ProjectListModel *model);


@interface SelectProjectViewController : HXBJHXBaseViewController

-(id)initWithDefaultSelectedProjectModel:(ProjectListModel *)model depId:(NSString *)depId selectProjectBlock:(SelectProjectBlock )block;

@end
