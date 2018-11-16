//
//  MBProgressHUD+showWarning.h
//  SCLive
//
//  Created by SC on 2018/11/8.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (showWarning)

/**
 展示 3s 错误信息

 @param warningInfo warningInfo description
 */
+ (void)showWarningInfo:(NSString *)warningInfo;

/**
 展示加载
 */
+ (void)showLoadStatus;

/**
 展示加载文字

 @param text text description
 */
+ (void)showLoadText:(NSString *)text;

+ (void)hidenHUD;
@end

NS_ASSUME_NONNULL_END
