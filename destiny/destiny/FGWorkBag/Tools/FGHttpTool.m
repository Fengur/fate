//
//  FGHttpTool.m
//  boxpi
//
//  Created by Fengur on 16/5/23.
//  Copyright © 2016年 onlybox. All rights reserved.
//

#import "FGHttpTool.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworking.h>

#ifdef DEBUG
#define FGHttpLog(s, ...)                                                         \
    NSLog(@"[%@：in line: %d]-->[message: %@]",                                   \
          [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, \
          [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define FGHttpLog(s, ...)
#endif

//  网络静态参数设置
static NSTimeInterval fg_requestTimeout = 30;
//  基础地址
static NSString *fg_baseURLString = @"this is your base url of backend";
//  是否开启调试
static BOOL fg_isEnableInterfaceDebug = YES;
//  请求头
static NSDictionary *fg_httpHeaders = nil;

static NSString *netErrorImageName = @"";

@implementation FGHttpTool

+ (void)updateRequestTimeout:(NSTimeInterval)timeout {
    fg_requestTimeout = timeout;
}

+ (NSTimeInterval)requestTimeout {
    return fg_requestTimeout;
}

+ (void)updateBaseUrl:(NSString *)baseUrl {
    fg_baseURLString = baseUrl;
}

+ (NSString *)baseUrl {
    return fg_baseURLString;
}

+ (void)updateCommonHttpHeaders:(NSDictionary *)httpHeaders {
    fg_httpHeaders = httpHeaders;
}

+ (void)enableInterfaceDebug:(BOOL)isDebug {
    fg_isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug {
    return fg_isEnableInterfaceDebug;
}

+ (AFHTTPSessionManager *)managerInit {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //  初始化BaseUrl
    AFHTTPSessionManager *manager =
        [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:fg_baseURLString]];

    //  JSON序列化
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = [self requestTimeout];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
        @"application/json",
        @"text/html",
        @"text/json",
        @"text/javascript",
        @"text/plain"
    ]];
    //  请求头设置
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:BaiduKey forHTTPHeaderField:BaiduKeyName];
    for (NSString *key in fg_httpHeaders.allKeys) {
        if (fg_httpHeaders[key]) {
            [manager.requestSerializer setValue:fg_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 5;

    return manager;
}

+ (void)getWithURL:(NSString *)url
            params:(NSDictionary *)params
           success:(httpSuccessBlock)success
           failure:(httpFailureBlock)failure {
    [self getWithURL:url params:params progress:nil success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url
             params:(id)params
            success:(httpSuccessBlock)success
            failure:(httpFailureBlock)failure {
    [self postWithURL:url params:params progress:nil success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url
             params:(id)params
           progress:(httpProgressBlock)progress
            success:(httpSuccessBlock)success
            failure:(httpFailureBlock)failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self managerInit];

    [manager POST:url
        parameters:params
        progress:^(NSProgress *_Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (success) {
                success(task, responseObject);
            }
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:task.response.URL.absoluteString
                                      params:params];
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (failure) {
                failure(task, error);
            }
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if (data) {
                NSError *dataError;
                NSDictionary *errorDict =
                    [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&dataError];


            } else {
                if ([error localizedDescription]) {
                
                }
            }
        }];
}

+ (void)getWithURL:(NSString *)url
            params:(NSDictionary *)params
          progress:(httpProgressBlock)progress
           success:(httpSuccessBlock)success
           failure:(httpFailureBlock)failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self managerInit];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url
        parameters:params
        progress:^(NSProgress *_Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:task.response.URL.absoluteString
                                      params:params];
            }
            if (success) {
                success(task, responseObject);
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (failure) {
                failure(task, error);
            }
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if (data) {
                NSError *dataError;
                NSDictionary *errorDict =
                    [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&dataError];

                if ([errorDict objectForKey:@"message"]) {

                } else {
                
                }
            } else {
                if ([error localizedDescription]) {
    
                }
            }
        }];
}

+ (void)uploadImageWithURL:(NSString *)url
                     image:(UIImage *)image
                    params:(NSDictionary *)params
                  progress:(httpProgressBlock)progress
                   success:(httpSuccessBlock)success
                   failure:(httpFailureBlock)failure {
    AFHTTPSessionManager *manager = [self managerInit];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager POST:url
        parameters:params
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:@"image.jpg"
                                    mimeType:@"image/jpeg"];

        }
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (success) {
                success(task, responseObject);
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (failure) {
                failure(task, error);
            }
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if (data) {
                NSError *dataError;
                NSDictionary *errorDict =
                    [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&dataError];

            } else {
                if ([error localizedDescription]) {

                }
            }
        }];
}


+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    FGHttpLog(@"\nabsoluteUrl: %@\n params:%@\n response:%@\n\n", url, params, response);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(NSDictionary *)params {
    FGHttpLog(@"\nabsoluteUrl: %@\n params:%@\n errorInfos:%@\n\n", url, params,
              [error localizedDescription]);
}

@end
