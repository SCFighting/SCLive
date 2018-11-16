//
//  CreatorModel.h
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreatorModel : NSObject
@property (nonatomic  , assign) NSInteger  user_id;
@property (nonatomic  , assign) NSInteger  uid;
@property (nonatomic  ,  copy ) NSString *nickname;
@property (nonatomic  ,  copy ) NSString *displayname;
@property (nonatomic  ,  copy ) NSString *Description;
@property (nonatomic  ,  copy ) NSString *avatar;
@property (nonatomic  ,  copy ) NSString *background;
@property (nonatomic  ,  copy ) NSString *channel_name;
@property (nonatomic  , assign) NSInteger  user_level;
@property (nonatomic  , assign) NSInteger  proposal_status;
@property (nonatomic  , assign) NSInteger  fans_count;
@end

NS_ASSUME_NONNULL_END
