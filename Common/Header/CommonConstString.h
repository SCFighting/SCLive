//
//  CommonConstString.h
//  SCLive
//
//  Created by SC on 2018/10/26.
//  Copyright © 2018 rayclear. All rights reserved.
//

#ifndef CommonConstString_h
#define CommonConstString_h

#pragma mark - 域名信息
#define DEFAULT_SERVER_ADD                          @"https://api.renrenjiang.cn:443"
#define TXIM_SERVER_ADD                             @"https://stream.renrenjiang.cn/weapp/live_room"

#pragma mark - 用户信息
#define USER_AUTHENTICATION                         @"Authorization"
#define USER_ID                                     @"userID"
#define LOGIN_STYLE                                 @"loginStyle" //(system)邮箱(wechat)微信
#define ACCOUNT                                     @"account"
#define PASSWORLD                                   @"passworld"
#define USER_LEVEL                                  @"user_level"
#define USER_AVATAR                                 @"user_avatar"
#define USER_NICKNAME                               @"user_nickname"

#pragma mark - 接口信息
#define EMAIL_REGIST                                @"/api/v1/sign_up"
#define EMAIL_LOGIN                                 @"/api/v1/sign_in"
#define THIRD_LOGIN                                 @"/api/v1/auth"
#define TXIM_GET_USER_SIGN                          @"/api/v3/users/%ld/get_user_sig"
#define USER_INFO                                   @"/api/v1/users/info"
#define USER_CLASS_LIST                             @"/api/v3/activities/mine"
#define CHOSESERVERSE                               @"/api/v2/services/list"
#define RRJUPLOADIMAGE                              @"/api/v2/server/upload"
#define SYSTERM_SWITCH                              @"/api/v3/system/switch"
#define GET_CREATOR_INFO                            @"/api/v2/users/%ld/extra"
#define PLAY_VIDEO_INFO                             @"/api/v1/videos/info"

#pragma mark -- 来自人人讲

#define MainColor [UIColor colorWithRed:250/255.0 green:93/255.0 blue:92/255.0 alpha:1.0] // red
#define BackgroundColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0] // gray white
#define UINavigationBarColor [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1.0]
#define UINavigationBarTitleColor [UIColor colorWithRed:83.0/255 green:82.0/255 blue:82/255.0 alpha:1.0]
#define ORIGINAL_MAX_WIDTH 640.0f
#define WEAKEN_AS(strong_name, weak_name) __weak typeof(strong_name) weak_name = strong_name
#define WatcherTableViewHeaderHeight                 222
#define LeftPageInsetTop                             100
#define WatcherTableViewHeaderLandscapeHeight_Record ([UIScreen mainScreen].bounds.size.width - 20) /6 + 50


#define CREATE_OR_EDIT_ACTIVITY                      @"/api/v2/activities"
#define RRJ_SET_INVITE_LECTURE_SCALE                 @"/api/v3/activities/%ld/invited_lecturer"
#define RRJUSERCOLUMNCOUNT                           @"/api/v2/users/%ld/column_count"
#define DELETE_MY_CREATE_ACTIVITY                    @"/api/v2/activities/%ld/delete"
#define RRJGETSPECIALCOLUMNDATA                      @"/api/v2/columns"
#define GETSIMPLELECTURELIST                         @"/api/v2/users/lecturers"
#define RRJ_SHOULD_PING_FAYE_SERVICES                @"/api/v3/system/faye_reconnect"
#define VIDEORESOLUTION                              @"/api/v2/activities/%ld/shoot_options"
#define UPDATE_VIDEORESOLUTION                       @"/api/v2/activities/%ld/set_shoot_options"



#endif /* CommonConstString_h */
