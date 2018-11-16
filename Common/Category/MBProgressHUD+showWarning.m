//
//  MBProgressHUD+showWarning.m
//  SCLive
//
//  Created by SC on 2018/11/8.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "MBProgressHUD+showWarning.h"

@implementation MBProgressHUD (showWarning)

/**
 展示加载
 */
+ (void)showLoadStatus
{
    if ([[NSThread currentThread] isMainThread])
    {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.userInteractionEnabled = NO;
        [hud setMargin:10];
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
            hud.userInteractionEnabled = NO;
            [hud setMargin:10];
        });
    }
    
}

/**
 展示加载文字
 
 @param text text description
 */
+ (void)showLoadText:(NSString *)text
{
    if ([[NSThread currentThread] isMainThread])
    {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.userInteractionEnabled = NO;
        [hud.label setText:text];
        [hud setMargin:10];
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
            hud.userInteractionEnabled = NO;
            [hud.label setText:text];
            [hud setMargin:10];
        });
    }
    
}

/**
 展示错误信息
 
 @param warningInfo warning description
 */
+ (void)showWarningInfo:(NSString *)warningInfo
{
    if ([[NSThread currentThread] isMainThread])
    {
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.userInteractionEnabled = NO;
        [hud setMode:MBProgressHUDModeText];
        [hud.detailsLabel setText:warningInfo];
        [hud.detailsLabel setNumberOfLines:0];
        [hud.bezelView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        [hud setMargin:10];
        [hud hideAnimated:YES afterDelay:3.0f];
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
            hud.userInteractionEnabled = NO;
            [hud setMode:MBProgressHUDModeText];
            [hud.detailsLabel setNumberOfLines:0];
            [hud.detailsLabel setText:warningInfo];
            [hud.bezelView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
            [hud setMargin:10];
            [hud hideAnimated:YES afterDelay:3.0f];
        });
    }
}

+ (void)hidenHUD
{
    if ([[NSThread currentThread] isMainThread])
    {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        });
    }
}

@end
