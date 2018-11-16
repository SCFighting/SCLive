//
//  BaseAppDelegate.m
//  SCLive
//
//  Created by SC on 2018/10/27.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "BaseAppDelegate.h"
#import "SCCatchCrash.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "BaseNavigationController.h"
#import "LoginViewController.h"
@interface BaseAppDelegate()<MFMailComposeViewControllerDelegate>
@end

@implementation BaseAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configRootViewController];
    [self configNavigationBarStyle];
    [self configKeyboardManager];
    [self configExceptionHandler];
    return YES;
}

#pragma mark - privateFunction

-(void)configRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorFromHexString:@"FFFFFF"];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}

-(void)configNavigationBarStyle
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexString:@"FFFFFF"]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorFromHexString:@"000000"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexString:@"202020"],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

-(void)configKeyboardManager
{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}

#pragma mark - ExceptionHandler

-(void)configExceptionHandler
{
    RegisterExceptionHandler();
    
    // 发送崩溃日志
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    if (data != nil && DEBUG && [MFMailComposeViewController canSendMail]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"bug反馈" message:@"是否反馈给开发人员" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendExceptionLogWithData:data path:dataPath];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            DeleteCrashInfo();
        }]];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark -- 发送崩溃日志
- (void)sendExceptionLogWithData:(NSData *)data path:(NSString *)path {
    
    MFMailComposeViewController *mailSender = [[MFMailComposeViewController alloc]init];
    mailSender.mailComposeDelegate = self;
    [mailSender setSubject:@"bug"];
    [mailSender setToRecipients:@[@"sunweichao@rayclear.com"]];
    //以下为具体业务代码
    data = [NSData dataWithContentsOfFile:path];//文件数据
    NSString *extension = @"TXT";//文件类型识别字符串，如文件扩展名
    NSString *mimeType = nil;//这个不能错，错了的话会闪退
    if ([extension isEqualToString:@"MOV"] || [extension isEqualToString:@"MP4"]) {
        mimeType = @"video/quicktime";
    }else if ([extension isEqualToString:@"MP3"] || [extension isEqualToString:@"M4A"]) {
        mimeType = @"audio/mpeg3";
    }else if ([extension isEqualToString:@"JPG"] || [extension isEqualToString:@"JPEG"]) {
        mimeType = @"image/jpeg";
    }else if ([extension isEqualToString:@"PNG"]) {
        mimeType = @"image/png";
    }else if ([extension isEqualToString:@"TXT"]) {
        mimeType = @"text/plain";
    }else if ([extension isEqualToString:@"PDF"]) {
        mimeType = @"application/pdf";
    }else if ([extension isEqualToString:@"DOC"] || [extension isEqualToString:@"DOCX"]) {
        mimeType = @"application/msword";
    }else if ([extension isEqualToString:@"XLS"] || [extension isEqualToString:@"XLSX"]) {
        mimeType = @"application/vnd.ms-exceld";
    }else if ([extension isEqualToString:@"PPT"] || [extension isEqualToString:@"PPTX"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    }else if ([extension isEqualToString:@"ZIP"]) {
        mimeType = @"application/zip";
    }else{
        return ;
    }
    [mailSender addAttachmentData:data mimeType:mimeType fileName:@"Exception"];
    [self.window.rootViewController presentViewController:mailSender animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultCancelled:
        {
        }
            break;
        case MFMailComposeResultSaved:
        {
        }
            break;
        case MFMailComposeResultSent:
        {
            NSLog(@"发送成功");
            DeleteCrashInfo();
        }
            break;
        case MFMailComposeResultFailed:
        {
        }
            break;
    }
}

@end
