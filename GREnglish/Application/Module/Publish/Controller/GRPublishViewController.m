//
//  GRPublishViewController.m
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRPublishViewController.h"

@interface GRPublishViewController ()

@end

@implementation GRPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)config
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"来一发";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(didSend)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.95 green:0.98 blue:1 alpha:1]} forState:UIControlStateNormal];
    
    
}

#pragma mark - action
- (void)didCancel
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSend
{
    
}

- (void)keyBoardWillChangeFrame:(NSNotification *)notification
{
    
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
