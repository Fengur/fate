//
//  NSString+FG.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FG)

#pragma mark - Date
/**
 *  获取当前时间
 */
+ (NSString *)currentDate;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSDate *)dateOfTodayBeginning;

+ (NSString *)currentDateWithDateFormat:(NSString *)formatString;


+ (NSString *)stringFormat:(NSString *)format date:(NSDate *)date;

/**
 *  获取当前时间戳
 */
+ (NSString *)getCurrentTimestamp;

/**
 *  与当前时间比较
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDate;

/**
 *  根据时间戳返回需要的日期
 */
+ (NSString *)getDateStringFromLongString:(NSString *)longDateString;

/**
 *	根据返回时间戳处理
 */
+ (NSString *)prettyTimeToNow:(NSString *)compareTime;


/**
 *  根据生日年月日计算星座
 */
+ (NSString *)getConstellationStrFromDate:(NSString *)birthday;

/**
 *  根据生日计算年龄
 */
+ (NSString *)getAgeStrFromBirthday:(NSString *)birthday;

/**
 *  获取一周日期数组
 */
+ (NSArray *)getLastWeekNumArrayWithFormat:(NSString *)format;

/**
 *  获取指定日期的下一天日期
 */
+ (NSString *)GetTomorrowDay:(NSDate *)aDate;

#pragma mark - NSString Format
/**
 *  前3后4中间以*拼接,返回处理好的字符串
 */
+ (NSString *)middelFourStarNumber:(NSString *)number;

/**
 *  去除空格和换行符后的string
 */
+ (NSString *)removeWhitesetAndEnter:(NSString *)string;

/**
 *  获取字符串size
 */
+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize;

+ (NSString *)transStringFromInteger:(NSInteger)integer;

#pragma mark - 字符串校验

/**
 *  判断是否为手机号
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 *  判断是否满足密码限制（数字+字母）
 */
+ (BOOL)validatePassword:(NSString *)password;

/**
 *  判断是否为电子邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  判断是否为二代身份证格式
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/**
 *  判断是否含有emoji表情
 */
+ (BOOL)isContainsEmoji:(NSString *)string;



#pragma mark - 沙箱操作
/** 获取文档目录 */
+ (NSString *)documentPath;
/** 获取缓存目录 */
+ (NSString *)cachePath;
/** 获取临时目录 */
+ (NSString *)tempPath;

/**
 *  添加文档路径
 */
- (NSString *)appendDocumentPath;
/**
 *  添加缓存路径
 */
- (NSString *)appendCachePath;
/**
 *  添加临时路径
 */
- (NSString *)appendTempPath;
@end
