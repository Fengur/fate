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

#import "DSHomeViewController.h"
#import "DSMineViewController.h"
#import "DSTravelViewController.h"

@interface FGTabBarController ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation FGTabBarController

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {

        DSHomeViewController *homeVC = [[DSHomeViewController alloc]init];
        FGNavigationController *firstNav = [[FGNavigationController alloc]initWithRootViewController:homeVC];
        
        DSMineViewController *mineVC = [[DSMineViewController alloc]init];
        FGNavigationController *secondNav = [[FGNavigationController alloc]initWithRootViewController:mineVC];
        
        DSTravelViewController *travelVC = [[DSTravelViewController alloc]init];
        FGNavigationController *thirdVC = [[FGNavigationController alloc]initWithRootViewController:travelVC];
        
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];

        /*
         *
         在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括
         title、Image、selectedImage。
         *
         */
        [self setUpTabBarItemsAttributesForController:tabBarController];

        [tabBarController setViewControllers:@[
                                               firstNav,
                                               thirdVC,
                                               secondNav,
        ]];
        /**
         *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar
         * 背景图片属性
         */
        [[self class] customizeTabBarAppearance];
        [tabBarController setSelectedIndex:0];
        _tabBarController = tabBarController;
    }
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
        CYLTabBarItemImage : @"one_N",
        CYLTabBarItemSelectedImage : @"one_S",
        CYLTabBarItemTitle : @"Relax"
    };

    NSDictionary *dict2 = @{
        CYLTabBarItemImage : @"two_N",
        CYLTabBarItemSelectedImage : @"two_S",
        CYLTabBarItemTitle : @"Notes"
    };

    NSDictionary *dict3 = @{
        CYLTabBarItemImage : @"three_N",
        CYLTabBarItemSelectedImage : @"three_S",
        CYLTabBarItemTitle : @"See"
    };
    NSDictionary *dict4 = @{
        CYLTabBarItemImage : @"mineNormal",
        CYLTabBarItemSelectedImage : @"mineSelect",
        CYLTabBarItemTitle : @"我的"
    };

    NSArray *tabBarItemsAttributes = @[
        dict1,
        dict3,
        dict2,
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
    normalAttrs[NSFontAttributeName] = DailyFont(13);

    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    selectedAttrs[NSFontAttributeName] = DailyFont(13);

    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色

    
//    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor
//    colorWithRed:26/255.0 green:163/255.0 blue:133/255.0 alpha:1] forSize:CGSizeMake([UIScreen
//    mainScreen].bounds.size.width/5.0f, 49) withCornerRadius:0]];
    
    // set the bar background color
    // 设置背景图片
     UITabBar *tabBarAppearance = [UITabBar appearance];
     [tabBarAppearance setBackgroundImage:[self imageFromColor:[UIColor blackColor] forSize:CGSizeMake(ScreenWidth, 49) withCornerRadius:0]];
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
