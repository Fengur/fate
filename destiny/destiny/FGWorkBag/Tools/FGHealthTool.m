//
//  FGHealthTool.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "FGHealthTool.h"

#define HealthSourceBundle @"com.apple.Health"
#define HealthSourceDeviceName @"健康"

@implementation FGHealthTool
+ (void)getStepForDays:(NSDate *)date
               success:(hk_successBlock)success
               failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];    //步数
    HKUnit *unit = [HKUnit countUnit];
    
    [self getQuantityType:quantityType
                   ofDate:date
            daysLastCount:1
               outputUnit:unit
                  success:^(NSArray *resultsArray) {
                      if (success) {
                          success(resultsArray);
                      }
                  }
                  failure:^(NSError *error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
}

+ (void)getStepForLastDaysSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];    //步数
    
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;
    //设置一个计算的时间点
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |
     NSCalendarUnitWeekday
                fromDate:[NSDate date]];
    
    NSInteger offset = (7 + anchorComponents.weekday - 2) % 7;
    anchorComponents.day -= offset;
    //设置从几点开始计时
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    //创建查询   intervalcomponents:按照多少时间间隔查询
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc]
                                          initWithQuantityType:quantityType
                                          quantitySamplePredicate:nil
                                          options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource
                                          anchorDate:anchorDate
                                          intervalComponents:interval];
    __block NSUInteger blockDay = 1;
    
    //查询结果
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query,
                                    HKStatisticsCollection *results, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error.description);
            if (failure) {
                failure(error);
            }
        }
        
        // NSLog(@"sportResults %@", results);
        NSDate *endDate = [NSDate date];
        /*
         blockDay：表示从今天开始逐步查询后面(blockDay)天的步数(0表示查询全部，1表示查询1天)
         NSCalendarUnitDay  表示按照什么类型输出
         */
        
        NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay
                                                 value:-(blockDay - 1)
                                                toDate:endDate
                                               options:0];
        
        NSMutableArray *resulteArray = [NSMutableArray array];
        NSMutableArray *dateArray = [NSMutableArray array];
        //        NSMutableArray *valueArray = [NSMutableArray array];
        
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *_Nonnull result, BOOL *_Nonnull stop) {
                                       //                                       NSDate *date =
                                       //                                       result.startDate;
                                       //                                       HKQuantity *quantity
                                       //                                       =
                                       //                                       result.sumQuantity;
                                       
                                       //                                       HKQuantity
                                       //                                       *quantity;
                                       //
                                       //                                       for (HKSource
                                       //                                       *source in
                                       //                                       result.sources) {
                                       //                                           if ([source.name
                                       //                                           isEqualToString:[UIDevice
                                       //                                           currentDevice].name])
                                       //                                           {
                                       //                                               quantity =
                                       //                                               [result
                                       //                                               sumQuantityForSource:source];
                                       //                                           }
                                       //                                       }
                                       
                                       NSDateFormatter *outputFormatter =
                                       [[NSDateFormatter alloc] init];
                                       //   设置时区
                                       [outputFormatter setLocale:[NSLocale currentLocale]];
                                       [outputFormatter setDateFormat:@"yyyy-MM-dd"];
                                       //   NSString *dateStr = [outputFormatter
                                       //   stringFromDate:date];
                                       
                                       //                                       double value =
                                       //                                       [quantity
                                       //                                       doubleValueForUnit:unit];
                                       
                                       [resulteArray addObject:result];
                                       [dateArray addObject:result.startDate];
                                       //                                       [valueArray
                                       //                                       addObject:@(value)];
                                   }];
        
        if (success) {
            success(resulteArray);
        }
        
    };
    [healthStore executeQuery:query];
}

