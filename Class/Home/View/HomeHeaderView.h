//
//  HomeHeaderView.h
//  SCLive
//
//  Created by SC on 2018/11/9.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfoModel;
@protocol HandelHeaderAction <NSObject>
/**
 设置
 */
-(void)setting;

/**
 创建课程
 */
-(void)createClass;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderView : UIView
@property (nonatomic , strong ) UserInfoModel *userInfoModel;
@property (nonatomic  ,  weak ) id<HandelHeaderAction> delegate;
@end

NS_ASSUME_NONNULL_END
