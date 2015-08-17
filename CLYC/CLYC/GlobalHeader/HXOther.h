//
//  HXOther.h
//  BJXH-patient
//
//  Created by wu weili on 14-5-5.
//  Copyright (c) 2014年 weihua. All rights reserved.
//

/**
 *
 * Common macros
 *
 **/



//#define HX_CUSTOM_TAB //打开此宏表示用的自定义的tabbar 否则用的是系统自带的

//设备屏幕frame
#define kMainScreenFrameRect                          [[UIScreen mainScreen] bounds]
//状态栏高度
#define kMainScreenStatusBarFrameRect                 [[UIApplication sharedApplication] statusBarFrame]
#define kMainScreenHeight                             [[UIScreen mainScreen] bounds].size.height//[[UIScreen mainScreen] applicationFrame].size.height
#define kMainScreenWidth [[UIScreen mainScreen] applicationFrame].size.width
//减去状态栏的高度:应用有效高度-状态栏的高度
#define kScreenHeightNoStatusBarHeight                (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height)
//减去状态栏和导航栏的高度
#define kScreenHeightNoStatusAndNoNaviBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-44.0f)

//减去状态栏和导航栏的高度和tabbar的高度
#define kScreenHeightNoStatusAndNoNaviBarNOTabBarHeight      (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height - 44.0f - 44.0f)

#define KScreenTabBarHeight  46

#define kScreenHeight                             [[UIScreen mainScreen] applicationFrame].size.height
//是否为 retina屏幕
#define IS_RETINA ([UIScreen instancesRespondToSelector:@selector(scale)] ? (2 == [[UIScreen mainScreen] scale]) : NO)

//当前设备是否为 iPhone5
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// HEX Color
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRef(red1,green1,blue1) [UIColor colorWithRed:red1/255.0f green:green1/255.0f blue:blue1/255.0f alpha:1.0f]


//user


#define USER_ID    ([HXUserModel shareInstance].userId)

#define IS_DefaultUser    ([HXUserModel shareInstance].isDefaultUser)



#define KEY_USERNAME  @"com.clyc.username"

#define KEY_PASSWORD  @"com.clyc.password"

#define HX_PATIENT_PLIST_NAME     @"patientSetting.plist"


#define CY_APPCAR_ID  @"appCarId"

//color

#define BACKGROUND_COLOR       UIColorFromRGB(0xEFEFEF)// 浅灰色

#define A_LITTER_GRAY_COLOR    UIColorFromRGB(0xDFDFDF)// 稍微深点的浅灰色

#define TITLE_COLOR            UIColorRef(65, 188, 154)

//cell line

#define CELL_LINE_COLOR UIColorFromRGB(0xC8C7CC)

#define MAIN_GREEN_TITLE_COLOR UIColorFromRGB(0x05b89b)

#define BUTTON_GRAY_TITLE_COLOR UIColorFromRGB(0x8E8E93)

#define TITLE_GRAY_COLOR_1 UIColorFromRGB(0x9E9E9E)




////////////////////////

#define REGEX_EMAIL         @"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*\" + \"+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"

#define REGEX_Height  @"^[1-9][0-9]*$"//@"^[0-9]{2,3}?$"  //@"^[0-9]{2,3}+(.[0-9]{1,2})?$"  // ^\d{2}(.\d){0,2}$|^\d{3}(.\d){0,2}$

#define REGEX_Weigth  @"^[1-9][0-9]*$"  //@"^[0-9]{2,3}+(.[0-9]{1,2})?$"

#define REGEX_OfficeCertificate  @"^[0-9]{8}?$"


// font

