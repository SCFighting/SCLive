//
//  BaseNavigationController.m
//  SCLive
//
//  Created by SC on 2018/11/7.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController
- (BOOL)shouldAutorotate {
    // 返回当前子控制器 是否支持旋转
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}


@end
