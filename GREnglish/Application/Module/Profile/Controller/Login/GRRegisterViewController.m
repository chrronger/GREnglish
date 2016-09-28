//
//  GRRegisterViewController.m
//  GREnglish
//
//  Created by sen on 2016/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRRegisterViewController.h"
#import "GRLayer.h"
#import "GRTextField.h"

@interface GRRegisterViewController ()<UITextFieldDelegate>
{
    CGFloat _width;
}
@property(nonatomic,strong)UIButton *back;
@property(nonatomic,strong)UIView *userNameView;
@property(nonatomic,strong)UIView *pswView;
@property(nonatomic,strong)UIView *pswAgainView;
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *psw;
@property(nonatomic,strong)UIButton *registe;
@property(nonatomic,strong)UITextField *pswAgain;



@end

@implementation GRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     self.view.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"login_background")];
    
     _width = SCREEN_WIDTH-60;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setupUI];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:YES];
//}

#pragma mark - Keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat beginHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat endHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if (beginHeight >0 && endHeight > 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -endHeight+(SCREEN_HEIGHT-CGRectGetMaxY(self.registe.frame))-10);
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
    [self.view addSubview:self.registe];
    [self.view addSubview:self.pswAgainView];
    [self.view addSubview:self.userNameView];
    [self.view addSubview:self.pswView];
    [self.userNameView addSubview:self.userName];
    [self.pswView addSubview:self.psw];
    [self.pswAgainView addSubview:self.pswAgain];
}

#pragma mark -lazy
- (UIButton *)back
{
    if (_back == nil ) {
        _back = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
        [_back setImage:IMAGE(@"top_navigation_back_normal") forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _back;
}

- (UIButton *)registe
{
    if (_registe == nil) {
        _registe = [[UIButton alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT-150, _width, 44)];
        _registe.layer.cornerRadius = 22;
        
        _registe.backgroundColor = HEXCOLOR(@"6d8579");
        [_registe setTitle:@"注册" forState:UIControlStateNormal];
        [_registe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registe setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
        _registe.titleLabel.font = FONT(16);
        _registe.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_registe addTarget:self action:@selector(didRegister) forControlEvents:UIControlEventTouchUpInside];
        
        _registe.enabled = NO;
    }
    return _registe;
}

- (UIView *)pswAgainView
{
    if (_pswAgainView == nil) {
        _pswAgainView = [[UIView alloc]initWithFrame:CGRectMake(30,CGRectGetMinY(self.registe.frame)-64 , _width, 44)];
        [GRLayer setLayerOval:_pswAgainView.layer];
    }
    return _pswAgainView;
}

- (UIView *)pswView
{
    if (_pswView == nil) {
        _pswView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(self.pswAgainView.frame)-64, _width, 44)];
        [GRLayer setLayerOval:_pswView.layer];
    }
    return _pswView;
}

- (UIView *)userNameView
{
    if (_userNameView == nil) {
        _userNameView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(self.pswView.frame)-64, _width, 44)];
        [GRLayer setLayerOval:_userNameView.layer];
    }
    return _userNameView;
}

- (UITextField *)pswAgain
{
    if (_pswAgain == nil) {
        _pswAgain = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.pswAgainView.frame)-40, 44)];
        _pswAgain.keyboardType = UIKeyboardTypeASCIICapable;
        [GRTextField setTextField:_pswAgain placeholder:@"再次输入密码"];
        [_pswAgain addTarget:self action:@selector(didTextChanged:) forControlEvents:UIControlEventEditingChanged];
        _pswAgain.delegate = self;
        _pswAgain.secureTextEntry = YES;
    }
    return _pswAgain;
}

- (UITextField *)psw
{
    if (_psw == nil) {
        _psw = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.pswView.frame)-40, 44)];
        _psw.keyboardType = UIKeyboardTypeASCIICapable;
        [GRTextField setTextField:_psw placeholder:@"密码"];
        [_psw addTarget:self action:@selector(didTextChanged:) forControlEvents:UIControlEventEditingChanged];
        _psw.delegate = self;
        _psw.secureTextEntry = YES;
    }
    return _psw;
    
}

- (UITextField *)userName
{
    if (_userName == nil) {
        _userName = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.userNameView.frame)-40, 44)];
        [GRTextField setTextField:_userName placeholder:@"用户名"];
        [_userName addTarget:self action:@selector(didTextChanged:) forControlEvents:UIControlEventEditingChanged];
        _userName.delegate = self;
    }
    return _userName;
}

#pragma mark -action
- (void)didRegister
{
    [self.view endEditing:YES];
    
    if (self.psw.text != self.pswAgain.text) {
        [Hud showTipsText:@"两次输入密码不一致"];
        return;
    }
    
    [Hud showActivityIndicator];
    
    [GRAccountModel registerAccountWithType:@"username" username:self.userName.text psw:self.psw.text resultBlock:^(NSDictionary *data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"success"]) {
            [Hud hideHubAfterTime:0];
            [Hud showTipsText:@"注册成功"];
            
            [self didBack];
           
            if ([self.delegate respondsToSelector:@selector(registerSuccessWithUsername:psw:)]) {
                [self.delegate registerSuccessWithUsername:self.userName.text psw:self.psw.text];
            }
            
            
        }else{
            [Hud hideHubAfterTime:3];
            [Hud showTipsText:data[@"message"]];
        }
    }];
    
}

- (void)didTextChanged:(UITextField *)textField
{
    if (self.userName.text.length >=5 && self.psw.text.length >5 && self.pswAgain.text.length >5) {
        self.registe.enabled = YES;
        self.registe.backgroundColor = HEXCOLOR(@"00ac59");
    }else{
        self.registe.enabled = NO;
        self.registe.backgroundColor = HEXCOLOR(@"6d8579");
    }
}

- (void)didBack
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -textField - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.pswAgain]) {
         [self didRegister];
    }
   
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
