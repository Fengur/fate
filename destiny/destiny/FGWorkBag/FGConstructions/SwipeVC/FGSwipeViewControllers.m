//
//  UWSwipeViewControllers.m
//  yeoner
//
//  Created by 王智超 on 16/4/1.
//  Copyright © 2016年 com.fengur.demo. All rights reserved.
//

#define ButtonTag 1942
#import "FGSwipeViewControllers.h"

CGFloat X_BUFFER = 0.0;
CGFloat Y_BUFFER = 8.0;
CGFloat HEIGHT = 30.0;

CGFloat BOUNCE_BUFFER = 10.0;
CGFloat ANIMATION_SPEED = 0.2;
CGFloat SELECTOR_Y_BUFFER = 40.0;
CGFloat SELECTOR_HEIGHT = 4.0;

CGFloat X_OFFSET = 8.0;

@interface FGSwipeViewControllers ()

@property (nonatomic) UIScrollView *pageScrollView;
@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) BOOL isPageScrollingFlag;
@property (nonatomic) BOOL hasAppearedFlag;

@end

@implementation FGSwipeViewControllers
@synthesize viewControllerArray;
@synthesize selectionBar;
@synthesize pageController;
@synthesize navigationView;
@synthesize buttonText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    viewControllerArray = [[NSMutableArray alloc] init];
    self.currentPageIndex = 1;
    self.isPageScrollingFlag = NO;
    self.hasAppearedFlag = NO;
}

#pragma mark - CustomSettings
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupSegmentButtons {
    navigationView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                 self.navigationBar.frame.size.height)];

    NSInteger numControllers = [viewControllerArray count];

    if (!buttonText) {
        buttonText = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    }
    for (int i = 0; i < numControllers; i++) {
        UIButton *button = [[UIButton alloc]
            initWithFrame:CGRectMake(
                              X_BUFFER +
                                  i * (self.view.frame.size.width - 2 * X_BUFFER) / numControllers -
                                  X_OFFSET,
                              Y_BUFFER,
                              (self.view.frame.size.width - 2 * X_BUFFER) / numControllers,
                              HEIGHT)];
        [navigationView addSubview:button];
        button.titleLabel.font = AvenirMedium(17.f);
        if (i == 1) {
            button.selected = YES;
        }
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.tag = i + ButtonTag;
        [button addTarget:self
                      action:@selector(tapSegmentButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];

        [button setTitle:[buttonText objectAtIndex:i] forState:UIControlStateNormal];
    }

    pageController.navigationController.navigationBar.topItem.titleView = navigationView;
    [self setupSelector];
}

- (void)setupSelector {
    selectionBar =
        [[UIView alloc] initWithFrame:CGRectMake(X_BUFFER - X_OFFSET, SELECTOR_Y_BUFFER,
                                                 (self.view.frame.size.width - 2 * X_BUFFER) /
                                                     [viewControllerArray count],
                                                 SELECTOR_HEIGHT)];
    selectionBar.backgroundColor = [UIColor greenColor];
    /**是否显示下方状态条*/
    selectionBar.hidden = YES;
    selectionBar.alpha = 0.8;
    [navigationView addSubview:selectionBar];
}

#pragma mark - Setup
- (void)viewWillAppear:(BOOL)animated {
    if (!self.hasAppearedFlag) {
        [self setupPageViewController];
        [self setupSegmentButtons];
        self.hasAppearedFlag = YES;
    }
}

- (void)setupPageViewController {
    pageController = (UIPageViewController *)self.topViewController;
    pageController.delegate = self;
    pageController.dataSource = self;
    [pageController setViewControllers:@[ [viewControllerArray objectAtIndex:1] ]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:YES
                            completion:nil];
    [self setUpScrollView];
}

- (void)setUpScrollView {
    for (UIView *view in pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            self.pageScrollView = (UIScrollView *)view;
            self.pageScrollView.delegate = self;
            self.pageScrollView.scrollEnabled = NO;
        }
    }
}

#pragma mark Movement

- (void)tapSegmentButtonAction:(UIButton *)button {
    for (int i = 0; i < [viewControllerArray count]; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i + ButtonTag];
        if (i != button.tag - ButtonTag) {
            btn.selected = NO;
        } else {
            btn.selected = YES;
        }
    }

    if (!self.isPageScrollingFlag) {
        NSInteger tempIndex = self.currentPageIndex;
        __weak typeof(self) weakSelf = self;
        if (button.tag - ButtonTag > tempIndex) {
            for (int i = (int)tempIndex + 1; i <= button.tag - ButtonTag; i++) {
                [pageController setViewControllers:@[ [viewControllerArray objectAtIndex:i] ]
                                         direction:UIPageViewControllerNavigationDirectionForward
                                          animated:YES
                                        completion:^(BOOL complete) {
                                            if (complete) {
                                                [weakSelf updateCurrentPageIndex:i];
                                            }
                                        }];
            }
        } else if (button.tag - ButtonTag < tempIndex) {
            for (int i = (int)tempIndex - 1; i >= button.tag - ButtonTag; i--) {
                [pageController setViewControllers:@[ [viewControllerArray objectAtIndex:i] ]
                                         direction:UIPageViewControllerNavigationDirectionReverse
                                          animated:YES
                                        completion:^(BOOL complete) {
                                            if (complete) {
                                                [weakSelf updateCurrentPageIndex:i];
                                            }
                                        }];
            }
        }
    }
}

- (void)updateCurrentPageIndex:(int)newIndex {
    self.currentPageIndex = newIndex;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xFromCenter = self.view.frame.size.width - scrollView.contentOffset.x;
    NSInteger xCoor = X_BUFFER + selectionBar.frame.size.width * self.currentPageIndex - X_OFFSET;
    selectionBar.frame =
        CGRectMake(xCoor - xFromCenter / [viewControllerArray count], selectionBar.frame.origin.y,
                   selectionBar.frame.size.width, selectionBar.frame.size.height);
}

#pragma mark - UIPageViewController Delegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PageViewController DataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [viewControllerArray indexOfObject:viewController];
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    index--;
    return [viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [viewControllerArray indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;

    if (index == [viewControllerArray count]) {
        return nil;
    }
    return [viewControllerArray objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed) {
        self.currentPageIndex =
            [viewControllerArray indexOfObject:[pageViewController.viewControllers lastObject]];

        for (int i = 0; i < [viewControllerArray count]; i++) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:i + ButtonTag];
            if (self.currentPageIndex != btn.tag - ButtonTag) {
                btn.selected = NO;
            } else {
                btn.selected = YES;
            }
        }
    }
}



//自定义导航栏返回键
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers count] > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [btn setImage:[UIImage imageNamed:@"backNormal"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.viewControllers.firstObject.navigationController.interactivePopGestureRecognizer
        .delegate = (id<UIGestureRecognizerDelegate>)self;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popself {
    [self popViewControllerAnimated:YES];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isPageScrollingFlag = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isPageScrollingFlag = NO;
}

@end
