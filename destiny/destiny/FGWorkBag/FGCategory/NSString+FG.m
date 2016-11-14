//
//  NSString+FG.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "NSString+FG.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>
#define PASSWORD_MIN 6
#define PASSWORD_MAX 25

@implementation NSString (FG)

+ (NSArray *)getLastWeekNumArrayWithFormat:(NSString *)format {
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];    // you can use your format.
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;
    //设置一个计算的时间点
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |
     NSCalendarUnitWeekday
                fromDate:today];
    
    NSInteger offset = (7 + anchorComponents.weekday - 2) % 7;
    anchorComponents.day -= offset;
    //设置从几点开始计时
    anchorComponents.hour = 0;
    
    for (int i = 7; i > 0; i--) {
        NSDate *startDate =
        [calendar dateByAddingUnit:NSCalendarUnitDay value:-i toDate:[self GetTomorrowDate:today] options:0];
        
        NSString *dayString = [dateFormat stringFromDate:startDate];
        
        [array addObject:dayString];
    }
    return array;
}

+ (NSString *)currentDate {
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"YYYY-MM-dd"];
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

+ (NSDate *)dateOfTodayBeginning {
    
    NSString *startDateString = [NSString currentDateWithDateFormat:@"YYYY-MM-dd"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"YYYY-MM-dd"];
    
    NSDate *destDate = [dateFormatter dateFromString:startDateString];
    
    return destDate;
}


+ (NSString *)currentDateWithDateFormat:(NSString *)formatString {
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatString];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

+ (NSString *)stringFormat:(NSString *)format date:(NSDate *)date {
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    NSString *locationString = [dateformatter stringFromDate:date];
    return locationString;
}

