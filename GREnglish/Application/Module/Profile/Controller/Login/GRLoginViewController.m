
//
//  GRLoginViewController.m
//  GREnglish
//
//  Created by sen on 2016/9/26.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRLoginViewController.h"
#import "GRRegisterViewController.h"
#import "GRLayer.h"
#import "GRTextField.h"
#import "GRForgotPswViewController.h"

@interface GRLoginViewController ()<UITextFieldDelegate,GRRegisterViewControllerDelegate>
{
    
}
@property(nonatomic,strong)UIButton *closeButton; //关闭按钮
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)UIView *userNameView;
@property(nonatomic,strong)UIView *pswView;
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *psw;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *registe;
@property(nonatomic,strong)UIButton *forgotPsw;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIButton *qqLogin;
@property(nonatomic,strong)UIButton *weiboLogin;
@end

@implementation GRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //username:tttttt psw:111111
    
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - keyboard notification
- (void)keyBoardWillShow:(NSNotification *)notification
{
    CGFloat beginHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat endHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if (beginHeight >0 && endHeight > 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -endHeight+(SCREEN_HEIGHT-CGRectGetMaxY(self.loginButton.frame))-10);
        }];
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)setupUI
{
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.titleImage];
    [self.view addSubview:self.userNameView];
    [self.view addSubview:self.pswView];
    [self.userNameView addSubview:self.userName];
    [self.pswView addSubview:self.psw];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.registe];
    [self.view addSubview:self.forgotPsw];
    [self.view addSubview:self.qqLogin];
    [self.view addSubview:self.weiboLogin];
}

