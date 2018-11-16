//
//  UserInfoModel.h
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject
@property (nonatomic  , assign) NSInteger  user_id;
@property (nonatomic  , assign) NSInteger  uid;
@property (nonatomic  ,  copy ) NSString *nickname;
@property (nonatomic  ,  copy ) NSString *displayname;
@property (nonatomic  ,  copy ) NSString *avatar;
@property (nonatomic  ,  copy ) NSString *background;
@property (nonatomic  , assign) NSInteger  point;
@property (nonatomic  ,  copy ) NSString *faye_channel;
@property (nonatomic  ,  copy ) NSString *Description;
@property (nonatomic  ,  copy ) NSString *information;
@property (nonatomic  ,  copy ) NSString *followed;
@property (nonatomic  ,  copy ) NSString *app;
@property (nonatomic  , assign) NSInteger  status;
@property (nonatomic  , assign) NSInteger  code_rate;
@property (nonatomic  , assign) NSInteger  width;
@property (nonatomic  , assign) NSInteger  height;
@property (nonatomic  ,  copy ) NSString *type;
@property (nonatomic  , assign) NSInteger  ignore_status;
@property (nonatomic  , assign) NSInteger  user_level;
@property (nonatomic  , assign) CGFloat  money_virtual;
@property (nonatomic  , assign) NSInteger  fans_count;
@property (nonatomic  , assign) NSInteger  praise_count;
@property (nonatomic  , assign) NSInteger  video_count;
@property (nonatomic  , assign) NSInteger  activities_count;
@property (nonatomic  , assign) NSInteger  idols_count;
@property (nonatomic  , assign) NSInteger  services_count;
@property (nonatomic  , assign) NSInteger  proposal_status;
@property (nonatomic  , assign) NSInteger  member_status;
@property (nonatomic  , assign) CGFloat  member_price;
@property (nonatomic  , assign) BOOL  member_switch;
@property (nonatomic  , assign) BOOL  member_show_switch;
@property (nonatomic  , assign) BOOL  service_center;
@property (nonatomic  ,  copy ) NSString *home_page_url;
@property (nonatomic  ,  copy ) NSString *main_page_url;
@property (nonatomic  , assign) BOOL  scale_switch;
@property (nonatomic  , assign) NSInteger  strict_level;
@property (nonatomic  ,  copy ) NSString *phone;
@end

NS_ASSUME_NONNULL_END
