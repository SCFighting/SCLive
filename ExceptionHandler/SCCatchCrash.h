//
//  SCCatchCrash.h
//  SCLive
//
//  Created by SC on 2018/10/27.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCCatchCrash : NSObject
//注册异常捕获
void RegisterExceptionHandler(void);
void DeleteCrashInfo(void);
@end

NS_ASSUME_NONNULL_END
