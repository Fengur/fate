//
//  AppDelegate.h
//  destiny
//
//  Created by Fengur on 2016/11/4.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FGTabBarController;
@class DSADViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FGTabBarController *tabBarVC;
@property (strong, nonatomic) DSADViewController *adVC;


- (void)setAppRootVC;
@end

