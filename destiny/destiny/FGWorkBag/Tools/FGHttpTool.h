//
//  FGHttpTool.h
//  boxpi
//
//  Created by Fengur on 16/5/23.
//  Copyright © 2016年 onlybox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FGHttpTool : NSObject

#define kHttpSuccessCode 0

typedef void (^httpSuccessBlock)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject);
typedef void (^httpFailureBlock)(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error);
typedef void (^httpProgressBlock)(NSProgress *_Nonnull uploadProgress);

/**
 *  更新基础url
 *
 *  @param baseUrl 基础url
 */
+ (void)updateBaseUrl:(NSString *_Nullable)baseUrl;

/**
 *  设置基础url
 *
 *  @return 基础url
 */
+ (NSString *_Nullable)baseUrl;

/**
 *  设置全局请求头
 *
 *  @param httpHeaders 请求头字典
 */
+ (void)updateCommonHttpHeaders:(NSDictionary *_Nullable)httpHeaders;

/**
 *  更新超时时间
 *
 *  @param timeout 超时时间
 */
+ (void)updateRequestTimeout:(NSTimeInterval)timeout;

/**
 *  网络超时时间
 *
 *  @return 超时时间
 */
+ (NSTimeInterval)requestTimeout;

/**
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)getWithURL:(NSString *_Nonnull)url
            params:(NSDictionary *_Nullable)params
           success:(httpSuccessBlock _Nullable)success
           failure:(httpFailureBlock _Nullable)failure;

/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)postWithURL:(NSString *_Nonnull)url
             params:(id _Nullable)params
            success:(httpSuccessBlock _Nullable)success
            failure:(httpFailureBlock _Nullable)failure;

/**
 *  get请求
 *
 *  @param url      请求地址
 *  @param params   请求参数
 *  @param progress 请求进度回调
 *  @param success  请求成功回调
 *  @param failure  请求失败回调
 */
+ (void)getWithURL:(NSString *_Nonnull)url
            params:(NSDictionary *_Nullable)params
          progress:(httpProgressBlock _Nullable)progress
           success:(httpSuccessBlock _Nullable)success
           failure:(httpFailureBlock _Nullable)failure;

/**
 *  post请求
 *
 *  @param url      请求地址
 *  @param params   请求参数
 *  @param progress 请求进度回调
 *  @param success  请求成功回调
 *  @param failure  请求失败回调
 */
+ (void)postWithURL:(NSString *_Nonnull)url
            params:(id _Nonnull)params
          progress:(httpProgressBlock _Nullable)progress
           success:(httpSuccessBlock _Nullable)success
           failure:(httpFailureBlock _Nullable)failure;

+ (void)uploadImageWithURL:(NSString * _Nonnull)url
                     image:(UIImage * _Nonnull)image
                    params:(NSDictionary *_Nullable)params
                  progress:(httpProgressBlock _Nullable)progress
                   success:(httpSuccessBlock _Nullable)success
                   failure:(httpFailureBlock _Nullable)failure;

@end
