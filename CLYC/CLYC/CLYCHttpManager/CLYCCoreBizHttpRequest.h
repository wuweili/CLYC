//
//  CLYCCoreBizHttpRequest.h
//  CLYC
//
//  Created by wuweiqing on 15/6/30.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponseModel.h"


@interface BaseHttpRequest : NSObject

/**
 * 加密请求 post 不带附件
 */
+(void)basePostRequestWithPath:(NSString *)path keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray methodName:(NSString *)methodName withBlock:(void (^)( NSString *retCode, NSString *retMessage, id responseObject, NSError *error))block;

/**
 * 得到最终发送给服务器的字典
 */
+(NSString *)getUserCenterRequestSendDataWithParamSender:(id )paramSender;



@end




@interface CLYCCoreBizHttpRequest : NSObject

/**
 * 登录
 */
+(void)loginYBUserWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 所有车辆信息查询接口
 */
+(void)selectCarInfoListWithBlock:(void (^)(NSMutableArray *ListArry,NSString *retcode,NSString *retmessage,NSError *error,NSString *totalNum))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;


/**
 * 获取约车历史
 */
+(void)obtainApplyCarHistorWithBlock:(void (^)(NSMutableArray *ListArry,NSString *retcode,NSString *retmessage,NSError *error,NSString *totalNum))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 获取部门列表
 */
+(void)obtainDeptListWithBlock:(void (^)(NSMutableArray *listArry,NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 获取项目列表
 */
+(void)obtainProjectListWithBlock:(void (^)(NSMutableArray *listArry,NSString *retcode,NSString *retmessage,NSError *error,NSString *totalNum))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 保存 - 约车申请
 */

+(void)saveApplyCarWithBlock:(void (^)(NSString  *appId,NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 保存 - 约车申请 详情
 */
+(void)obtainApplyCarDetailWithBlock:(void (^)(ApplyCarDetailModel *model,NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 修改 -约车申请
 */
+(void)editApplyCarWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 提交 -约车申请
 */
+(void)commitApplyCarWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 删除 -约车申请
 */
+(void)deleteApplyCarWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 里程单确认查询（申请人）
 */
+(void)obtainMileOrderConfirmListWithBlock:(void (^)(NSMutableArray *listArry,NSString *retcode,NSString *retmessage,NSError *error,NSString *totalNum))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;


/**
 * 用户起始里程确认
 */
+(void)userConfirmBeginMileWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 用户结束里程确认
 */
+(void)userConfirmFinishMileWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 派车单查询
 */
+(void)driverObtainCarApplyListWithBlock:(void (^)(NSMutableArray *listArry,NSString *retcode,NSString *retmessage,NSError *error,NSString *totalNum))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 起始里程登记
 */
+(void)driverCommitBeginMileWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 结束里程登记
 */
+(void)driverCommitFinishMileWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;


/**
 * GPS上传
 */
+(void)driverUploadGPSWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;


/**
 * 行车轨迹
 */
+(void)carTrajectoryWithBlock:(void (^)(NSMutableArray *listArry,NSString *retcode,NSString *retmessage,NSError *error))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

/**
 * 投诉查询
 */
+(void)complainListWithBlock:(void (^)(NSMutableArray *listArry,NSString *retcode,NSString *retmessage,NSError *error,NSString *totalNum))block keyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray ;

@end