#define HEL_8               [UIFont fontWithName:@"Helvetica" size:8]
#define HEL_10              [UIFont fontWithName:@"Helvetica" size:10]
#define HEL_11              [UIFont fontWithName:@"Helvetica" size:11]
#define HEL_12              [UIFont fontWithName:@"Helvetica" size:12]
#define HEL_13              [UIFont fontWithName:@"Helvetica" size:13]
#define HEL_14              [UIFont fontWithName:@"Helvetica" size:14]
#define HEL_15              [UIFont fontWithName:@"Helvetica" size:15]
#define HEL_16              [UIFont fontWithName:@"Helvetica" size:16]
#define HEL_17              [UIFont fontWithName:@"Helvetica" size:17]
#define HEL_18              [UIFont fontWithName:@"Helvetica" size:18]
#define HEL_19              [UIFont fontWithName:@"Helvetica" size:19]
#define HEL_20              [UIFont fontWithName:@"Helvetica" size:20]
#define HEL_22              [UIFont fontWithName:@"Helvetica" size:22]
#define HEL_26              [UIFont fontWithName:@"Helvetica" size:26]
#define HEL_28              [UIFont fontWithName:@"Helvetica" size:28]
#define HEL_34              [UIFont fontWithName:@"Helvetica" size:34]




#define HEL_BOLD_10         [UIFont fontWithName:@"Helvetica-Bold" size:10]
#define HEL_BOLD_11         [UIFont fontWithName:@"Helvetica-Bold" size:11]
#define HEL_BOLD_12         [UIFont fontWithName:@"Helvetica-Bold" size:12]
#define HEL_BOLD_13         [UIFont fontWithName:@"Helvetica-Bold" size:13]
#define HEL_BOLD_14         [UIFont fontWithName:@"Helvetica-Bold" size:14]
#define HEL_BOLD_16         [UIFont fontWithName:@"Helvetica-Bold" size:16]
#define HEL_BOLD_17         [UIFont fontWithName:@"Helvetica-Bold" size:17]
#define HEL_BOLD_18         [UIFont fontWithName:@"Helvetica-Bold" size:18]
#define HEL_BOLD_19         [UIFont fontWithName:@"Helvetica-Bold" size:19]
#define HEL_BOLD_20         [UIFont fontWithName:@"Helvetica-Bold" size:20]
#define HEL_BOLD_24         [UIFont fontWithName:@"Helvetica-Bold" size:24]
#define HEL_BOLD_15         [UIFont fontWithName:@"Helvetica-Bold" size:15]


#define  kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")

#define  kDEFAULT_DATE_TIME_FORMAT_NEW (@"yyyyMMddHHmmssSSS")



#pragma mark -  string -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//日期相关
#define STR_MONDAY              NSLocalizedString(@"星期一", @"")
#define STR_TUESDAY             NSLocalizedString(@"星期二", @"")
#define STR_WEDNESDAY           NSLocalizedString(@"星期三", @"")
#define STR_THURSDAY            NSLocalizedString(@"星期四", @"")
#define STR_FRIDAY              NSLocalizedString(@"星期五", @"")
#define STR_SATURDAY            NSLocalizedString(@"星期六", @"")
#define STR_SUNDAY              NSLocalizedString(@"星期日", @"")
#define STR_YESTERDAY                                       NSLocalizedString(@"昨天", @"")
#define STR_TODAY                                           NSLocalizedString(@"今天", @"")
#define STR_TOMORROW                                        NSLocalizedString(@"明天", @"")
#define STR_MORNING                                         NSLocalizedString(@"上午", @"")
#define STR_AFTERNOON                                       NSLocalizedString(@"下午", @"")
#define STR_NIGHT                                           NSLocalizedString(@"晚上", @"")
#define STR_THENIGHT                                        NSLocalizedString(@"夜诊", @"")

//  January February March April May June July August September October November December
#define STR_JANUARY                                         NSLocalizedString(@"一月", @"")
#define STR_FEBRUARY                                        NSLocalizedString(@"二月", @"")
#define STR_MARCH                                           NSLocalizedString(@"三月", @"")
#define STR_APRIL                                           NSLocalizedString(@"四月", @"")
#define STR_MAY                                             NSLocalizedString(@"五月", @"")
#define STR_JUNE                                            NSLocalizedString(@"六月", @"")
#define STR_JULY                                            NSLocalizedString(@"七月", @"")
#define STR_AUGUST                                          NSLocalizedString(@"八月", @"")
#define STR_SEPTEMBER                                       NSLocalizedString(@"九月", @"")
#define STR_OCTOBER                                         NSLocalizedString(@"十月", @"")
#define STR_NOVEMBER                                        NSLocalizedString(@"十一月", @"")
#define STR_DECEMBER                                        NSLocalizedString(@"十二月", @"")



