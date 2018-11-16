//
//  LoginTool.h
//  SCLive
//
//  Created by SC on 2018/11/8.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginTool : NSObject

-(void)loginByEmail:(NSString *)email passWorld:(NSString *)passWorld result:(void(^)(BOOL result , id responseObject , NSError * error))result;
-(void)cleanUserInfo;
@end

NS_ASSUME_NONNULL_END
