//
//  GRForgotPswViewController.m
//  GREnglish
//
//  Created by sen on 2016/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRForgotPswViewController.h"
#import "GRLayer.h"
#import "GRTextField.h"

@interface GRForgotPswViewController ()
{
    CGFloat _width;
}

@property(nonatomic,strong)UIButton *back;
@property(nonatomic,strong)UIView *userNameView;
@property(nonatomic,strong)UIView *emailView;
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *email;
@property(nonatomic,strong)UIButton *findPsw;
@end

@implementation GRForgotPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _width = SCREEN_WIDTH-60;
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat beginHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat endHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if (beginHeight >0 && endHeight > 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -endHeight+(SCREEN_HEIGHT-CGRectGetMaxY(self.findPsw.frame))-10);
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)setupUI
{
    [self.view addSubview:self.back];
    [self.view addSubview:self.userNameView];
    [self.view addSubview:self.emailView];
    [self.userNameView addSubview:self.userName];
    [self.emailView addSubview:self.email];
    [self.view addSubview:self.findPsw];
}

#pragma mark - lazy
- (UIButton *)back
{
    if (_back == nil ) {
        _back = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
        [_back setImage:IMAGE(@"top_navigation_back_normal") forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _back;
}

- (UIButton *)findPsw
{
    if (_findPsw == nil) {
        _findPsw = [[UIButton alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT-150, _width, 44)];
        _findPsw.layer.cornerRadius = 22;
        
        _findPsw.backgroundColor = HEXCOLOR(@"6d8579");
        [_findPsw setTitle:@"找回密码" forState:UIControlStateNormal];
        [_findPsw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_findPsw setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
        _findPsw.titleLabel.font = FONT(16);
        _findPsw.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_findPsw addTarget:self action:@selector(didFindPsw) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findPsw;
}


- (UIView *)emailView
{
    if (_emailView == nil) {
        _emailView = [[UIView alloc]initWithFrame:CGRectMake(30,CGRectGetMinY(self.findPsw.frame)-64 , _width, 44)];
        [GRLayer setLayerOval:_emailView.layer];
    }
    return _emailView;
}

- (UIView *)userNameView
{
    if (_userNameView == nil) {
        _userNameView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(self.emailView.frame)-64, _width, 44)];
        [GRLayer setLayerOval:_userNameView.layer];
    }
    return _userNameView;
}

- (UITextField *)email
{
    if (_email == nil) {
        _email = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.emailView.frame)-40, 44)];
        _email.keyboardType = UIKeyboardTypeASCIICapable;
        [GRTextField setTextField:_email placeholder:@"邮箱"];
    }
    return _email;
}

- (UITextField *)userName
{
    if (_userName == nil) {
        _userName = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.userNameView.frame)-40, 44)];
        _userName.keyboardType = UIKeyboardTypeASCIICapable;
        [GRTextField setTextField:_userName placeholder:@"密码"];
    }
    return _userName;
    
}


#pragma mark -action

- (void)didFindPsw
{
    
}

- (void)didBack
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
