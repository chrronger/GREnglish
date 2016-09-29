//
//  GRTweetsViewController.m
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetsViewController.h"
#import "GRTweetListModel.h"
#import "GRTweetListCell.h"
#import "GRTweetDetailController.h"

@interface GRTweetsViewController ()<UITableViewDelegate,UITableViewDataSource,TweetListDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweetList;
@end

@implementation GRTweetsViewController
{
    TweetListParm *parm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupParm];
    [self getTweetListData];
    [self setupTableView];
    [self PullToReloadData];
}

#pragma mark - Data
- (void)setupParm
{
    parm = [[TweetListParm alloc] init];
    parm.type = @"new";
    parm.page = @1;
    parm.count = @10;
    parm.user_id = @0;
    self.tweetList = [[NSMutableArray alloc] initWithCapacity:10];
}

- (void)PullToReloadData
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        parm.page = @1;
        [self.tweetList removeAllObjects];
        [self getTweetListData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSInteger index = [parm.page integerValue];
        parm.page = [NSNumber numberWithInteger:index+1];
        [self getTweetListData];
    }];
}

- (void)getTweetListData
{
    NSDictionary *parmDic = [parm mj_keyValues];
    [FGNetworking requsetWithPath:GET_TWEETS_LIST params:parmDic method:Get handleBlcok:^(id response, NSError *error) {
        if (response) {
             GRLog(@"%@", response[@"result"][@"data"]);
    
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            NSArray *dataArr = [GRTweetListModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"data"]];
           
            for (GRTweetListModel *model in dataArr) {
                NSString *imgStr = [[model.images firstObject] objectForKey:@"href"];
                model.images = (imgStr == nil) ? nil : @[imgStr];
            }

            [self.tweetList addObjectsFromArray:dataArr];
            [self.tableView reloadData];
            
        }
        if (error) {
            GRLog(@"%@", error);
        }
    }];
    
}

#pragma mark - TweetListDelegate
- (void)tweetListCellDidClickLikeAtIndex:(NSInteger)index
{
    GRLog(@"点赞--%ld", index);
}

- (void)tweetListCellDidClickCommontAtIndex:(NSInteger)index
{
    GRLog(@"评论--%ld", index);
}

#pragma mark - UI
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[GRTweetListCell class] forCellReuseIdentifier:@"GRTweetListCell"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRTweetListModel *model = self.tweetList[indexPath.row];
    GRTweetListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GRTweetListCell" forIndexPath:indexPath];
    cell.row = indexPath.row;
    cell.model = model;
    cell.delegate = self;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.tweetList[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GRTweetListCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tabBarController.tabBar setHidden:YES];
    GRTweetDetailController *detailCtl = [[GRTweetDetailController alloc] init];
    detailCtl.model = self.tweetList[indexPath.row];
    [self.navigationController pushViewController:detailCtl animated:YES];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
