//
//  LoginViewController.m
//  SCLive
//
//  Created by SC on 2018/11/7.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "LoginViewController.h"
#import "EmailLoginViewController.h"
#import "LoginTool.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
@interface LoginViewController ()
@property (nonatomic , strong ) LoginTool *loginTool;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[NSUserDefaults standardUserDefaults] integerForKey:USER_ID] > 0)
    {
        [MBProgressHUD showLoadText:@"登录中..."];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_STYLE] isEqualToString:@"system"]) //邮箱自动登录
        {
            [self.loginTool loginByEmail:[[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT] passWorld:[[NSUserDefaults standardUserDefaults] objectForKey:PASSWORLD] result:^(BOOL result, id  _Nonnull responseObject, NSError * _Nonnull error) {
                if (!result&&!responseObject)
                {
                    [self handelRequestFailed:error];
                    [self.loginTool cleanUserInfo];
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
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_STYLE] isEqualToString:@"wechat"]) //微信自动登录
        {
            
        }else //登录信息出错,清除登录信息手动登录
        {
            [self.loginTool cleanUserInfo];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    EmailLoginViewController *vc = [[EmailLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark privateFunction

-(void)jumpToHome
{
    HomeViewController *home = [[HomeViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:home];
    [[UIApplication sharedApplication].delegate.window setRootViewController:nav];
}

#pragma mark - getter

-(LoginTool *)loginTool
{
    if (_loginTool == nil) {
        _loginTool = [[LoginTool alloc] init];
    }
    return _loginTool;
}

@end
