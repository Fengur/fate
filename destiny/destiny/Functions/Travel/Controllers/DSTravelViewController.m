//
//  DSTravelViewController.m
//  destiny
//
//  Created by Fengur on 2016/11/15.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "DSTravelViewController.h"
#import "DSTravelModel.h"
#import "UITableView+FG.h"
#import "DSTravelCell.h"
#import "DSTravelDetailViewController.h"

@interface DSTravelViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_travelArray;
    CGFloat historyY;
    NSInteger _currentPage;
}
@end

@implementation DSTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"See";
    self.view.backgroundColor = [UIColor blackColor];
    _travelArray = [NSMutableArray new];
    
    [self setupTabLeView];
    [self requestTravelListWithPageNumber:@"1"];

    
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
    [_travelArray removeAllObjects];
    [self requestTravelListWithPageNumber:@"1"];
}

- (void)footerLoading{
    _currentPage ++;
    [self requestTravelListWithPageNumber:[NSString stringWithFormat:@"%ld",_currentPage]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DSTravelDetailViewController *detailVC = [[DSTravelDetailViewController alloc]init];
    if(_travelArray.count>0){
        detailVC.loadUrl = ((DSTravelModel *)_travelArray[indexPath.row]).bookUrl;
        detailVC.titleStr = ((DSTravelModel *)_travelArray[indexPath.row]).title;
    }
    [self.navigationController wxs_pushViewController:detailVC makeTransition:^(WXSTransitionProperty *transition) {
        transition.transitionType = WXSTransitionTypePush;
        transition.animationTime = GoldenScale;
        transition.animationType = WXSTransitionAnimationTypePointSpreadPresent;
    }];
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
    DSTravelCell *cell = [[DSTravelCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:@"cellID"];
    if(_travelArray.count>0){
       [cell setTravelCellDetailWithModel:(DSTravelModel *)_travelArray[indexPath.row]];
    }
    return [cell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _travelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSTravelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[DSTravelCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
    }
    if(_travelArray.count>0){
        [cell setTravelCellDetailWithModel:(DSTravelModel *)_travelArray[indexPath.row]];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)requestTravelListWithPageNumber:(NSString *)page{
    [FGHttpTool updateBaseUrl:TravelUrl];
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setObject:page forKey:@"page"];
    [FGHttpTool getWithURL:@"" params: paramDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id response = [responseObject objectForKey:@"data"];
        NSMutableArray *responseArray = [response objectForKey:@"books"];
        if(responseArray.count>0){
            for(int i = 0;i<responseArray.count;i++){
                DSTravelModel *model = [DSTravelModel new];
                model = [DSTravelModel yy_modelWithDictionary:responseArray[i]];
                [_travelArray addObject:model];
            }
        }
        [_containTableView reloadData];
        [_containTableView.mj_header endRefreshing];
        [_containTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_containTableView.mj_header endRefreshing];
        [_containTableView.mj_footer endRefreshing];
    }];
}

@end
