
//
//  HomeHeaderView.m
//  
//
//  Created by Waki on 16/9/27.
//
//

#import "HomeHeaderView.h"
#import "GRAllCategoryModel.h"
#import "GRVideoModel.h"


#define ScrollView1Height 375.0/750*SCREEN_WIDTH 
#define ScrollView2Height 70
@interface HomeHeaderView ()<UIScrollViewDelegate>
{
    NSArray * _source1Array;
    NSArray * _source2Array;
}

@end
@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
                 source1Array:(NSArray *)source1Array
                 source2Array:(NSArray *)source2Array;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewWithArray1:source1Array array2:source2Array];
    }
    return self;
}

- (void)setupViewWithArray1:(NSArray *)source1Array array2:(NSArray *)source2Array{
    _source1Array = source1Array;
    _source2Array = source2Array;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).widthIs(SCREEN_WIDTH).heightIs(ScrollView1Height);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*source1Array.count, ScrollView1Height);
    scrollView.pagingEnabled  = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    for (int i = 0; i < source1Array.count; i++) {
        GRVideoModel *model = source1Array[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(scrollView.frame))];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
        [scrollView addSubview:imgView];
    }
    
    UIScrollView *scrollView2 = [[UIScrollView alloc] init];
//    scrollView2.sd_layout.topSpaceToView(scrollView,5).leftSpaceToView(self,0).widthIs(SCREEN_WIDTH).heightIs(ScrollView2Height);
    scrollView2.showsHorizontalScrollIndicator = NO;
    scrollView2.frame = CGRectMake(0, ScrollView1Height,SCREEN_WIDTH, ScrollView2Height);
    scrollView2.contentSize = CGSizeMake(ScrollView2Height*source2Array.count, ScrollView2Height);
    [self addSubview:scrollView2];
    for (int i = 0; i < source2Array.count; i++) {
        GRAllCategoryModel *model = source2Array[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(70*i, 0, 70, ScrollView2Height);
       
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame =CGRectMake(20, 10, 30, 30);
        imgView.image = [UIImage imageNamed:model.logoStr];
        
        UILabel *label = [UILabel labelWithText:model.name fontSize:14 textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter];
//        label.sd_layout.topSpaceToView(imgView,10).leftSpaceToView(button,0).widthIs(button.size.width).heightIs(20);
        label.frame = CGRectMake(0, imgView.y+imgView.height+5, button.width, 20);
        
     
        [button addSubview:imgView];
        [button addSubview:label];
        
        [scrollView2 addSubview:button];
    }
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
