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


//部门列表

@interface DeptListModel : NSObject

/**
 * 部门主键
 */
@property(nonatomic,strong)NSString *deptId;

/**
 * 部门名称
 */
@property(nonatomic,strong)NSString *deptName;

@end

//项目列表

@interface ProjectListModel : NSObject

/**
 * 项目主键
 */
@property(nonatomic,strong)NSString *projectId;

/**
 * 项目号
 */
@property(nonatomic,strong)NSString *projectNo;

/**
 * 项目名称
 */
@property(nonatomic,strong)NSString *projectName;

@end






@interface ApplyCarDetailModel : NSObject

/**
 * 申请主键
 */
@property(nonatomic,strong)NSString *appId;


/**
 * 用车部门
 */
@property(nonatomic,strong)DeptListModel *deptModel;

/**
 * 项目
 */
@property(nonatomic,strong)ProjectListModel *projectModel;

/**
 * 车辆
 */
@property(nonatomic,strong)SelectCarInfoModel *selectedCarModel;

/**
 * 始发地
 */
@property(nonatomic,strong)NSString *beginAdrr;

/**
 * 目的地
 */
@property(nonatomic,strong)NSString *endAdrr;


/**
 * 开始时间
 */
@property(nonatomic,strong)NSString *beginTime;

/**
 * 结束时间
 */
@property(nonatomic,strong)NSString *endTime;


/**
 * 用车人名
 */
@property(nonatomic,strong)NSString *carAppUserName;


/**
 * 用车人id
 */
@property(nonatomic,strong)NSString *carAppUserId;

/**
 * 用车人电话
 */
@property(nonatomic,strong)NSString *carAppUserTel;

/**
 * 车辆用途
 */
@property(nonatomic,strong)NSString *carUse;


/**
 * 状态 0 暂存 1 正常  2 取消
 */
@property(nonatomic,strong)NSString *status;


/**
 * 申请时间
 */
@property(nonatomic,strong)NSString *appTime;


/**
 * 申请人主键
 */
@property(nonatomic,strong)NSString *appUserId;

/**
 * 申请人名称
 */
@property(nonatomic,strong)NSString *appUserName;


/**
 * 申请部门
 * deptId  = appDeptId  申请人部门主键
 * deptName = appDeptName 申请人部门名称
 */
@property(nonatomic,strong)DeptListModel *applyDeptModel;

///**
// * 申请人部门主键
// */
//@property(nonatomic,strong)NSString *appDeptId;
//
//
///**
// * 申请人部门名称
// */
//@property(nonatomic,strong)NSString *appDeptName;

/**
 * 跟车司机
 */
@property(nonatomic,strong)NSString *driver;

/**
 * 联系电话
 */
@property(nonatomic,strong)NSString *driverTel;

/**
 * 里程
 */
@property(nonatomic,strong)NSString *totalMil ;


/**
 * 开始里程
 */
@property(nonatomic,strong)NSString *beginMil ;

/**
 * 开始里程确 认状态
 */
@property(nonatomic,strong)NSString *beginMilStatus ;

/**
 * 开始里程备注
 */
@property(nonatomic,strong)NSString *beginMilRemark ;

/**
 * 结束里程
 */
@property(nonatomic,strong)NSString *finishMil ;

/**
 * ￼附加里程
 */
@property(nonatomic,strong)NSString *addMil ;

/**
 * ￼结束里程确认状态
 */
@property(nonatomic,strong)NSString *finishMilStatus ;

/**
 * ￼结束里程备注
 */
@property(nonatomic,strong)NSString *finishMilRemark ;

/**
 * ￼单价
 */
@property(nonatomic,strong)NSString *price ;

/**
 * ￼出差天数
 */
@property(nonatomic,strong)NSString *driverTraveldays;

/**
 * ￼系统时间
 */
@property(nonatomic,strong)NSString *systemTime;



@end

@interface TrajectoryListModel : NSObject

/**
 * ￼时间
 */
@property(nonatomic,strong)NSString *receiveTime ;

/**
 * ￼维度
 */
@property(nonatomic,strong)NSString *latitude ;

/**
 * ￼经度
 */
@property(nonatomic,strong)NSString *longitude ;

/**
 * ￼方向
 */
@property(nonatomic,strong)NSString *direction ;


@end


@interface ComplainListModel : NSObject

/**
 * 申请主键
 */
@property(nonatomic,strong)NSString *_id;

/**
 * 投诉申请人名称
 */
@property(nonatomic,strong)NSString *createPersonName;


/**
 * 投诉申请人id
 */
@property(nonatomic,strong)NSString *createPersonId;


/**
 * 联系电话
 */
@property(nonatomic,strong)NSString *createPersonTel;

/**
 * 状态
 */
@property(nonatomic,strong)NSString *status;

/**
 * 状态名称
 */
@property(nonatomic,strong)NSString *statusName;

/**
 * 申请时间
 */
@property(nonatomic,strong)NSString *createTime;

/**
 * 投诉内容
 */
@property(nonatomic,strong)NSString *complaintContent;

/**
 * 处理结果
 */
@property(nonatomic,strong)NSString *handelResults;

/**
 * 处理人
 */
@property(nonatomic,strong)NSString *handelPersonId;

/**
 * 处理人姓名
 */
@property(nonatomic,strong)NSString *handelPersonName;

/**
 * 处理时间
 */
@property(nonatomic,strong)NSString *handelTime;


@end


@interface DriverCheckModel : NSObject

/**
 * 申请主键
 */
@property(nonatomic,strong)NSString *_id;


/**
 * 司机主键
 */
@property(nonatomic,strong)NSString *driverId;

/**
 * 司机名称
 */
@property(nonatomic,strong)NSString *driverName;

/**
 * 考核时间
 */
@property(nonatomic,strong)NSString *checkTime;

/**
 * 等级
 */
@property(nonatomic,strong)NSString *gradeName;



@end
