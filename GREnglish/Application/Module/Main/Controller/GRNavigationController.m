//
//  GRNavigationController.m
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRNavigationController.h"

@interface GRNavigationController ()

@end

@implementation GRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavBar];
}

- (void)configNavBar{
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = HEXCOLOR(@"41ca61");
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
//push 修改默认返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"top_navigation_back_normal" selectedImage:@"top_navigation_back_normal" target:self action:@selector(didClickback)];
        
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
   
    [super pushViewController:viewController animated:YES];
    
}
- (void)didClickback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
