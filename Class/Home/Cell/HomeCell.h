//
//  HomeCell.h
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivityModel;

@protocol HandelCellAction <NSObject>

-(void)handelAction:(ActivityModel *)activitimodel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell
@property (nonatomic , strong ) ActivityModel *activityModel;
@property (nonatomic  ,  weak ) id<HandelCellAction> delegate;
@end

NS_ASSUME_NONNULL_END