////////////////////////////////////////////////////////////////////////////////////////////
//----------------通知------------------------//
/////////////////////////////////////////////////////////////////////////////////////////////

/**
 *   点击push消息     
 *
 *   带一个参数：消息id
 */

#define  Notify_click_pushMsg            @"Notify_click_pushMsg"
#define  ClickPushMsgId                  @"ClickPushMsgId "


/**
 *   收到push消息
 *
 *   带一个参赛：消息model
 */
#define  Notify_Receive_push_msg          @"Notify_Receive_push_msg"

#define  Receive_pushDic                @"Receive_pushDic"

/**
 *   在前台收到push消息
 *
 *
 */
#define  Notify_Receive_push_msg_In_Foreground          @"Notify_Receive_push_msg_In_Foreground"

/*
 *
 *   session超时/被踢
 *
 *
 */

#define  Session_overTime_message         @"Session_overTime_message "

#define  Notify_Be_Kicked          @"Notify_Be_Kicked"

/*
 * 来新消息  主要用于计数
 *
 */
#define  Notify_UpdateNewMessageNum         @"Notify_RecieveNewMessage"


/*
 * 成为会员或者关注、单次购买 
 */
#define  Notify_BecomeMyDoctor              @"Notify_BecomeMyDoctor"


/*
 * 推送通知状态更新通知
 */
#define  Notify_UpdatePushMsgStatus          @"Notify_UpdatePushMsgStatus"
#define  UpdatePushMsgStatusId               @"UpdatePushMsgStatusId"
#define  UpdatePushMsgStatus                 @"UpdatePushMsgStatus"


/*
 * 当大夫完成咨询和添加病历后
 */
#define  Notify_UpdateHealthFile             @"Notify_UpdateHealthFile"


/*
 * 留言未读状态的更新
 */
#define  Notify_UpdateLeaveMsgStatus         @"Notify_UpdatePushMsgStatus"
#define  UpdateLeaveMsgId                    @"UpdateLeaveMsgId"



/**
 * 网络状态变化通知
 *
 */

#define  KNetworkStateChangedNotification         @"kNetworkStateChangedNotification"




/**
 *  重连成功通知
 *
 */

#define  Notify_reconnect_success         @"Notify_reconnect_success"    //重连成功

/**
 *  发送留言成功通知
 *
 */

#define  Notify_send_msg_success         @"send_msg_success"

#define  Notify_reply_msg_success         @"reply_msg_success"









//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/*
 *  修改面诊单理由长度
 */

#define CHANGE_FACE_DIAGNOSE_LENGTH_MAX              200

/*
 *  修改药物过敏长度
 */
#define HEALTHfILE_DRUGAliergy_LENGTH_MAX            200

/*
 *  修改当前诊断
 */
#define HEALTHfILE_CURRENT_DIAGNOSE_LENGTH_MAX       200


/*
 *  新增留言长度
 */
#define ADD_LEAVEMSG_LENGTH_MAX            200

/*
 * 姓名长度
 */
#define NAME_LENGTH_MAX            10

/*
 * 手机号码长度
 */
#define PHONENUM_LENGTH_MAX            20



/*
 *  拒绝理由
 */
#define REFUSE_REASON_LENGTH_MAX            200


/*
 *  既往史长度
 */
#define PastMdeicalHistory_LENGTH_MAX            200

/*
 *  个人史长度
 */
#define PersonalHistory_LENGTH_MAX            200

/*
 *  婚育史长度
 */
#define ObstetricalHistory_LENGTH_MAX            200

/*
 *  家族史长度
 */
#define FamilyHistroy_LENGTH_MAX            200

/*
 *  籍贯长度
 */
#define BirthPlace_LENGTH_MAX            200


/*
 *  所在地区长度 如 北京市 东城区
 */
#define Area_LENGTH_MAX            50


/*
 *  详细地址长度 如 XXX街道
 */
#define DetailAddress_LENGTH_MAX            50

/*
 *  邮件地址长度 如 XXX街道
 */
#define Email_LENGTH_MAX            45


/*
 *  身高长度
 */
#define HEIGTH_LENGTH_MAX            3


/*
 *  体重长度
 */
#define WEIGTH_LENGTH_MAX            3

/*
 *  证件号长度
 */

#define IDENTIFIER_CARD_LENGTH_MAX            50

