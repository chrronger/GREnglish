//
//  GRTabBarViewController.m
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTabBarViewController.h"
#import "GRNavigationController.h"
#import "GRHomeViewController.h"
#import "GRTweetsViewController.h"
#import "GRProfileViewController.h"
#import "GRGrammarViewController.h"
#import "GRPublishViewController.h"
#import "GRTabBar.h"

@interface GRTabBarViewController () <GRTabBarDelegate>

@end

@implementation GRTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GRTabBar *tabBar = [[GRTabBar alloc]init];
    tabBar.delegate = self;
    tabBar.barTintColor = HEXCOLOR(@"41ca61");
    [self setValue:tabBar forKey:@"tabBar"];
    
    [self addChildControllers];
}

- (void)addChildControllers
{
    [self addChildController:[[GRHomeViewController alloc]init] title:@"首页" imageStr:@"tabbar_video_icon_normal" selectedImage:@"tabbar_video_icon_selected"];
    [self addChildController:[[GRGrammarViewController alloc]init] title:@"手册" imageStr:@"tabbar_grammar_icon_normal" selectedImage:@"tabbar_grammar_icon_selected"];
    [self addChildController:[[GRTweetsViewController alloc]init] title:@"动态" imageStr:@"tabbar_trends_icon_normal" selectedImage:@"tabbar_trends_icon_selected"];
    [self addChildController:[[GRProfileViewController alloc]init] title:@"我的" imageStr:@"tab_profile_icon_normal" selectedImage:@"tab_profile_icon_selected"];
    
    self.selectedIndex = 0;
    
}

- (void)addChildController:(UIViewController *)childController title:(NSString *)title imageStr:(NSString *)imageStr selectedImage:(NSString *)selectedImage
{
    childController.title = title;
    childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    childController.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   
    [childController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    GRNavigationController *nav = [[GRNavigationController alloc]initWithRootViewController:childController];
    
    [self addChildViewController:nav];
    
    
    
}

- (void)didAddButtonClick:(UIButton *)button
{
    
    [self presentViewController:[[GRPublishViewController alloc]init] animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
