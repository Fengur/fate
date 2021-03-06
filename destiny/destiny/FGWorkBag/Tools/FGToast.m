//
//  FGToast.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "FGToast.h"

@implementation FGToast

+ (void)showTips:(NSString *)tips {
    [self showTips:tips delay:2.5 position:FGToastPositionTypeDown];
}

+ (void)showTips:(NSString *)tips position:(FGToastPositionType)position {
    [self showTips:tips delay:2.5 position:position];
}

+ (void)showTips:(NSString *)tips delay:(NSTimeInterval)time {
    [self showTips:tips delay:time position:FGToastPositionTypeDown];
}

+ (void)showTips:(NSString *)tips
           delay:(NSTimeInterval)time
        position:(FGToastPositionType)position {
    //  添加label
    FGTipsLabel *label = [[FGTipsLabel alloc] init];
    label.text = [NSString stringWithString:tips];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 2;

    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];

    CGSize labelSize =
        [self sizeForString:tips
                       font:[UIFont systemFontOfSize:15]
                    maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 44)];

    // 稍微放大label的尺寸
    label.frame = CGRectMake(0, 0, labelSize.width + 10, labelSize.height + 10);
    label.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5,
                               [UIScreen mainScreen].bounds.size.height * position * 0.01);
    label.alpha = 0.0;

    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;

    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    if (![[[window subviews] lastObject] isKindOfClass:[FGTipsLabel class]]) {
        [window addSubview:label];
    }
    // 动画
    [UIView animateWithDuration:0.5
        animations:^{
            label.alpha = 0.5;
        }
        completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5
                delay:time
                options:UIViewAnimationOptionCurveLinear
                animations:^{
                    label.alpha = 0.0;
                }
                completion:^(BOOL finished) {
                    [label removeFromSuperview];
                }];
        }];
}

+ (void)showMessage:(NSString *)message controller:(UIViewController *)controller {
    [self showMessage:message controller:controller delay:0.5 font:15 labelHeight:35];
}

+ (void)showMessage:(NSString *)message
         controller:(UIViewController *)controller
              delay:(double)delay
               font:(CGFloat)font
        labelHeight:(int)labelHeight {
    __block BOOL messageIsShowing = NO;
    if (messageIsShowing) {
        return;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//    label.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, labelHeight);
    label.frame = CGRectMake(0, 24, [UIScreen mainScreen].bounds.size.width, labelHeight);

    [controller.navigationController.view
        insertSubview:label
         belowSubview:controller.navigationController.navigationBar];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.font = [UIFont systemFontOfSize:font];
    label.alpha = 0.0;

    [UIView animateWithDuration:0.5
        animations:^{
            label.transform = CGAffineTransformMakeTranslation(0, label.frame.size.height);
            label.alpha = 1.0;
        }
        completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3
                delay:delay
                options:UIViewAnimationOptionCurveLinear
                animations:^{
                    label.transform = CGAffineTransformIdentity;
                    label.alpha = 0.0;
                }
                completion:^(BOOL finished) {
                    messageIsShowing = NO;
                    [label removeFromSuperview];
                }];
        }];
}

+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:attrs
                                context:nil]
        .size;
}

@end

@implementation FGTipsLabel

@end