/*
 *  投诉内容长度
 */

#define COMPLAIN_LENGHT_HX_MAX              200


/*
 *  医院名长度
 */
#define HOSPITAL_NAME_LENGTH_MAX            50

/*
 *  医院科室长度
 */
#define HOSPITAL_ROOM_NAME_LENGTH_MAX            50

/*
 *  病情描述长度
 */
#define RECORD_CASE_DES_LENGTH_MAX            200

/*
 *  评论文章长度
 */
#define COMMENT_ART_LENGTH_MAX            200

/*
 *  评论文章长度
 */
#define IM_TEXT_LENGTH_MAX                 20000


//////////////////////////////////////////////////////////////////////////////////////////
///////////////////////   接口    ////////////////////////////////////////////////////////

/*
 *
 *            接口 servicecode
 *
 */

#define ServiceCode  @"servicecode"
#define Plant        @"plant"
#define Plant_IOS    @"IOS"


//检查版本
#define IVersionService_checkVersion           @"IVersionService_checkVersion"

//提交用户注册信息
#define IUsercodeService_add                   @"IUsercodeService_add"

//登录
#define Patient_Login                          @"ea63000201902b67"

//检查账号唯一性
#define IUsercodeService_checkOne              @"IUsercodeService_checkOne"

//注册获取验证码
#define ILoginService_getRandomByRegister      @"ILoginService_getRandomByRegister"

//修改密码获取验证码
#define ILoginService_getRandom                @"ILoginService_getRandom"

//忘记密码获取验证码
#define ILoginService_getRandomForgetPasswd    @"ILoginService_getRandomForgetPasswd"

//比较验证码
#define IUsercodeService_compareRandom         @"IUsercodeService_compareRandom"

//提交用户基本信息
#define IPatientService_add                    @"IPatientService_add"

//上传病历
#define IHealthRecordService_newCase          @"IHealthRecordService_newCase"

//上传化验病历
#define IHealthRecordService_newRecordFile    @"IHealthRecordService_newRecordFile"

//上传影像病历
#define IHealthRecordService_newImaging         @"IHealthRecordService_newImaging"

//上传其他检查
#define IHealthRecordService_newOtherRecordFile  @"IHealthRecordService_newOtherRecordFile"

//添加临时病历图片
#define ITemporaryPictureService_add         @"ITemporaryPictureService_add"

//删除临时某张病历图片
#define ITemporaryPictureService_del         @"ITemporaryPictureService_del"

//删除临时所有病历图片
#define ITemporaryPictureService_delAll         @"ITemporaryPictureService_delAll"

//获取患者医生和留言列表
#define IDoctorPatientService_findDoctorsByPatient    @"IDoctorPatientService_findDoctorsByPatient"

//获取推送消息
#define IPatientMessageService_findUnReadPatientMessage  @"IPatientMessageService_findUnReadPatientMessage"

//回调推送消息
#define IPatientMessageService_callBackPatientMessage   @"IPatientMessageService_callBackPatientMessage"

//刷新留言列表
#define ILeaveMessageService_findLeaveMessageByDoctorAndPatient @"ILeaveMessageService_findLeaveMessageByDoctorAndPatient"

//按照疾病搜索医生
#define IDoctorExportService_findDistinct         @"IDoctorExportService_findDistinct"


//所有医生
#define IDoctorRelationService_findRelationList   @"IDoctorRelationService_findRelationList"

//退出登录
#define Patient_Logout                         @"ea63000301f42b67"

//紧急救助医生列表

#define IDoctorServiceExtraService_helpDoctorList        @"IDoctorServiceExtraService_helpDoctorList"

//导医分诊列表
#define IDoctorServiceExtraService_guideDoctorList       @"IDoctorServiceExtraService_guideDoctorList"

//发起紧急救助
#define IDoctorServiceExtraService_startHelper        @"IDoctorServiceExtraService_startHelper"

//发起导医分诊
#define IDoctorServiceExtraService_startGuide        @"IDoctorServiceExtraService_startGuide"


//////////////////////////////////////////////////////
//二维码URL固定前缀
#define HXQRCodeReaderUrlSuffix        @"api.yibaomd"


/////////////////////////////////////////////////////////////////////////////////////


