//
//  FGSizeTool.h
//  boxpi
//
//  Created by Fengur on 16/5/23.
//  Copyright © 2016年 onlybox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FGSizeTool : NSObject

+ (CGFloat)widthWithSize5:(CGFloat)width;
+ (CGFloat)widthWithSize6:(CGFloat)width;
+ (CGFloat)widthWithSize6P:(CGFloat)width;

+ (CGFloat)heightWithSize5:(CGFloat)height;
+ (CGFloat)heightWithSize6:(CGFloat)height;
+ (CGFloat)heightWithSize6P:(CGFloat)height;

+ (CGFloat)fontWithIphone5:(CGFloat)fontSize;
+ (CGFloat)fontWithIphone6:(CGFloat)fontSize;
+ (CGFloat)fontWithIphone6P:(CGFloat)fontSize;
@end
