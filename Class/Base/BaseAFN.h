//
//  AFNHttpInterface.h
//  wangju
//
//  Created by SC on 2018/9/14.
//  Copyright © 2018年 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requestProgress)(NSProgress * _Nonnull downloadProgress);
typedef void (^requestSuccess)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^requestFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
typedef void(^uploadCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);

@interface BaseAFN : NSObject
/**
 get 请求封装
 
 @param url 相对 URL
 @param parameters  参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
-(NSURLSessionDataTask *)getDataFromURL:(NSString *)url parameters:(id)parameters progress:(requestProgress)progress success:(requestSuccess)success failure:(requestFailure)failure;
/**
 post 请求封装
 
 @param url 相对 URL
 @param parameters  参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
-(NSURLSessionDataTask *)postDataToURL:(NSString *)url parameters:(id)parameters progress:(requestProgress)progress success:(requestSuccess)success failure:(requestFailure)failure;

/**
 Post 请求封装

 @param url url description
 @param parameters parameters description
 @param uploadProgress uploadProgress description
 @param downloadProgress downloadProgress description
 @param completionHandler completionHandler description
 @return return value description
 */
-(NSURLSessionDataTask *)postDataToURL:(NSString *)url parameters:(id)parameters uploadProgress:(requestProgress)uploadProgress downloadProgress:(requestProgress)downloadProgress completionHandler:(uploadCompletionHandler)completionHandler;

@end
