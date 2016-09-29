//
//  GRTweetDetailController.m
//  GREnglish
//
//  Created by CarlXu on 16/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetDetailController.h"
#import "GRTweetCommentModel.h"
#import "GRTweetListCell.h"
#import "GRTweetDetailCell.h"
#import "InPutView.h"

@interface GRTweetDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweetList;
@end

@implementation GRTweetDetailController
{
    TweetCommonParm *parm;
    InPutView *inputView;
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
    parm = [[TweetCommonParm alloc] init];
    parm.type = @"tweet";
    parm.page = @1;
    parm.count = @10;
    parm.source_id = [NSNumber numberWithInteger:self.model.ID];
    self.tweetList = [[NSMutableArray alloc] initWithCapacity:10];
}

- (void)PullToReloadData
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        parm.page = @1;
        [self.tweetList removeAllObjects];
        [self getTweetListData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSInteger index = [parm.page integerValue];
        parm.page = [NSNumber numberWithInteger:index+1];
        [self getTweetListData];
    }];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
}

- (void)getTweetListData
{
    NSDictionary *parmDic = [parm mj_keyValues];
    [FGNetworking requsetWithPath:GET_COMMENT_LIST params:parmDic method:Get handleBlcok:^(id response, NSError *error) {
        if (response) {
            GRLog(@"%@", response);
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            NSArray *dataArr = [GRTweetCommentModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"data"]];
    
            [self.tweetList addObjectsFromArray:dataArr];
            [self.tableView reloadData];
            
        }
        if (error) {
            GRLog(@"%@", error);
        }
    }];
    
}

#pragma mark - UI
- (void)setupTableView
{
    self.tableView = [UITableView tableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) tableViewStyle:UITableViewStylePlain registerClass:@[@"GRTweetListCell",@"GRTweetDetailCell"] delegateObject:self];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    inputView = [[InPutView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-64, SCREEN_WIDTH, 40)];
    inputView.sendMsgBlock = ^(NSString *msg){
        
    };
    [self.view addSubview:inputView];

}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (self.tweetList.count > 0) ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : self.tweetList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        GRTweetListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GRTweetListCell" forIndexPath:indexPath];
        cell.model = self.model;
        // [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    } else
    {
        GRTweetDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"GRTweetDetailCell" forIndexPath:indexPath];
        detailCell.model = self.tweetList[indexPath.row];
        // [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return detailCell;

    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        id model = self.model;
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GRTweetListCell class] contentViewWidth:[self cellContentViewWith]];
    } else
    {
        id model = self.tweetList[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GRTweetDetailCell class] contentViewWidth:[self cellContentViewWith]];
    }
    
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
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
