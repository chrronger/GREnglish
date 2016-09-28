//
//  GRBaseLoginViewController.m
//  GREnglish
//
//  Created by sen on 2016/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRBaseLoginViewController.h"

@interface GRBaseLoginViewController ()

@end

@implementation GRBaseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"login_background")];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
