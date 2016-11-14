//
//  FGFastInit.h
//  yeoner
//
//  Created by 王智超 on 16/1/26.
//  Copyright © 2016年 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FGFastInit : NSObject

+ (UITextField *)textFieldPlaceHolder:(NSString *)ph
                             fontSize:(CGFloat)size
                                frame:(CGRect)frame
                            alignment:(NSTextAlignment)align
                           leftString:(NSString *)leftString;

+ (UIView *)sigleLine:(CGRect)rect Color:(UIColor *)color;

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleC
                      bgColor:(UIColor *)bgC
                    imageName:(NSString *)imgName
                     fontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithTitle:(NSString *)title
                  textColor:(UIColor *)color
                       size:(CGFloat)size
                  alignment:(NSTextAlignment)aligenment
            backgroundColor:(UIColor *)bColor;

+ (UIView *)navBarTitle:(NSString *)title;

+ (UIView *)navBarCenterView:(NSString *)imageName;

+ (UIBarButtonItem *)rightBarButtonItem:(id)target
                                 action:(SEL)sel
                            rightString:(NSString *)rightString;

+ (UIBarButtonItem *)leftBarButtonItem:(id)target
                                action:(SEL)sel
                             imageName:(NSString *)imageName
                            leftString:(NSString *)leftString;
@end
