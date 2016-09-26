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
