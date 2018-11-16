//
//  HttpInterface.h
//  SCLive
//
//  Created by SC on 2018/11/7.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "BaseAFN.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpInterface : BaseAFN

@end

#pragma mark --login

@interface HttpInterface (Login)
/**
 邮箱登录
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)LoginByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;
@end

#pragma mark -- Home

@interface HttpInterface (Home)


/**
 获取用户信息

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getUserInfoByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;

/**
 获取用户课程列表
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getUserClassListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;
@end

@interface HttpInterface (RRJ)

/**
 创建或者编辑预告

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)createOrEditActivityWithID:(NSInteger)activityID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;


/**
 获取预告详情

 @param activityID activityID description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getActivityDetailInfoByID:(NSInteger)activityID success:(requestSuccess)success failed:(requestFailure)failed;


/**
 删除自己创建的预告

 @param ID ID description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)deleteActivityByID:(NSInteger)ID success:(requestSuccess)success failed:(requestFailure)failed;

/**
  设置课程邀请讲师讲课

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)setInvitedLectureScaleWithActivityID:(NSInteger)activity_id parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;


/**
  查询用户的专栏个数

 @param userID userID description
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getColumnCountByUserID:(NSInteger)userID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;


/**
 获取用户专栏列表

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+(NSURLSessionDataTask *)getUserColumnListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;


/**
 获取讲师列表

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getLectureListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;


/**
 获取j服务列表

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getServiceListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;

/**
 上传图片

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+(NSURLSessionDataTask *)uploadImageByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;


/**
 获取系统配置开关

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getSystermSwitchByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;

/**
 获取预告创建者信息

 @param creatorID creatorID description
 @param parameters parameters description
 @param success success description
 
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getActivityCreatorInfo:(NSInteger)creatorID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;

/**
 查询是否需要开启ping faye Service

 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getShouldPingFayeService:(requestSuccess)success failed:(requestFailure)failed;

/**
 获取预告视频信息
 @param activityID activityID description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getForcastVideoResolution:(NSInteger)activityID success:(requestSuccess)success failed:(requestFailure)failed;

/**
 更新预告视频信息

 @param activityID activityID description
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)updateVideoResolution:(NSInteger)activityID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;

/**
 获取腾讯 IM

 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getTXIMUserGign:(requestSuccess)success failed:(requestFailure)failed;


/**
 获取播放视频信息

 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getPlayVideoInfo:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;

@end

NS_ASSUME_NONNULL_END
