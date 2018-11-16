//
//  BaseViewController.m
//  SCLive
//
//  Created by SC on 2018/11/7.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)loadView
{
    [super loadView];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]];
    [self.view setBackgroundColor:[UIColor colorFromHexString:@"F4F4F4"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dealloc
{
    NSLog(@"控制器[%@ dealloc]释放",NSStringFromClass([self class]));
}

// 是否支持设备自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持屏幕显示方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - commonFunction

-(void)handelRequestSuccess:(id)responseObject shouldcontinue:(void(^)(BOOL shouldcontinue))shouldcontinue
{
    [MBProgressHUD hidenHUD];
    if ([responseObject isKindOfClass:[NSDictionary class]] && [[responseObject objectForKey:@"result"] isEqualToString:@"fail"])
    {
        [MBProgressHUD showWarningInfo:[responseObject objectForKey:@"message"]];
        shouldcontinue(NO);
    }else if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        shouldcontinue(YES);
    }
    else
    {
        shouldcontinue(NO);
    }
}

-(void)handelRequestFailed:(NSError *)error
{
    [MBProgressHUD showWarningInfo:error.localizedDescription];
}

-(void)addDefaultView:(UIView *)view title:(NSString *)title imageName:(nullable NSString *)imageName;
{
    self.tipView = [[NoDataView alloc] initWithTitle:title imageTitle:imageName];
    [view addSubview:self.tipView];
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
    }];
    [self.tipView setHidden:YES];
}


#pragma mark - IM

- (void)addTapBlankToHideKeyboardGesture;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlankToHideKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)onTapBlankToHideKeyboard:(UITapGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }
}

- (void)addIMListener
{
    
}


- (void)callImagePickerActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    actionSheet.cancelButtonIndex = 2;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

@end
