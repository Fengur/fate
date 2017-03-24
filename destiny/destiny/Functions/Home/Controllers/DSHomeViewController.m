//
//  DSHomeViewController.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "DSHomeViewController.h"
#import "DSJokeCell.h"
#import "DSJokeModel.h"
#import "UITableView+FG.h"
#import "MJRefresh.h"

#define JokeRes_Body @"showapi_res_body"
@interface DSHomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_jokeArray;
    CGFloat historyY;
    UIView *_backView;
    NSInteger _currentPage;
}
@end

@implementation DSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Relax";
    [self setupTabLeView];
    _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _backView.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    _jokeArray = [NSMutableArray new];
    _currentPage = 1;
    [self requestJokeWithPage:@"1"];
    
    [UIView animateWithDuration:1.5 animations:^{
        _backView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
    }];
}

- (void)setupTabLeView{
    _containTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavHeight) style:UITableViewStylePlain];
    _containTableView.backgroundColor = [UIColor clearColor];
    _containTableView.delegate = self;
    _containTableView.dataSource = self;
    _containTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_containTableView hideBottomEmptyCells];
    [self.view addSubview:_containTableView];
    [self setReresh];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (historyY + 20<targetContentOffset->y){
        [self setTabBarHidden:YES];
    }else if(historyY-20>targetContentOffset->y){
        [self setTabBarHidden:NO];
    }
    historyY = targetContentOffset->y;
}

- (void)setTabBarHidden:(BOOL)hidden{
    UIView *tab = self.tabBarController.view;
    CGRect  tabRect=self.tabBarController.tabBar.frame;
    if ([tab.subviews count] < 2) {
        return;
    }
    
    UIView *view;
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden){
        view.frame = tab.bounds;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    }else{
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame=tabRect;
    }completion:^(BOOL finished) {
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSJokeCell *cell = [[DSJokeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:@"cellID"];
    if(_jokeArray.count>0){
        [cell setJokeCellDetailWithModel:(DSJokeModel *)_jokeArray[indexPath.row]];
    }
    return [cell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _jokeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[DSJokeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if(_jokeArray.count>0){
        [cell setJokeCellDetailWithModel:(DSJokeModel *)_jokeArray[indexPath.row]];
    }
    return cell;
}

- (void)setReresh {
    _containTableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                     refreshingAction:@selector(headerReresh)];
    
    _containTableView.mj_footer =
    [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                         refreshingAction:@selector(footerLoading)];
}

- (void)headerReresh{
    _currentPage = 1;
    [_jokeArray removeAllObjects];
    [self requestJokeWithPage:@"1"];
}

- (void)footerLoading{
    _currentPage ++;
    [self requestJokeWithPage:[NSString stringWithFormat:@"%ld",_currentPage]];
}


- (void)requestJokeWithPage:(NSString *)pageNumber{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
