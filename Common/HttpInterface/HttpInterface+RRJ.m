//
//  HttpInterface+RRJ.m
//  SCLive
//
//  Created by SC on 2018/11/13.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HttpInterface.h"

@implementation HttpInterface (RRJ)
/**
 创建或者编辑预告
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)createOrEditActivityWithID:(NSInteger)activityID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;
{
    if (activityID > 0)
    {
        return [[HttpInterface new] postDataToURL:[NSString stringWithFormat:@"%@/%ld",CREATE_OR_EDIT_ACTIVITY,activityID] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {} success:success failure:failed];
    }else
    {
        return [[HttpInterface new] postDataToURL:CREATE_OR_EDIT_ACTIVITY parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {} success:success failure:failed];
    }
}

/**
 获取预告详情
 
 @param activityID activityID description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getActivityDetailInfoByID:(NSInteger)activityID success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:[NSString stringWithFormat:@"%@/%ld",CREATE_OR_EDIT_ACTIVITY,activityID] parameters:nil progress:nil success:success failure:failed];
}

/**
 删除自己创建的预告
 
 @param ID ID description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)deleteActivityByID:(NSInteger)ID success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] postDataToURL:[NSString stringWithFormat:DELETE_MY_CREATE_ACTIVITY,ID] parameters:nil progress:nil success:success failure:failed];
}

/**
 设置课程邀请讲师讲课
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)setInvitedLectureScaleWithActivityID:(NSInteger)activity_id parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed;
{
    return [[HttpInterface new] postDataToURL:[NSString stringWithFormat:RRJ_SET_INVITE_LECTURE_SCALE, (long)activity_id] parameters:parameters progress:nil success:success failure:failed];
}

/**
 查询用户的专栏个数
 
 @param userID userID description
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getColumnCountByUserID:(NSInteger)userID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:[NSString stringWithFormat:RRJUSERCOLUMNCOUNT,(long)userID] parameters:nil progress:nil success:success failure:failed];
}

/**
 获取用户专栏列表
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+(NSURLSessionDataTask *)getUserColumnListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:RRJGETSPECIALCOLUMNDATA parameters:parameters progress:nil success:success failure:failed];
}

/**
 获取讲师列表
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getLectureListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:GETSIMPLELECTURELIST parameters:parameters progress:nil success:success failure:failed];
}

/**
 获取j服务列表
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getServiceListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
     return [[HttpInterface new] getDataFromURL:CHOSESERVERSE parameters:parameters progress:nil success:success failure:failed];
}

/**
 上传图片
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+(NSURLSessionDataTask *)uploadImageByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] postDataToURL:RRJUPLOADIMAGE parameters:parameters progress:nil success:success failure:failed];
}


/**
 获取系统配置开关
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getSystermSwitchByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:SYSTERM_SWITCH parameters:parameters progress:nil success:success failure:failed];
}

/**
 获取预告创建者信息
 
 @param creatorID creatorID description
 @param parameters parameters description
 @param success success description
 
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getActivityCreatorInfo:(NSInteger)creatorID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:[NSString stringWithFormat:GET_CREATOR_INFO,creatorID] parameters:nil progress:nil success:success failure:failed];
}

/**
 查询是否需要开启ping faye Service
 
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getShouldPingFayeService:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:RRJ_SHOULD_PING_FAYE_SERVICES parameters:nil progress:nil success:success failure:failed];
}

/**
 获取预告视频信息
 @param activityID activityID description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getForcastVideoResolution:(NSInteger)activityID success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:[NSString stringWithFormat:VIDEORESOLUTION,activityID] parameters:nil progress:nil success:success failure:failed];
}

/**
 更新预告视频信息
 
 @param activityID activityID description
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)updateVideoResolution:(NSInteger)activityID parameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] postDataToURL:[NSString stringWithFormat:UPDATE_VIDEORESOLUTION,activityID] parameters:parameters progress:nil success:success failure:failed];
}

/**
 获取腾讯 IM
 
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getTXIMUserGign:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:[NSString stringWithFormat:TXIM_GET_USER_SIGN,[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]] parameters:nil progress:nil success:success failure:failed];
}

/**
 获取播放视频信息
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getPlayVideoInfo:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:PLAY_VIDEO_INFO parameters:parameters progress:nil success:success failure:failed];
}

@end
