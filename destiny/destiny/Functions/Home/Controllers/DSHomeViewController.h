//
//  DSHomeViewController.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBStoreHouseRefreshControl;
@interface DSHomeViewController : UIViewController

@property (nonatomic, strong) UITableView *containTableView;

@property (nonatomic, strong) CBStoreHouseRefreshControl *storeHouseRefreshControl;

@end
