//
//  UIButton+FGCountDown.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FGCountDown)

/**
 *  倒计时按钮
 *
 *  @param timeLine      倒计时总时间
 *  @param title         还没倒计时的title
 *  @param normalColor   还没倒计时的颜色
 *  @param countingColor 倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine
                title:(NSString *)title
          normalColor:(UIColor *)normalColor
        countingColor:(UIColor *)countingColor;

@end
