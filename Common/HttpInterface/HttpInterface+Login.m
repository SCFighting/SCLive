//
//  HttpInterface+Login.m
//  SCLive
//
//  Created by SC on 2018/11/7.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "HttpInterface.h"

@implementation HttpInterface (Login)

/**
 邮箱登录
 @param parameters parameters description
 @param success success description
 @param failed failed description
 @return return value description
 */
+ (NSURLSessionDataTask *)LoginByParameters:(NSDictionary *)parameters success:(requestSuccess)success failed:(requestFailure)failed
{
     return [[HttpInterface new] postDataToURL:EMAIL_LOGIN parameters:parameters progress:nil success:success failure:failed];
}

@end
