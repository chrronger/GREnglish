
//
//  HomeHeaderView.m
//  
//
//  Created by Waki on 16/9/27.
//
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()<UIScrollViewDelegate>

@end
@implementation HomeHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViewWithArray1:nil array2:nil];
    }
    return self;
}

- (void)setupViewWithArray1:(NSArray *)source1Array array2:(NSArray *)source2Array{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).widthIs(SCREEN_WIDTH);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*source1Array.count, 100);
    scrollView.pagingEnabled  = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
//    UIScrollView *scrollView2 = [UIScrollView alloc] initWithFrame:<#(CGRect)#>
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
