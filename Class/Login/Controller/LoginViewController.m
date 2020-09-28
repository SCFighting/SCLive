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
//
    [self jumpToHome];
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
