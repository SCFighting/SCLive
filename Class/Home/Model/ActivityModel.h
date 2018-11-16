//
//  ActivityModel.h
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreatorModel.h"
#import "ColumnModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActivityModel : NSObject
@property (nonatomic  , assign) NSInteger  ID;
@property (nonatomic  ,  copy ) NSString *title;
@property (nonatomic  ,  copy ) NSString *status;
@property (nonatomic  , assign) NSInteger  video_status;
@property (nonatomic  ,  copy ) NSString *background;
@property (nonatomic  ,  copy ) NSString *password;
@property (nonatomic  , assign) NSInteger  started_at;
@property (nonatomic  , assign) BOOL  charge;
@property (nonatomic  , assign) CGFloat  price;
@property (nonatomic  , assign) NSInteger  reservation_count;
@property (nonatomic  , assign) BOOL  reservation;
@property (nonatomic  , assign) NSInteger  user_id;
@property (nonatomic , strong ) CreatorModel *creator;
@property (nonatomic  , assign) NSInteger  column_id;
@property (nonatomic , strong ) ColumnModel *column;
@property (nonatomic  , assign) BOOL  isinvited;
@property (nonatomic  , assign) BOOL  locked;
@property (nonatomic  ,  copy ) NSString *share_url;
@property (nonatomic  ,  copy ) NSString *Description;
@property (nonatomic  , assign) NSInteger  popularity;
@property (nonatomic  ,  copy ) NSString *media_type;
@property (nonatomic  ,  copy ) NSString *rtype;
@property (nonatomic  ,  copy ) NSString *group;
@property (nonatomic  , assign) CGFloat  share_scale;
@property (nonatomic  , assign) NSInteger  share_amount;
@property (nonatomic  , assign) BOOL  visible;
@property (nonatomic  , assign) NSInteger  acm_id;
@property (nonatomic  ,  copy ) NSString *position;
@property (nonatomic  ,  copy ) NSString *task;
@property (nonatomic  , assign) NSInteger  stopped_at;
@property (nonatomic  , assign) NSInteger  verify_way;
@property (nonatomic  ,  copy ) NSString *shop_link;
@property (nonatomic  ,  copy ) NSString *qrcode;
@property (nonatomic  , assign) NSInteger  service_id;
@property (nonatomic  ,  copy ) NSString *service_title;
@property (nonatomic  ,  copy ) NSString *user_nickname;
@property (nonatomic  ,  copy ) NSString *user_avatar;
@property (nonatomic  ,  copy ) NSString *user_information;
@property (nonatomic  ,  copy ) NSString *user_description;
@property (nonatomic  , assign) BOOL  horizontal;
@end

NS_ASSUME_NONNULL_END
