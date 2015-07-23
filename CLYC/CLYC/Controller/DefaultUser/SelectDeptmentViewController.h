//
//  SelectDeptmentViewController.h
//  CLYC
//
//  Created by weili.wu on 15/7/23.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import "HXBJHXBaseViewController.h"

typedef void(^SelectDeptBlock)(DeptListModel *model);

@interface SelectDeptmentViewController : HXBJHXBaseViewController

-(id)initWithDefaultSelectedDeptModel:(DeptListModel *)selectedDeptModel selectDeptBlock:(SelectDeptBlock )block;

@end
