//
//  UITableView+FG.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FG)

/**
 *  让TableView多余的Cell不可见
 */
- (void)hideBottomEmptyCells;

/**
 *  分隔线左间距为0
 */
- (void)hideSeparatorLeftInset;

@end
