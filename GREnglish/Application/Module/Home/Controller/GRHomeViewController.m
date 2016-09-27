//
//  GRHomeViewController.m
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRHomeViewController.h"
#import "AFNetworking.h"
#import "GRAllCategoryModel.h"
#import "MJExtension.h"
#import "GRUrl.h"

@interface GRHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_categoryArray;
}

@end

@implementation GRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)requestData{
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *param = @{@"user_id":@0,@"have_data":@1,@"count":@1};
    param = @{@"category_id":@0,@"page":@1,@"count":@5,@"recommend":@1};
    [FGNetworking requsetWithPath:GET_VIDEO_INFOS_LIST params:param method:Get handleBlcok:^(id response, NSError *error) {
        [weakSelf requestResponse:response error:error];
    }];
}

- (void)requestResponse:(id)responseObject error:(NSError *)error{
    if (responseObject) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSArray *categoryImgArray = @[@"danci",@"kouyu",@"tingli",@"yinbiao",@"yuedu",@"yufa",@"zuowen"];
        for (int i = 0; i < dataArray.count; i++) {
            GRAllCategoryModel *model = [GRAllCategoryModel mj_objectWithKeyValues:responseObject[@"result"][i]];
            [dataArray addObject:model];
            model.logoStr = categoryImgArray[i];
        }
        _categoryArray = dataArray;
        [self loadAllView];
    }
}

- (void)loadAllView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    return cell;
}

- (void)layoutHeaderView{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