#pragma mark - lazy
- (UIButton *)closeButton
{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(5, 20, 44, 44);
        [_closeButton setImage:IMAGE(@"top_navigation_close") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(didClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIImageView *)titleImage
{
    if (_titleImage == nil) {
        _titleImage = [[UIImageView alloc]initWithImage:IMAGE(@"Welcome")];
        _titleImage.frame = CGRectMake((SCREEN_WIDTH-_titleImage.frame.size.width)/2, (SCREEN_HEIGHT-437), 180, 35);
    }
    return _titleImage;
}

- (UIView *)userNameView
{
    if (_userNameView == nil) {
        _userNameView = [[UIView alloc]initWithFrame:CGRectMake(30,CGRectGetMaxY(self.titleImage.frame)+40 ,(SCREEN_WIDTH-60) ,44 )];
//        _userNameView.layer.borderColor = [UIColor whiteColor].CGColor;
//        _userNameView.layer.borderWidth = 0.5;
//        _userNameView.layer.cornerRadius = 22;
//        _userNameView.layer.masksToBounds = YES;
        [GRLayer setLayerOval:_userNameView.layer];
        
    }
    return _userNameView;
}

- (UIView *)pswView
{
    if (_pswView == nil) {
        _pswView = [[UIView alloc]initWithFrame:CGRectMake(30,CGRectGetMaxY(self.userNameView.frame)+20 , (SCREEN_WIDTH-60),44 )];
//        _pswView.layer.borderColor = [UIColor whiteColor].CGColor;
//        _pswView.layer.borderWidth = 0.5;
//        _pswView.layer.cornerRadius = 22;
        [GRLayer setLayerOval:_pswView.layer];
    }
    return _pswView;
}

- (UITextField *)userName
{
    if (_userName == nil) {
        _userName = [[UITextField alloc]initWithFrame:CGRectMake(20, 0,CGRectGetWidth(self.userNameView.frame)-40 , 44)];
//        _userName.placeholder = @"用户名／邮箱／手机号";
//        _userName.textAlignment = NSTextAlignmentCenter;
//        _userName.returnKeyType = UIReturnKeyDone;
//        
//        _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        [GRTextField setTextField:_userName placeholder:@"用户名／邮箱／手机号"];
        _userName.delegate = self;
        [_userName addTarget:self action:@selector(didTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userName;
}

- (UITextField *)psw
{
    if (_psw == nil) {
        _psw = [[UITextField alloc]initWithFrame:CGRectMake(20, 0,CGRectGetWidth(self.pswView.frame)-40 , 44)];
        
        _psw.keyboardType = UIKeyboardTypeASCIICapable;
//        _psw.placeholder = @"密码";
//        _psw.returnKeyType = UIReturnKeyDone;
//        _psw.textAlignment = NSTextAlignmentCenter;
//        
//        _psw.clearButtonMode = UITextFieldViewModeWhileEditing;
        [GRTextField setTextField:_psw placeholder:@"密码"];
        _psw.delegate = self;
        _psw.secureTextEntry = YES;
         [_psw addTarget:self action:@selector(didTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _psw;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.frame = CGRectMake(30, CGRectGetMaxY(self.pswView.frame)+20,(SCREEN_WIDTH-60) , 44);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = FONT(16);
        _loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_loginButton addTarget:self action:@selector(didLogin) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.backgroundColor = HEXCOLOR(@"6d8579");
        _loginButton.layer.cornerRadius = 22;
        
        _loginButton.enabled = NO;
    }
    return _loginButton;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-1)/2, (SCREEN_HEIGHT-150), 1, 20)];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UIButton *)registe
{
    if (_registe == nil) {
        _registe = [UIButton buttonWithType:UIButtonTypeCustom];
        _registe.size = CGSizeMake(70, 28);
        _registe.center = CGPointMake((SCREEN_WIDTH-41-_registe.frame.size.width)/2, self.lineView.centerY);
        [_registe setTitle:@"现在注册->" forState:UIControlStateNormal];
        [_registe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registe.titleLabel.font = FONT(13);
        [_registe addTarget:self action:@selector(didRegiste) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registe;
}
- (UIButton *)forgotPsw
{
    if (_forgotPsw == nil) {
        _forgotPsw = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgotPsw.size = CGSizeMake(70, 28);
        _forgotPsw.center = CGPointMake((SCREEN_WIDTH-41-self.registe.frame.origin.x), self.lineView.centerY);
        [_forgotPsw setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgotPsw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _forgotPsw.titleLabel.font = FONT(13);
        [_forgotPsw addTarget:self action:@selector(didForgotPsw) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotPsw;
}

- (UIButton *)qqLogin
{
    if (_qqLogin == nil) {
        _qqLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqLogin.size =CGSizeMake(40, 40);
        _qqLogin.center = CGPointMake(self.registe.centerX, CGRectGetMaxY(self.registe.frame)+40);
        
        [_qqLogin setImage:IMAGE(@"account_snslogin_icon_1") forState:UIControlStateNormal];
        
    }
    return _qqLogin;
}

- (UIButton *)weiboLogin
{
    if (!_weiboLogin) {
        _weiboLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiboLogin.size =CGSizeMake(40, 40);
        _weiboLogin.center = CGPointMake(self.forgotPsw.centerX, CGRectGetMaxY(self.forgotPsw.frame)+40);
        
        [_weiboLogin setImage:IMAGE(@"account_snslogin_icon_3") forState:UIControlStateNormal];
    }
    return _weiboLogin;
}

#pragma mark - action

- (void)didLogin
{
    [self.view endEditing:YES];
    [Hud showTipsText:@"正在登录"];
    
    [GRAccountModel loginAccountWithType:@"username" username:self.userName.text psw:self.psw.text resultBlock:^(NSDictionary *data, NSError *error) {
        if ([data[@"status"] isEqualToString:@"success"]) {
            [Hud hideHubAfterTime:0];
            [self didClose];
            //保存
            writeToPlist((@{@"username":self.userName.text,@"psw":self.psw.text}));
            
            
        }else{
            [Hud hideHubAfterTime:0];
            [Hud showTipsText:data[@"message"]];
        }
    }];
    
}

- (void)didRegiste
{
    GRRegisterViewController *registerVC = [[GRRegisterViewController alloc]init];
    registerVC.delegate = self;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)didForgotPsw
{
    [self.navigationController pushViewController:[[GRForgotPswViewController alloc]init] animated:YES];
}

- (void)didClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTextChanged:(UITextField *)textField
{
    if (self.userName.text.length >= 5 && self.psw.text.length >5) {
        self.loginButton.enabled = YES;
        self.loginButton.backgroundColor = HEXCOLOR(@"00ac59");
    }else{
        self.loginButton.enabled = NO;
        self.loginButton.backgroundColor = HEXCOLOR(@"6d8579");
    }
}


#pragma mark -textField - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.psw]) {
        [self didLogin];
    }
    
    return YES;
}

#pragma mark -GRRegisterVC - delegate
//注册成功后
- (void)registerSuccessWithUsername:(NSString *)username psw:(NSString *)psw
{
    self.userName.text = username;
    self.psw.text = psw;
    [self didTextChanged:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self didLogin];
    });
    
}

#pragma mark - remove notification
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
