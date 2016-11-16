//
//  DSTravelDetailViewController.h
//  destiny
//
//  Created by Fengur on 2016/11/16.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSTravelDetailViewController : UIViewController

@property (nonatomic, copy) NSString *loadUrl;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *titleStr;

@end
