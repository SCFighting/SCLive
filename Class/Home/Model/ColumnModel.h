//
//  ColumnModel.h
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColumnModel : NSObject
@property (nonatomic  , assign) NSInteger  column_id;
@property (nonatomic  ,  copy ) NSString *title;
@property (nonatomic  , assign) NSInteger  activities_count;
@property (nonatomic  , assign) NSInteger  ctype;
@property (nonatomic  , assign) NSInteger  max_subscription;
@property (nonatomic  , assign) NSInteger  subscriptions;
@end

NS_ASSUME_NONNULL_END
