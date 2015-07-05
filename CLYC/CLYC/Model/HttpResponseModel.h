//
//  HttpResponseModel.h
//  CLYC
//
//  Created by wuweiqing on 15/7/5.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResponseModel : NSObject

@end


@interface SelectCarInfoModel : NSObject
/**
 * 车辆主键
 */
@property(nonatomic,strong)NSString *carId;

/**
 * 车牌号码
 */
@property(nonatomic,strong)NSString *carCode;

/**
 * 车辆型号 主键
 */
@property(nonatomic,strong)NSString *carModelId;

/**
 * 车辆型号
 */
@property(nonatomic,strong)NSString *carModel;

/**
 * 跟车司机 主键
 */
@property(nonatomic,strong)NSString *driverId;

/**
 * 跟车司机
 */
@property(nonatomic,strong)NSString *driver;

/**
 * 联系电话
 */
@property(nonatomic,strong)NSString *driverTel;

/**
 * 车辆类型  1 内部车辆  2 外部车辆
 */
@property(nonatomic,strong)NSString *carType;

/**
 * 单价
 */
@property(nonatomic,strong)NSString *price;



@end