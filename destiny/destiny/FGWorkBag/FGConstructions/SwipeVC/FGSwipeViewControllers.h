//
//  UWSwipeViewControllers.h
//  yeoner
//
//  Created by 王智超 on 16/4/1.
//  Copyright © 2016年 com.fengur.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FGSwipeViewControllersDelegate<NSObject>

@end

@interface FGSwipeViewControllers
    : UINavigationController<UIPageViewControllerDelegate, UIPageViewControllerDataSource,
                             UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@property (nonatomic, weak) id<FGSwipeViewControllersDelegate> navDelegate;
@property (nonatomic, strong) UIView *selectionBar;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) NSArray *buttonText;

@end