+ (void)getStepForLastWeekSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];    //步数
    HKUnit *unit = [HKUnit countUnit];
    
    [self getQuantityType:quantityType
                   ofDate:nil
            daysLastCount:7
               outputUnit:unit
                  success:^(NSArray *resultsArray) {
                      if (success) {
                          success(resultsArray);
                      }
                  }
                  failure:^(NSError *error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
}

+ (void)getStepAllDaysSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];    //步数
    HKUnit *unit = [HKUnit countUnit];
    
    [self getQuantityType:quantityType
                   ofDate:nil
            daysLastCount:0
               outputUnit:unit
                  success:^(NSArray *resultsArray) {
                      if (success) {
                          success(resultsArray);
                      }
                  }
                  failure:^(NSError *error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
}

+ (void)getWalkingRunningForDays:(NSDate *)date
                         success:(hk_successBlock)success
                         failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType = [HKObjectType
                                    quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];    //距离
    HKUnit *unit = [HKUnit meterUnit];
    
    [self getQuantityType:quantityType
                   ofDate:date
            daysLastCount:1
               outputUnit:unit
                  success:^(NSArray *resultsArray) {
                      if (success) {
                          success(resultsArray);
                      }
                  }
                  failure:^(NSError *error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
}

+ (void)getWalkingRunningForLastDaysSuccess:(hk_successBlock)success
                                    failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType = [HKObjectType
                                    quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];    //距离
    
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;
    //设置一个计算的时间点
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |
     NSCalendarUnitWeekday
                fromDate:[NSDate date]];
    
    NSInteger offset = (7 + anchorComponents.weekday - 2) % 7;
    anchorComponents.day -= offset;
    //设置从几点开始计时
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    //创建查询   intervalcomponents:按照多少时间间隔查询
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc]
                                          initWithQuantityType:quantityType
                                          quantitySamplePredicate:nil
                                          options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource
                                          anchorDate:anchorDate
                                          intervalComponents:interval];
    __block NSUInteger blockDay = 1;
    //查询结果
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query,
                                    HKStatisticsCollection *results, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error.description);
            if (failure) {
                failure(error);
            }
        }
        
        // NSLog(@"sportResults %@", results);
        NSDate *endDate = [NSDate date];
        /*
         blockDay：表示从今天开始逐步查询后面(blockDay)天的步数(0表示查询全部，1表示查询1天)
         NSCalendarUnitDay  表示按照什么类型输出
         */
        
        NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay
                                                 value:-(blockDay - 1)
                                                toDate:endDate
                                               options:0];
        
        NSMutableArray *resulteArray = [NSMutableArray array];
        NSMutableArray *dateArray = [NSMutableArray array];
        //        NSMutableArray *valueArray = [NSMutableArray array];
        
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *_Nonnull result, BOOL *_Nonnull stop) {
                                       
                                       //                                       HKQuantity *quantity
                                       //                                       =
                                       //                                       result.sumQuantity;
                                       //                                       NSDate *date =
                                       //                                       result.startDate;
                                       //                                       HKQuantity
                                       //                                       *quantity;
                                       //
                                       //                                       for (HKSource
                                       //                                       *source in
                                       //                                       result.sources) {
                                       //                                           if ([source.name
                                       //                                           isEqualToString:[UIDevice
                                       //                                           currentDevice].name])
                                       //                                           {
                                       //                                               quantity =
                                       //                                               [result
                                       //                                               sumQuantityForSource:source];
                                       //                                           }
                                       //                                       }
                                       
                                       NSDateFormatter *outputFormatter =
                                       [[NSDateFormatter alloc] init];
                                       //设置时区
                                       [outputFormatter setLocale:[NSLocale currentLocale]];
                                       [outputFormatter setDateFormat:@"yyyy-MM-dd"];
                                       //                                       NSString *dateStr =
                                       //                                       [outputFormatter
                                       //                                       stringFromDate:date];
                                       
                                       //                                       double value =
                                       //                                       [quantity
                                       //                                       doubleValueForUnit:unit];
                                       
                                       [resulteArray addObject:result];
                                       [dateArray addObject:result.startDate];
                                       //                                       [valueArray
                                       //                                       addObject:@(value)];
                                   }];
        
        if (success) {
            success(resulteArray);
        }
        
    };
    [healthStore executeQuery:query];
}

