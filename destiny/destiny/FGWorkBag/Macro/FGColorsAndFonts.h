//
//  FGColorsAndFonts.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>

// 颜色定义
#define HEXCOLOR(rgbValue)                                               \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:1.0]

#define RGBCOLOR(r, g, b) \
[UIColor colorWithRed:r % 256 / 255.0 green:g % 256 / 255.0 blue:b % 256 / 255.0 alpha:1]
#define RGBACOLOR(r, g, b, a) \
[UIColor colorWithRed:r % 256 / 255.0 green:g % 256 / 255.0 blue:b % 256 / 255.0 alpha:a]
#define UIColorFromRGB_16(rgbValue) \
([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])


// 字体定义
#define SYSTEM_FONT(fontSize) [UIFont systemFontOfSize:fontSize]
#define SYSTEM_BOLD_FONT(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define AvenirLightFont(fontSize) [UIFont fontWithName:@"Avenir-Light" size:fontSize]
#define AvenirMedium(fontSize) [UIFont fontWithName:@"Avenir-Medium" size:fontSize]
#define NavFont(fontSize) [UIFont fontWithName:@"Helvetica-Bold" size:fontSize]
