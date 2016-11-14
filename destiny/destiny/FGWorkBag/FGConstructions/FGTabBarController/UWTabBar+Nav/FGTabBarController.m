//
//  UWTabBarController.m
//  uworks-library
//
//  Created by SheldonLee on 15/11/29.
//  Copyright © 2015年 Sheldon. All rights reserved.
//

#import "CYLTabBarController.h"
#import "FGNavigationController.h"
#import "FGTabBarController.h"
#import <objc/runtime.h>
@interface UWTabBarController ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation UWTabBarController

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];

        /*
         *
         在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括
         title、Image、selectedImage。
         *
         */
        [self setUpTabBarItemsAttributesForController:tabBarController];

        [tabBarController setViewControllers:@[
        ]];
        /**
         *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar
         * 背景图片属性
         */
        [[self class] customizeTabBarAppearance];
        [tabBarController setSelectedIndex:0];
        _tabBarController = tabBarController;

    return _tabBarController;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括
 title、Image、selectedImage。
 *
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    NSDictionary *dict1 = @{
        CYLTabBarItemImage : @"homeNormal",
        CYLTabBarItemSelectedImage : @"homeSelect",
        CYLTabBarItemTitle : @"运动"
    };

    NSDictionary *dict2 = @{
        CYLTabBarItemImage : @"rankNormal",
        CYLTabBarItemSelectedImage : @"rankSelect",
        CYLTabBarItemTitle : @"排名"
    };

    NSDictionary *dict3 = @{
        CYLTabBarItemImage : @"shopNormal",
        CYLTabBarItemSelectedImage : @"shopSelect",
        CYLTabBarItemTitle : @"积分兑换"
    };
    NSDictionary *dict4 = @{
        CYLTabBarItemImage : @"mineNormal",
        CYLTabBarItemSelectedImage : @"mineSelect",
        CYLTabBarItemTitle : @"我的"
    };

    NSArray *tabBarItemsAttributes = @[
        dict1,
        dict2,
        dict3,
        dict4,
    ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
+ (void)customizeTabBarAppearance {
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];

    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];

    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateHighlighted];

    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色

    /*
    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor
    colorWithRed:26/255.0 green:163/255.0 blue:133/255.0 alpha:1] forSize:CGSizeMake([UIScreen
    mainScreen].bounds.size.width/5.0f, 49) withCornerRadius:0]];
    */
    // set the bar background color
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);

    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];

    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();

    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();

    return image;
}

@end