+ (void)getWalkingRunningForLastWeekSuccess:(hk_successBlock)success
                                    failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType = [HKObjectType
                                    quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];    //跑步距离
    HKUnit *unit = [HKUnit meterUnit];
    [self getQuantity1Type:quantityType
                    ofDate:nil
             daysLastCount:7
                outputUnit:unit
                   success:^(NSArray *resultsArray) {
                       if (success) {
                           success(resultsArray);
                       }
                   }
                   failure:^(NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
}

+ (void)getWalkingRunningAllDaysSuccess:(hk_successBlock)success failure:(hk_failureBlock)failure {
    HKQuantityType *quantityType = [HKObjectType
                                    quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];    //跑步距离
    HKUnit *unit = [HKUnit meterUnit];
    
#warning 解决多线程的bug -- 方法名改成: getQuantity1Type
    [self getQuantity1Type:quantityType
                    ofDate:nil
             daysLastCount:0
                outputUnit:unit
                   success:^(NSArray *resultsArray) {
                       if (success) {
                           success(resultsArray);
                       }
                   }
                   failure:^(NSError *error) {
                       if (failure) {
                           failure(error);
                       }
                   }];
}

+ (void)getQuantityType:(HKQuantityType *)type
                 ofDate:(NSDate *)date
          daysLastCount:(NSUInteger)days
             outputUnit:(HKUnit *)unit
                success:(hk_successBlock)success
                failure:(hk_failureBlock)failure {
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;
    //设置一个计算的时间点
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |
     NSCalendarUnitWeekday
                fromDate:[NSDate date]];
    
    NSInteger offset = (7 + anchorComponents.weekday - 2) % 7;
    anchorComponents.day -= offset;
    //设置从几点开始计时
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    //创建查询   intervalcomponents:按照多少时间间隔查询
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc]
                                          initWithQuantityType:type
                                          quantitySamplePredicate:nil
                                          options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource
                                          anchorDate:anchorDate
                                          intervalComponents:interval];
    __block NSUInteger blockDay = days;
    //查询结果
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query,
                                    HKStatisticsCollection *results, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error.description);
            if (failure) {
                failure(error);
            }
        }
        
        // NSLog(@"sportResults %@", results);
        NSDate *endDate = date ? date : [NSDate date];
        /*
         blockDay：表示从今天开始逐步查询后面(blockDay)天的步数(0表示查询全部，1表示查询1天)
         NSCalendarUnitDay  表示按照什么类型输出
         */
        if (days == 0) {
            blockDay = results.statistics.count + 1;
        }
        NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay
                                                 value:-(blockDay - 1)
                                                toDate:endDate
                                               options:0];
        
        NSMutableArray *resulteArray = [NSMutableArray array];
        NSMutableArray *dateArray = [NSMutableArray array];
        //        NSMutableArray *valueArray = [NSMutableArray array];
        
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *_Nonnull result, BOOL *_Nonnull stop) {
                                       
                                       //                                       HKQuantity
                                       //                                       *quantity;
                                       //
                                       //                                       for (HKSource
                                       //                                       *source in
                                       //                                       result.sources) {
                                       //                                           if ([source.name
                                       //                                           isEqualToString:[UIDevice
                                       //                                           currentDevice].name])
                                       //                                           {
                                       //                                               quantity =
                                       //                                               [result
                                       //                                               sumQuantityForSource:source];
                                       //                                           }
                                       //                                       }
                                       
                                       //                                       HKQuantity *quantity
                                       //                                       =
                                       //                                       result.sumQuantity;
                                       //                                       NSDate *date =
                                       //                                       result.startDate;
                                       
                                       NSDateFormatter *outputFormatter =
                                       [[NSDateFormatter alloc] init];
                                       //设置时区
                                       [outputFormatter setLocale:[NSLocale currentLocale]];
                                       [outputFormatter setDateFormat:@"yyyy-MM-dd"];
                                       //                                       NSString *dateStr =
                                       //                                       [outputFormatter
                                       //                                       stringFromDate:date];
                                       //                                       double value =
                                       //                                       [quantity
                                       //                                       doubleValueForUnit:unit];
                                       //                                       double value =
                                       //                                       [quantity
                                       //                                       doubleValueForUnit:unit];
                                       
                                       [resulteArray addObject:result];
                                       [dateArray addObject:result.startDate];
                                       //                                       [valueArray
                                       //                                       addObject:@(value)];
                                   }];
        
        if (success) {
            success(resulteArray);
        }
        
    };
    [healthStore executeQuery:query];
}

