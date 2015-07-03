//
//  HXUserModel.h
//  CLYC
//
//  Created by weili.wu on 15/6/28.
//  Copyright (c) 2015年 weili.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXUserModel : NSObject


/**
 * 用户主键
 */

@property(nonatomic,strong)NSString *userId;

/**
 * 登录名
 */
@property(nonatomic,strong)NSString *loginId;

/**
 * 用户名
 */

@property(nonatomic,strong)NSString *userName;
/**
 * 性别
 */
@property(nonatomic,strong)NSString *sex;
/**
 * 邮箱
 */
@property(nonatomic,strong)NSString *email;
/**
 * 手机号
 */
@property(nonatomic,strong)NSString *telphone;
/**
 * 角色
 */
@property(nonatomic,strong)NSString *roleNo;

/**
 * 部门主键
 */

@property(nonatomic,strong)NSString *deptId;
/**
 * 部门名称
 */
@property(nonatomic,strong)NSString *deptName;

@property(nonatomic,strong)NSString *password;

@property(nonatomic,strong)NSString *sign;



+(HXUserModel *)shareInstance;



@end