+ (NSString *)getCurrentTimestamp {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (NSString *)compareCurrentTime:(NSString *)compareDate {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    NSString *newDate = [NSString getDateStringFromLongString:compareDate];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *date = [dateformatter dateFromString:newDate];
    //    NSString * yesterday = [dateformatter stringFromDate:[NSDate
    //    dateWithTimeIntervalSinceNow:-(24*60*60)]];
    
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if ((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    } else if ((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    } else {
        NSDate *dat = [dateformatter dateFromString:compareDate];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"YYYY-MM-dd HH:mm"];
        result = [format stringFromDate:dat];
    }
    //    else if([[compareDate substringWithRange:NSMakeRange(8, 2)] isEqualToString:[yesterday
    //    substringWithRange:NSMakeRange(8, 2)]]){
    //        result = [NSString stringWithFormat:@"昨天 %@",[compareDate
    //        substringWithRange:NSMakeRange(11, 5)]];
    //    }
    return result;
}

+ (NSString *)getAgeStrFromBirthday:(NSString *)birthday {
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *locationDateString = [formatter stringFromDate:todayDate];
    NSArray *Tarray = [locationDateString componentsSeparatedByString:@"-"];
    NSString *TyearStr = [Tarray objectAtIndex:0];
    NSString *Tmonth = [Tarray objectAtIndex:1];
    NSString *Tday = [Tarray objectAtIndex:2];
    if ([birthday isEqualToString:@"0"]) {
        return @"0";
    } else {
        NSString *dateString = birthday;
        NSString *str = dateString;
        NSTimeInterval time = [str doubleValue] / 1000;
        NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
        NSArray *birthday = [currentDateStr componentsSeparatedByString:@"-"];
        NSString *year = [birthday objectAtIndex:0];
        NSString *month = [birthday objectAtIndex:1];
        NSString *day = [birthday objectAtIndex:2];
        if ([TyearStr intValue] > [year intValue] &&
            [Tmonth intValue] * 30 + [Tday intValue] >= [month intValue] * 30 + [day intValue]) {
            return [NSString stringWithFormat:@"%d", [TyearStr intValue] - [year intValue]];
        } else {
            int ageStr = [TyearStr intValue] - [year intValue] - 1;
            
            if (ageStr < 0) {
                ageStr = 0;
            }
            return [NSString stringWithFormat:@"%d", ageStr];
        }
    }
}

+ (NSString *)getConstellationStrFromDate:(NSString *)birthday {
    if (birthday == nil) {
        return @"暂未选择";
    }
    NSString *str = birthday;
    NSString *birthDayString = [NSString stringWithFormat:@"%.0f", [str doubleValue] / 1000];
    NSArray *today =
    [[self getDateStringFromLongString:birthDayString] componentsSeparatedByString:@"-"];
    NSString *month = [today objectAtIndex:1];
    NSString *day = [today objectAtIndex:2];
    NSString *monDay = [NSString stringWithFormat:@"%@%@", month, day];
    int monthDay = [monDay intValue];
    if (monthDay >= 321 && monthDay <= 419) {
        return @"白羊座";
    } else if (monthDay >= 420 && monthDay <= 520) {
        return @"金牛座";
    } else if (monthDay >= 521 && monthDay <= 621) {
        return @"双子座";
    } else if (monthDay >= 622 && monthDay <= 722) {
        return @"巨蟹座";
    } else if (monthDay >= 723 && monthDay <= 822) {
        return @"狮子座";
    } else if (monthDay >= 823 && monthDay <= 922) {
        return @"处女座";
    } else if (monthDay >= 923 && monthDay <= 1023) {
        return @"天秤座";
    } else if (monthDay >= 1024 && monthDay <= 1122) {
        return @"天蝎座";
    } else if (monthDay >= 1123 && monthDay <= 1221) {
        return @"射手座";
    } else if ((monthDay >= 1222 && monthDay <= 1230) || (monthDay >= 101 && monthDay <= 119)) {
        return @"摩羯座";
    } else if (monthDay >= 120 && monthDay <= 218) {
        return @"水瓶座";
    } else {
        return @"双鱼座";
    }
}

+ (NSString *)prettyTimeToNow:(NSString *)compareTime {
    NSString *newDate = [NSString setDateFromLongString:compareTime];
    NSString *lookDate = [NSString setLookDateFromLongString:compareTime];
    NSString *date = [NSString currentDate];
    NSArray *compareTimearray = [newDate componentsSeparatedByString:@"-"];
    NSArray *nowArray = [date componentsSeparatedByString:@"-"];
    int nowYear = [nowArray[0] intValue];
    int comYear = [compareTimearray[0] intValue];
    int nowMonth = [nowArray[1] intValue];
    int comMonth = [compareTimearray[1] intValue];
    int nowDay = [nowArray[2] intValue];
    int comDay = [compareTimearray[2] intValue];
    int nowHour = [nowArray[3] intValue];
    int comHour = [compareTimearray[3] intValue];
    int nowMin = [nowArray[4] intValue];
    int comMin = [compareTimearray[4] intValue];
    if (nowYear == comYear && nowMonth == comMonth && nowDay == comDay && nowHour == comHour &&
        nowMin == comMin) {
        return @"刚刚";
    } else if (nowYear == comYear && nowMonth == comMonth && nowDay == comDay &&
               nowHour == comHour) {
        return [NSString stringWithFormat:@"%d分钟前", nowMin - comMin];
    } else if (nowYear == comYear && nowMonth == comMonth && nowDay == comDay) {
        return [NSString stringWithFormat:@"%d小时前", nowHour - comHour];
    } else {
        return lookDate;
    }
}

+ (NSString *)getDateStringFromLongString:(NSString *)longDateString {
    if (longDateString.length >= 10) {
        NSString *dateString = [longDateString substringToIndex:10];
        NSString *str = dateString;
        NSTimeInterval time = [str doubleValue];
        NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
        return currentDateStr;
    } else {
        NSString *dateString = longDateString;
        NSString *str = dateString;
        NSTimeInterval time = [str doubleValue];
        NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
        return currentDateStr;
    }
}

+ (NSString *)setDateFromLongString:(NSString *)longString {
    NSString *dateString = [longString substringToIndex:10];
    NSString *str = dateString;
    NSTimeInterval time = [str doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

+ (NSString *)setLookDateFromLongString:(NSString *)longString {
    NSString *dateString = [longString substringToIndex:10];
    NSString *str = dateString;
    NSTimeInterval time = [str doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

+ (NSString *)GetTomorrowDay:(NSDate *)aDate
{
    //公里日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)]; //获取下一天日期
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (NSDate *)GetTomorrowDate:(NSDate *)aDate
{
    //公里日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)]; //获取下一天日期
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    return beginningOfWeek;
}

+ (NSString *)middelFourStarNumber:(NSString *)number {
    //星号字符串
    NSString *xinghaoStr = @"";
    //动态计算星号的个数
    for (int i = 0; i < number.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //前3后四中间以星号拼接
    number = [NSString stringWithFormat:@"%@%@%@", [number substringToIndex:3], xinghaoStr,
              [number substringFromIndex:number.length - 4]];
    return number;
}

+ (NSString *)removeWhitesetAndEnter:(NSString *)string {
    if (!string || [string isEqualToString:@""] || [string isEqualToString:@"<null>"]) {
        return string;
    }
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string =
    [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}

+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:attrs
                                context:nil]
    .size;
}

+ (NSString *)transStringFromInteger:(NSInteger)integer {
    
    NSString *timeStr;
    
    NSInteger hourNum = integer/3600;
    
    NSInteger minNum  = (integer - (3600 * hourNum))/60;
    
    NSInteger secNum  = (integer - (3600 * hourNum)) - (minNum * 60);
    
    NSString *hourStr;
    if (hourNum < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld",hourNum];
    }else {
        hourStr = [NSString stringWithFormat:@"%ld",hourNum];
    }
    
    NSString *minStr;
    if (minNum < 10) {
        minStr = [NSString stringWithFormat:@"0%ld",minNum];
    }else {
        minStr = [NSString stringWithFormat:@"%ld",minNum];
    }
    
    NSString *secStr;
    if (secNum < 10) {
        secStr = [NSString stringWithFormat:@"0%ld",secNum];
    }else {
        secStr = [NSString stringWithFormat:@"%ld",secNum];
    }
    
    timeStr = [NSString stringWithFormat:@"%@:%@:%@",hourStr, minStr, secStr];
    
    return timeStr;
}

#pragma mark - Input-Validation

+ (BOOL)validateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1[\\d]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validatePassword:(NSString *)password {
    if ([password length] < PASSWORD_MIN || [password length] > PASSWORD_MAX) {
        return NO;
    }
    
    /*只能输数字+字母*/
    for (int i = 0; i < [password length]; i++) {
        int a = [password characterAtIndex:i];
        if (!((a > 47 && a < 58) || (a > 64 && a < 91) || (a > 96 && a < 123))) return NO;
    }
    return YES;
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    if (identityCard.length != 18) {
        return NO;
    }
    NSArray *codeArray =
    [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7",
     @"9", @"10", @"5", @"8", @"4", @"2", nil];
    NSDictionary *checkCodeDic = [NSDictionary
                                  dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6",
                                                         @"5", @"4", @"3", @"2", nil]
                                  forKeys:[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6",
                                           @"7", @"8", @"9", @"10", nil]];
    
    NSScanner *scan = [NSScanner scannerWithString:[identityCard substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i = 0; i < 17; i++) {
        sumValue += [[identityCard substringWithRange:NSMakeRange(i, 1)] intValue] *
        [[codeArray objectAtIndex:i] intValue];
    }
    NSString *strlast =
    [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d", sumValue % 11]];
    
    if ([strlast isEqualToString:[[identityCard
                                   substringWithRange:NSMakeRange(17, 1)] uppercaseString]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange,
                                         NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                // surrogate pair
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc =
                                        ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            isEomji = YES;
                                        }
                                    }
                                } else {
                                    // non surrogate
                                    if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                                        isEomji = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        isEomji = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        isEomji = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        isEomji = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d ||
                                               hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c ||
                                               hs == 0x2b1b || hs == 0x2b50 || hs == 0x231a) {
                                        isEomji = YES;
                                    }
                                    if (!isEomji && substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        if (ls == 0x20e3) {
                                            isEomji = YES;
                                        }
                                    }
                                }
                            }];
    return isEomji;
}


+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
            lastObject];
}

+ (NSString *)cachePath {
    return
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)tempPath {
    return NSTemporaryDirectory();
}

- (NSString *)appendDocumentPath {
    return [[NSString documentPath] stringByAppendingPathComponent:self];
}

- (NSString *)appendCachePath {
    return [[NSString cachePath] stringByAppendingPathComponent:self];
}

- (NSString *)appendTempPath {
    return [[NSString tempPath] stringByAppendingPathComponent:self];
}

@end
