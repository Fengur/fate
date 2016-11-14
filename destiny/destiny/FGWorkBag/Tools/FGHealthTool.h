//
//  FGHealthTool.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
@interface FGHealthTool : NSObject



typedef void (^hk_successBlock)(NSArray *resultsArray);
typedef void (^hk_parTimetSuccessBlock)(double partTimeValue);
typedef void (^hk_failureBlock)(NSError *error);

/**
 *  返回某一天的步数
 */
+ (void)getStepForDays:(NSDate *)date
               success:(hk_successBlock)success
               failure:(hk_failureBlock)failure;

/**
 *  返回最近一天的步数
 */
+ (void)getStepForLastDaysSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure;

/**
 *  返回最近一周的步数
 */
+ (void)getStepForLastWeekSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure;

/**
 *  返回所有的步数
 */
+ (void)getStepAllDaysSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure;

/**
 *  返回某一天的跑步/步行距离
 */
+ (void)getWalkingRunningForDays:(NSDate *)date
                         success:(hk_successBlock)success
                         failure:(hk_failureBlock)failure;

/**
 *  返回最近一天的跑步/步行距离
 */
+ (void)getWalkingRunningForLastDaysSuccess:(hk_successBlock)success
                                    failure:(hk_failureBlock)failure;

/**
 *  返回最近一周的跑步/步行距离
 */
+ (void)getWalkingRunningForLastWeekSuccess:(hk_successBlock)success
                                    failure:(hk_failureBlock)failure;

/**
 *  返回所有的跑步/步行距离
 */
+ (void)getWalkingRunningAllDaysSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure;

/**
 *  获取某个时间段内的步数
 */
+ (void)getStepFromStartDate:(NSDate *)startDate
                   toEndDate:(NSDate *)endDate
                     success:(hk_parTimetSuccessBlock)success
                     failure:(hk_failureBlock)failure;

/**
 *  获取某个时间段内的距离
 */

+ (void)getWalkRunNumberFromStartDate:(NSDate *)startDate
                            toEndDate:(NSDate *)endDate
                              success:(hk_parTimetSuccessBlock)success
                              failure:(hk_failureBlock)failure;


@end
