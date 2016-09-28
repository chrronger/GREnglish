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
#import "GRVideoModel.h"
#import "MJExtension.h"
#import "GRUrl.h"
#import "HomeHeaderView.h"
#import "GRHomeCell.h"

@interface GRHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_brnnerArray;
    NSArray *_categoryArray;
    NSMutableArray *_cellDataArray;
    int _categoryCount;
}

@end

@implementation GRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellDataArray = [[NSMutableArray alloc] init];
    [self requestHeaderData];
    [self reuqestCellData];
    [self reloadTableView];
    
    // Do any additional setup after loading the view.
}

- (void)requestHeaderData{
    __weak typeof(self) weakSelf = self;
    NSDictionary *param1 = @{@"user_id":@0,@"have_data":@1,@"count":@1};
    [FGNetworking requsetWithPath:GET_ALL_CATEGORIES params:param1 method:Get handleBlcok:^(id response, NSError *error) {
        [weakSelf requestResponse:response error:error source:@"AllCategory"];
    }];
    
    NSDictionary *param2  = @{@"category_id":@0,@"page":@1,@"count":@5,@"recommend":@1};
    [FGNetworking requsetWithPath:GET_VIDEO_INFOS_LIST params:param2 method:Get handleBlcok:^(id response, NSError *error) {
        [weakSelf requestResponse:response error:error source:@"Brnner"];
    }];
}

- (void)reuqestCellData{
    _categoryCount = 0;
    __weak typeof(self) weakSelf = self;
    
    [_cellDataArray removeLastObject];
    for (int i = 0; i < 7; i++) {
        NSNumber *cid = [NSNumber numberWithInt:i+1];
        NSDictionary *param2  = @{@"category_id":cid,@"page":@1,@"count":@4,@"recommend":@0};
        [FGNetworking requsetWithPath:GET_VIDEO_INFOS_LIST params:param2 method:Get handleBlcok:^(id response, NSError *error) {
            [weakSelf requestResponse:response error:error source:@"Cell"];
        }];
    }
}

- (void)requestResponse:(id)responseObject error:(NSError *)error source:(NSString *)source{
    if ([source isEqualToString:@"AllCategory"]) {
        if (responseObject) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            NSArray *categoryImgArray = @[@"danci",@"kouyu",@"tingli",@"yinbiao",@"yuedu",@"yufa",@"zuowen"];
            for (int i = 0; i < [responseObject[@"result"] count]; i++) {
                GRAllCategoryModel *model = [GRAllCategoryModel mj_objectWithKeyValues:responseObject[@"result"][i]];
                [dataArray addObject:model];
                model.logoStr = categoryImgArray[i];
            }
            _categoryArray = dataArray;
            [self loadHeaderView];
        }
    }else if([source isEqualToString:@"Brnner"]){
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in responseObject[@"result"][@"data"]) {
            GRVideoModel *model = [GRVideoModel mj_objectWithKeyValues:dic];
            [dataArray addObject:model];
        }
        _brnnerArray = dataArray;
         [self loadHeaderView];
    }else{
        _categoryCount ++;
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in responseObject[@"result"][@"data"]) {
            GRVideoModel *model = [GRVideoModel mj_objectWithKeyValues:dic];
            [dataArray addObject:model];
        }
        [_cellDataArray addObject:dataArray];
        if (_categoryCount == 7) {
             [_tableView reloadData];
        }
    }
}

- (void)reloadTableView{
    if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
            _tableView.delegate =self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView];
        [_tableView registerClass:[GRHomeCell class] forCellReuseIdentifier:@"homeCell"];
    }
}

- (void)loadHeaderView{
    if (!_tableView) {
        [self reloadTableView];
    }
    if (_brnnerArray.count && _categoryArray.count) {
        [self layoutHeaderView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _cellDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (!cell) {
        cell = [[GRHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    
    if (_cellDataArray.count > indexPath.section) {
         NSMutableArray *array = _cellDataArray[indexPath.section];
    if (array && array.count) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = indexPath.row *2; i < indexPath.row *2+2; i++) {
            [arr addObject:array[i]];
        }
        [cell layoutCellWithVideoModelArray:arr];
    }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 20)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat leftViewHeight = 15;
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (bgView.height-leftViewHeight)/2, 4, leftViewHeight)];
    leftView.image = [UIImage imageNamed:@"home_header_line"];
    [bgView addSubview:leftView];
    
    UILabel *label = [UILabel labelWithText:[(GRAllCategoryModel *)_categoryArray[section] name]
                                   fontSize:12
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    label.frame = CGRectMake(20,(bgView.height-leftViewHeight)/2 , 100, leftViewHeight);
    [bgView addSubview:label];
    
    UIButton *button = [UIButton buttonWithTitle:@"更多" titleFont:11 titleColor:[UIColor blueColor] target:self action:@selector(moreClick:)];
    button.tag = 334+section;
    [button setTitleColor:[UIColor colorWithRed:129.0/255 green:159.0/255 blue:174.0/255 alpha:1] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"btn_more"] forState:UIControlStateNormal];
    button.frame = CGRectMake(bgView.width-40, 0, 40, 20);
    [bgView addSubview:button];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    return bgView;
}

- (void)moreClick:(UIButton *)button{
    if (button.tag  == 334) {
        //第0组；
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  (SCREEN_WIDTH-30)/2*(375.0/750)+40;
}

- (void)layoutHeaderView{
    HomeHeaderView *view = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 375.0/750*SCREEN_WIDTH+70) source1Array:_brnnerArray source2Array:_categoryArray];
    _tableView.tableHeaderView = view;
}

- (void)headerViewdidSelect:(id)model{
    
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
