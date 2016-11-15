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
}
@end

@implementation DSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笑之";
    [self setupTabLeView];

    _jokeArray = [NSMutableArray new];
    [self requestJokeWithPage:@"1"];
}

- (void)setupTabLeView{
    _containTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavHeight) style:UITableViewStylePlain];
    _containTableView.backgroundColor = [UIColor clearColor];
    _containTableView.delegate = self;
    _containTableView.dataSource = self;
    _containTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_containTableView hideBottomEmptyCells];
    [self.view addSubview:_containTableView];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//设置滑动的判定范围

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset

{
    
    if (historyY+20<targetContentOffset->y)
        
    {
        
        [self setTabBarHidden:YES];
        
    }
    
    else if(historyY-20>targetContentOffset->y)
        
    {
        
        
        
        [self setTabBarHidden:NO];
        
    }
    
    historyY=targetContentOffset->y;
    
}

//隐藏显示tabbar

- (void)setTabBarHidden:(BOOL)hidden

{
    
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
    
    
    
    if (hidden) {
        
        view.frame = tab.bounds;
        
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
        
    } else {
        
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

- (void)requestJokeWithPage:(NSString *)pageNumber{
    [FGHttpTool updateBaseUrl:JokeUrl];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:pageNumber forKey:@"page"];
    [FGHttpTool getWithURL:@"" params:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *resultArray = [[responseObject objectForKey:JokeRes_Body]objectForKey:@"contentlist"];
        [_jokeArray removeAllObjects];
        
        for(int i =0;i<resultArray.count;i++){
            DSJokeModel *model = [DSJokeModel new];
            model = [DSJokeModel yy_modelWithDictionary:resultArray[i]];
            [_jokeArray addObject:model];
        }

    [_containTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
