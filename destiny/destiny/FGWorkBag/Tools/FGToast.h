//
//  FGToast.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FGToastPositionType) {
    FGToastPositionTypeUp = 20,
    FGToastPositionTypeMiddle = 50,
    FGToastPositionTypeDown = 80,

};

@interface FGToast : UIView


/**
 *  弹出toast提示框
 *
 *  @param tips 提示信息
 */
+ (void)showTips:(NSString *)tips;

/**
 *  弹出toast提示框
 *
 *  @param tips 提示信息
 *  @param position 显示位置
 */
+ (void)showTips:(NSString *)tips position:(FGToastPositionType)position;


/**
 *  弹出toast提示框
 *
 *  @param tips 提示信息
 *  @param position 显示位置(0-100)
 */
//+ (void)showTips:(NSString *)tips inCostomPosition:(NSUInteger)position;

/**
 *  弹出toast提示框
 *
 *  @param tips 提示信息
 *  @param time 显示时长
 */
+ (void)showTips:(NSString *)tips delay:(NSTimeInterval)time;

/**
 *  弹出toast提示框
 *
 *  @param tips     提示信息
 *  @param time     显示时长
 *  @param position 显示位置
 */
+ (void)showTips:(NSString *)tips delay:(NSTimeInterval)time position:(FGToastPositionType)position;


/**
 *  导航栏下弹出提示语
 *
 *  @param message    提示语
 *  @param controller 当前控制器
 */
+ (void)showMessage:(NSString *)message
         controller:(UIViewController *)controller;

/**
 *  导航栏下弹出提示语
 *
 *  @param message     提示语
 *  @param controller  当前控制器
 *  @param delay       演示时长
 *  @param font        字体大小
 *  @param labelHeight 显示高度
 */
+ (void)showMessage:(NSString *)message
         controller:(UIViewController *)controller
              delay:(double)delay
               font:(CGFloat)font
        labelHeight:(int)labelHeight;


@end

//  避免重复出现多次
@interface FGTipsLabel : UILabel

@end
