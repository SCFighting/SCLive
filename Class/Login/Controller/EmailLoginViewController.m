//
//  EmailLoginViewController.m
//  SCLivehd
//
//  Created by SC on 2018/6/20.
//  Copyright © 2018年 rayclear. All rights reserved.
//

#import "EmailLoginViewController.h"
#import "HomeViewController.h"
#import "LoginTool.h"
#import "BaseNavigationController.h"

@interface EmailLoginViewController ()
@property (nonatomic , strong ) UIView *containerView;
@property (nonatomic , strong ) UITextField *emailTextFiled;
@property (nonatomic , strong ) UIView *divideLineOneView;
@property (nonatomic , strong ) UITextField *passwordTextFiled;
@property (nonatomic , strong ) UIView *divideLineTwoView;
@property (nonatomic , strong ) UIButton *loginButton;
@property (nonatomic , strong ) LoginTool *loginTool;
@end

@implementation EmailLoginViewController

-(void)loadView
{
    [super loadView];
    [self setupSubviews];
    [self setupSubviewConstaints];
}

-(void)setupSubviews
{
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.emailTextFiled];
    [self.containerView addSubview:self.divideLineOneView];
    [self.containerView addSubview:self.passwordTextFiled];
    [self.containerView addSubview:self.divideLineTwoView];
    [self.containerView addSubview:self.loginButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"登录"];
}

-(void)setupSubviewConstaints
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.right.mas_equalTo(self.view);
        } else {
            // Fallback on earlier versions
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
            make.left.right.mas_equalTo(self.view);
        }
    }];
    
    [self.emailTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.containerView.mas_safeAreaLayoutGuideTop).offset(150);
        } else {
            // Fallback on earlier versions
            make.top.mas_equalTo(self.containerView.mas_top).offset(150);
        }
        make.centerX.equalTo(self.containerView);
        make.size.mas_equalTo(CGSizeMake(300, 44));
    }];
    [self.divideLineOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailTextFiled.mas_bottom);
        make.centerX.equalTo(self.emailTextFiled);
        make.size.mas_equalTo(CGSizeMake(300, 1));
    }];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.emailTextFiled);
        make.top.mas_equalTo(self.divideLineOneView.mas_bottom);
    }];
    [self.divideLineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.divideLineOneView);
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.divideLineTwoView.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(302, 50));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorFromHexString:@"#FFFFFF"]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self.emailTextFiled becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
-(void)loginSysterm
{
    if ([NSString isBlankString:self.emailTextFiled.text]) {
        [MBProgressHUD showWarningInfo:@"请填写邮箱账号"];
        return;
    }
    if ([NSString isBlankString:self.passwordTextFiled.text]) {
        [MBProgressHUD showWarningInfo:@"请填写密码"];
        return;
    }
    [MBProgressHUD showLoadText:@"登录中..."];
    [self.loginTool loginByEmail:self.emailTextFiled.text passWorld:self.passwordTextFiled.text result:^(BOOL result, id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!result&&!responseObject)
        {
            [self handelRequestFailed:error];
        }else
        {
            [self handelRequestSuccess:responseObject shouldcontinue:^(BOOL shouldcontinue) {
                [MBProgressHUD hidenHUD];
                if (shouldcontinue) {
                    [self jumpToHome];
                }
            }];
        }
        
    }];
    [self.view endEditing:YES];
}

-(void)jumpToHome
{
    HomeViewController *home = [[HomeViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:home];
    [[UIApplication sharedApplication].delegate.window setRootViewController:nav];
}

#pragma mark -getter

-(UIView *)containerView
{
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.redColor;
    }
    return _containerView;
}

-(UITextField *)emailTextFiled
{
    if (_emailTextFiled == nil) {
        _emailTextFiled = [[UITextField alloc] init];
        [_emailTextFiled setKeyboardType:UIKeyboardTypeEmailAddress];
        [_emailTextFiled setPlaceholder:@"请输入邮箱"];
        [_emailTextFiled setFont:[UIFont systemFontOfSize:18]];
        _emailTextFiled.autocapitalizationType = NO;
        //文本框左视图
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        leftView.backgroundColor = [UIColor clearColor];
        //添加图片
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9.5, 9.5, 22, 25)];
        [leftImageView setImage:[UIImage imageNamed:@"account"]];
        [leftView addSubview:leftImageView];
        [_emailTextFiled setLeftView:leftView];
        [_emailTextFiled setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _emailTextFiled;
}

-(UIView *)divideLineOneView
{
    if (_divideLineOneView == nil) {
        _divideLineOneView = [[UIView alloc] init];
        [_divideLineOneView setBackgroundColor:[UIColor colorFromHexString:@"#DFDFDF"]];
    }
    return _divideLineOneView;
}

-(UITextField *)passwordTextFiled
{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled = [[UITextField alloc] init];
        [_passwordTextFiled setPlaceholder:@"请输入密码"];
        [_passwordTextFiled setFont:[UIFont systemFontOfSize:18]];
        _passwordTextFiled.autocapitalizationType = NO;
        _passwordTextFiled.secureTextEntry = YES;

        //文本框左视图
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        leftView.backgroundColor = [UIColor clearColor];
        //添加图片
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5, 9.5, 18, 25)];
        [leftImageView setImage:[UIImage imageNamed:@"password"]];
        [leftView addSubview:leftImageView];
        [_passwordTextFiled setLeftView:leftView];
        [_passwordTextFiled setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _passwordTextFiled;
}

-(UIView *)divideLineTwoView
{
    if (_divideLineTwoView == nil) {
        _divideLineTwoView = [[UIView alloc] init];
        [_divideLineTwoView setBackgroundColor:[UIColor colorFromHexString:@"#DFDFDF"]];
    }
    return _divideLineTwoView;
}

-(UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setImage:[UIImage imageNamed:@"systermLogin"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginSysterm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(LoginTool *)loginTool
{
    if (_loginTool == nil) {
        _loginTool = [[LoginTool alloc] init];
    }
    return _loginTool;
}

//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}

@end
