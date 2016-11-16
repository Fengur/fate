//
//  DSTravelDetailViewController.m
//  destiny
//
//  Created by Fengur on 2016/11/16.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "DSTravelDetailViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface DSTravelDetailViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,UIScrollViewDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end

@implementation DSTravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = _titleStr;
    [self setupControls];
    [self loadRequest];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:_progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)createProgress {
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 3.f;
    CGRect barFrame = CGRectMake(0,0, ScreenWidth, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
}
- (void)setupControls{
    [self createProgress];
    self.webView = [[UIWebView alloc] init];
    self.webView.scrollView.delegate = self;
    self.webView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight);
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor blackColor];
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.webView];
    [self setReresh];
}

- (void)setReresh {
    _webView.scrollView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                     refreshingAction:@selector(headerReresh)];
}

- (void)headerReresh{
    [self loadRequest];
}

- (void)loadRequest {
    NSString *url = self.loadUrl;
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:webRequest];
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
    if (STR_IS_NIL(self.title)) {
        self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_webView.scrollView.mj_header endRefreshing];
    [_progressView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_webView.scrollView.mj_header endRefreshing];
    [_progressView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
