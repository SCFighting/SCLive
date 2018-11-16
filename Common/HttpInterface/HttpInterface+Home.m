//
//  HttpInterface+Home.m
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HttpInterface.h"

@implementation HttpInterface (Home)

/**
 获取用户信息
 
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getUserInfoByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:USER_INFO parameters:parameters progress:nil success:success failure:failed];
}

/**
 获取用户课程列表
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)getUserClassListByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
    return [[HttpInterface new] getDataFromURL:USER_CLASS_LIST parameters:parameters progress:nil success:success failure:failed];
}
@end