+ (void)getQuantity1Type:(HKQuantityType *)type
                  ofDate:(NSDate *)date
           daysLastCount:(NSUInteger)days
              outputUnit:(HKUnit *)unit
                 success:(hk_successBlock)success
                 failure:(hk_failureBlock)failure {
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;
    //设置一个计算的时间点
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |
     NSCalendarUnitWeekday
                fromDate:[NSDate date]];
    
    NSInteger offset = (7 + anchorComponents.weekday - 2) % 7;
    anchorComponents.day -= offset;
    //设置从几点开始计时
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    //创建查询   intervalcomponents:按照多少时间间隔查询
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc]
                                          initWithQuantityType:type
                                          quantitySamplePredicate:nil
                                          options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource
                                          anchorDate:anchorDate
                                          intervalComponents:interval];
    __block NSUInteger blockDay = days;
    //查询结果
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query,
                                    HKStatisticsCollection *results, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error.description);
            if (failure) {
                failure(error);
            }
        }
        
        // NSLog(@"sportResults %@", results);
        NSDate *endDate = date ? date : [NSDate date];
        /*
         blockDay：表示从今天开始逐步查询后面(blockDay)天的步数(0表示查询全部，1表示查询1天)
         NSCalendarUnitDay  表示按照什么类型输出
         */
        if (days == 0) {
            blockDay = results.statistics.count + 1;
        }
        NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay
                                                 value:-(blockDay - 1)
                                                toDate:endDate
                                               options:0];
        
        NSMutableArray *resulteArray = [NSMutableArray array];
        NSMutableArray *dateArray = [NSMutableArray array];
        
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *_Nonnull result, BOOL *_Nonnull stop) {
                                       
                                       //                                       HKQuantity *quantity
                                       //                                       =
                                       //                                       result.sumQuantity;
                                       //                                       NSDate *date =
                                       //                                       result.startDate;
                                       //                                       HKQuantity
                                       //                                       *quantity;
                                       //
                                       //                                       for (HKSource
                                       //                                       *source in
                                       //                                       result.sources) {
                                       //                                           if ([source.name
                                       //                                           isEqualToString:[UIDevice
                                       //                                           currentDevice].name])
                                       //                                           {
                                       //                                               quantity =
                                       //                                               [result
                                       //                                               sumQuantityForSource:source];
                                       //                                           }
                                       //                                       }
                                       
                                       NSDateFormatter *outputFormatter =
                                       [[NSDateFormatter alloc] init];
                                       //设置时区
                                       [outputFormatter setLocale:[NSLocale currentLocale]];
                                       [outputFormatter setDateFormat:@"yyyy-MM-dd"];
                                       //                                       NSString *dateStr =
                                       //                                       [outputFormatter
                                       //                                       stringFromDate:date];
                                       
                                       //                                       double value =
                                       //                                       [quantity
                                       //                                       doubleValueForUnit:unit];
                                       
                                       [resulteArray addObject:result];
                                       [dateArray addObject:result.startDate];
                                       //                                       [valueArray
                                       //                                       addObject:@(value)];
                                   }];
        
        if (success) {
            success(resulteArray);
        }
        
    };
    [healthStore executeQuery:query];
}

