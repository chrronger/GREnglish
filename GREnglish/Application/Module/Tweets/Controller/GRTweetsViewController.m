//
//  GRTweetsViewController.m
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetsViewController.h"
#import "GRTweetModel.h"

@interface GRTweetsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation GRTweetsViewController
{
    TweetParm *parm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getTweetListData];
}

#pragma mark - Data
- (void)getTweetListData
{
    parm = [[TweetParm alloc] init];
    parm.type = @"new";
    parm.page = @1;
    parm.count = @10;
    parm.user_id = @0;
    NSDictionary *parmDic = [parm mj_keyValues];
    
    [FGNetworking requsetWithPath:GET_TWEETS_LIST params:parmDic method:Get handleBlcok:^(id response, NSError *error) {
        if (response) {
            GRLog(@"%@",response[@"result"][@"data"]);
        }
        if (error) {
            GRLog(@"%@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
