//
//  BaseViewController.h
//  SCLive
//
//  Created by SC on 2018/11/7.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoDataView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic , strong ) NoDataView *tipView;
-(void)handelRequestSuccess:(id)responseObject shouldcontinue:(void(^)(BOOL shouldcontinue))shouldcontinue;
-(void)handelRequestFailed:(NSError *)error;
-(void)addDefaultView:(UIView *)view title:(NSString *)title imageName:(nullable NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