+ (void)getStepFromStartDate:(NSDate *)startDate
                   toEndDate:(NSDate *)endDate
                     success:(hk_parTimetSuccessBlock)success
                     failure:(hk_failureBlock)failure {
    HKSampleType *sampleType =
    [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSSortDescriptor *start =
    [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end =
    [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    if (!endDate) {
        endDate = [NSDate date];
    }
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate
                                                               endDate:endDate
                                                               options:HKQueryOptionNone];
    __block double stepValue = 0.0;
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]
                                  initWithSampleType:sampleType
                                  predicate:predicate
                                  limit:0
                                  sortDescriptors:@[ start, end ]
                                  resultsHandler:^(HKSampleQuery *_Nonnull query,
                                                   NSArray<__kindof HKSample *> *_Nullable results,
                                                   NSError *_Nullable error) {
                                      
                                      if (error) {
                                          NSLog(@"error = %@", error.description);
                                          if (failure) {
                                              failure(error);
                                          }
                                      }
                                      
                                      // NSString *deviceName = [UIDevice currentDevice].name;
                                      for (int i = 0; i < results.count; i++) {
                                          HKQuantitySample *result = (HKQuantitySample *)results[i];
                                          HKSource *source = result.source;
                                          HKQuantity *quantity = result.quantity;
                                          // 根据需求拓展或者筛选数据源,这里只过滤掉用户手动补充的数据
                                          
                                          if (![source.name isEqualToString:HealthSourceDeviceName]) {
                                              stepValue =
                                              (double)[quantity doubleValueForUnit:[HKUnit countUnit]] + stepValue;
                                          }
                                      }
                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                          if (success) {
                                              success(stepValue);
                                          }
                                          
                                      }];
                                  }];
    [healthStore executeQuery:sampleQuery];
}

+ (void)getWalkRunNumberFromStartDate:(NSDate *)startDate
                            toEndDate:(NSDate *)endDate
                              success:(hk_parTimetSuccessBlock)success
                              failure:(hk_failureBlock)failure {
    HKSampleType *sampleType =
    [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSSortDescriptor *start =
    [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end =
    [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    if (!endDate) {
        endDate = [NSDate date];
    }
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate
                                                               endDate:endDate
                                                               options:HKQueryOptionNone];
    __block double stepValue = 0.0;
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]
                                  initWithSampleType:sampleType
                                  predicate:predicate
                                  limit:0
                                  sortDescriptors:@[ start, end ]
                                  resultsHandler:^(HKSampleQuery *_Nonnull query,
                                                   NSArray<__kindof HKSample *> *_Nullable results,
                                                   NSError *_Nullable error) {
                                      
                                      if (error) {
                                          NSLog(@"error = %@", error.description);
                                          if (failure) {
                                              failure(error);
                                          }
                                      }
                                      
                                      // NSString *deviceName = [UIDevice currentDevice].name;
                                      
                                      
                                      for (int i = 0; i < results.count; i++) {
                                          HKQuantitySample *result = (HKQuantitySample *)results[i];
                                          HKSource *source = result.source;
                                          HKQuantity *quantity = result.quantity;
                                          // 根据需求拓展或者筛选数据源,这里只过滤掉用户手动补充的数据
                                          
                                          if (![source.bundleIdentifier isEqualToString:HealthSourceDeviceName]) {
                                              stepValue =
                                              (double)[quantity doubleValueForUnit:[HKUnit meterUnit]] + stepValue;
                                          }
                                      }
                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                          if (success) {
                                              success(stepValue);
                                          }
                                          
                                      }];
                                      
                                  }];
    [healthStore executeQuery:sampleQuery];
}

@end
