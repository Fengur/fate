//
//  AppDelegate.m
//  destiny
//
//  Created by Fengur on 2016/11/4.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "AppDelegate.h"
#import "FGTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [UIViewController new];
    [self.window makeKeyAndVisible];
    _tabBarVC = [[FGTabBarController alloc]init];
    _window.rootViewController = _tabBarVC.tabBarController;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
