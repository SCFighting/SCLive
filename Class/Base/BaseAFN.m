//
//  AFNHttpInterface.m
//  wangju
//
//  Created by SC on 2018/9/14.
//  Copyright © 2018年 rayclear. All rights reserved.
//

#import "BaseAFN.h"

@interface BaseAFN()
{
    AFHTTPSessionManager *_manager;
}

@end

@implementation BaseAFN

-(void)initAFN
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setTimeoutIntervalForRequest:20];
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:DEFAULT_SERVER_ADD] sessionConfiguration:configuration];
    [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHENTICATION]] forHTTPHeaderField:@"Authorization"];
}

/**
 get 请求封装
 
 @param url 相对 URL
 @param parameters  参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
-(NSURLSessionDataTask *)getDataFromURL:(NSString *)url parameters:(id)parameters progress:(requestProgress)progress success:(requestSuccess)success failure:(requestFailure)failure
{
    [self initAFN];
    NSString *addUrl;
    if ([url containsString:@"?"]) {
        addUrl = [NSString stringWithFormat:@"%@&%@",url,[NSString stringWithFormat:@"u=%ld&apptype=apple",(long)[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]]];
    }else
    {
        addUrl = [NSString stringWithFormat:@"%@?%@",url,[NSString stringWithFormat:@"u=%ld&apptype=apple",(long)[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]]];
    }
    NSURLSessionDataTask *task = [_manager GET:addUrl parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GET网络请求URL->%@\n 请求结果responseObject=%@",[[NSURL URLWithString:addUrl relativeToURL:self->_manager.baseURL] absoluteString],responseObject);
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET网络请求URL->%@\n 请求结果错误 Error=%@",[[NSURL URLWithString:addUrl relativeToURL:self->_manager.baseURL] absoluteString],error.userInfo);
        if (failure) {
            failure(task,error);
        }
    }];
    return task;
}

/**
 post 请求封装
 
 @param url 相对 URL
 @param parameters  参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
-(NSURLSessionDataTask *)postDataToURL:(NSString *)url parameters:(id)parameters progress:(requestProgress)progress success:(requestSuccess)success failure:(requestFailure)failure
{
    [self initAFN];
    NSString *newURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *addUrl;
    if ([newURL containsString:@"?"]) {
        addUrl = [NSString stringWithFormat:@"%@&%@",url,[NSString stringWithFormat:@"u=%ld&apptype=apple",(long)[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]]];
    }else
    {
        addUrl = [NSString stringWithFormat:@"%@?%@",url,[NSString stringWithFormat:@"u=%ld&apptype=apple",(long)[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]]];
    }
   
    NSURLSessionDataTask *task = [_manager POST:addUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *key in parameters) {
            id value = parameters[key];
            if ([value isKindOfClass:[UIImage class]]) {
                NSData *data = [self scaleImage:value MaximumSize:1024];
                [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
            }
        }
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POST网络请求URL->%@\n 请求结果responseObject=%@",[[NSURL URLWithString:addUrl relativeToURL:self->_manager.baseURL] absoluteString], responseObject);
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POST网络请求URL->%@\n 请求结果Error=%@",[[NSURL URLWithString:addUrl relativeToURL:self->_manager.baseURL] absoluteString], error.userInfo);
        if (failure) {
            failure(task,error);
        }
    }];
    return task;
}


/**
 图片裁剪

 @param image image description
 @param size size description
 @return return value description
 */
- (NSData *)scaleImage:(UIImage *)image MaximumSize:(NSInteger)size {
    // size unit: KB
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat scale = 0.9;
    NSUInteger maxSize = size * 1024;
    while (data.length > maxSize && scale >= 0) {
        data = UIImageJPEGRepresentation(image, scale);
        scale -= 0.1;
    }
    return data;
}

-(NSURLSessionDataTask *)postDataToURL:(NSString *)url parameters:(id)parameters uploadProgress:(requestProgress)uploadProgress downloadProgress:(requestProgress)downloadProgress completionHandler:(uploadCompletionHandler)completionHandler
{
    [self initAFN];
    NSString *newURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *addUrl;
    if ([newURL containsString:@"?"]) {
        addUrl = [NSString stringWithFormat:@"%@&%@",url,[NSString stringWithFormat:@"u=%ld&apptype=apple",(long)[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]]];
    }else
    {
        addUrl = [NSString stringWithFormat:@"%@?%@",url,[NSString stringWithFormat:@"u=%ld&apptype=apple",(long)[[NSUserDefaults standardUserDefaults] integerForKey:USER_ID]]];
    }
    NSURL *URL = [[NSURL URLWithString:addUrl relativeToURL:_manager.baseURL] absoluteURL] ;
    NSString *urlStr = [URL absoluteString];
    NSError *error;
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:nil error:&error];
    if (error) {
        NSLog(@"%@",error.userInfo);
    }
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHENTICATION]] forHTTPHeaderField:@"Authorization"];
    // 关键! 转化为NSaData作为HTTPBody
    [req setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest:req uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"POST网络请求URL->%@\n 请求结果responseObject=%@\n 请求失败 Error=%@",[[NSURL URLWithString:addUrl relativeToURL:self->_manager.baseURL] absoluteString], responseObject,error.userInfo);
        if (completionHandler) {
            completionHandler(response,responseObject,error);
        }
    }];
    [task resume];
    return task;
}

@end
