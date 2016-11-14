//
//  FGSizeTool.m
//  boxpi
//
//  Created by Fengur on 16/5/23.
//  Copyright © 2016年 onlybox. All rights reserved.
//

#import "FGSizeTool.h"

#define FGWidthSacle5 (ScreenWidth / 320)
#define FGWidthSacle6 (ScreenWidth / 375)
#define FGWidthSacle6P (ScreenWidth / 414)
#define FGHeightSacle5 (ScreenHeight / 568)
#define FGHeightSacle6 (ScreenHeight / 667)
#define FGHeightSacle6P (ScreenHeight / 736)

@implementation FGSizeTool

+ (CGFloat)widthWithSize5:(CGFloat)width {
    return width * FGWidthSacle5;
}

+ (CGFloat)widthWithSize6:(CGFloat)width {
    return width * FGWidthSacle6;
}

+ (CGFloat)widthWithSize6P:(CGFloat)width {
    return width * FGWidthSacle6P;
}

+ (CGFloat)heightWithSize5:(CGFloat)height {
    return height * FGHeightSacle5;
}

+ (CGFloat)heightWithSize6:(CGFloat)height {
    return height * FGHeightSacle6;
}

+ (CGFloat)heightWithSize6P:(CGFloat)height {
    return height * FGHeightSacle6P;
}

+ (CGFloat)fontWithIphone6:(CGFloat)fontSize {
    if (iPhone4) {
        fontSize = fontSize - 2;
    } else if (iPhone5) {
        fontSize = fontSize - 1;
    } else {
        fontSize = fontSize;
    }
    return fontSize;
}

+ (CGFloat)fontWithIphone5:(CGFloat)fontSize {
    if (iPhone6 || iPhone6Plus) {
        fontSize = fontSize + 1;
    } else if (iPhone4) {
        fontSize = fontSize - 1;
    } else {
        fontSize = fontSize;
    }
    return fontSize;
}

+ (CGFloat)fontWithIphone6P:(CGFloat)fontSize {
    if (iPhone6) {
        fontSize = fontSize;
    } else if (iPhone5) {
        fontSize = fontSize - 1;
    } else if (iPhone4) {
        fontSize = fontSize - 2;
    } else {
        fontSize = fontSize;
    }
    return fontSize;
}

@end
