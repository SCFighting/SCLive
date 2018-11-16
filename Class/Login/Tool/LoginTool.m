//
//  LoginTool.m
//  SCLive
//
//  Created by SC on 2018/11/8.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "LoginTool.h"
#import <sys/utsname.h>
@implementation LoginTool

-(void)loginByEmail:(NSString *)email passWorld:(NSString *)passWorld result:(void(^)(BOOL result , id responseObject , NSError * error))result
{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    if (![NSString isBlankString:email]) {
        [dataDictionary setObject:email forKey:@"user[email]"];
    }
    if (![NSString isBlankString:passWorld]) {
        [dataDictionary setObject:passWorld forKey:@"user[password]"];
    }
    [dataDictionary setObject:@"apple-SCLive" forKey:@"platform"];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *phoneModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    [dataDictionary setObject:phoneVersion forKey:@"os_vision"];
    [dataDictionary setObject:phoneModel forKey:@"mobile_type"];
    [dataDictionary setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    
    [HttpInterface LoginByParameters:dataDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSDictionary *secure_params = [responseObject objectForKey:@"secure_params"];
        if ([secure_params isKindOfClass:[NSDictionary class]] && secure_params.count > 0 && [[secure_params objectForKey:@"u"] integerValue] > 0)
        {
            [[NSUserDefaults standardUserDefaults] setInteger:[[secure_params objectForKey:@"u"] integerValue] forKey:USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:[secure_params objectForKey:@"token"] forKey:USER_AUTHENTICATION];
            [[NSUserDefaults standardUserDefaults] setObject:@"system" forKey:LOGIN_STYLE];
            [[NSUserDefaults standardUserDefaults] setObject:email forKey:ACCOUNT];
            [[NSUserDefaults standardUserDefaults] setObject:passWorld forKey:PASSWORLD];
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"user_info"] objectForKey:@"avatar"] forKey:USER_AVATAR];
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"user_info"] objectForKey:@"nickname"] forKey:USER_NICKNAME];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[[[responseObject objectForKey:@"user_info"] objectForKey:@"user_level"] intValue]] forKey:USER_LEVEL];
            result(YES,responseObject,nil);
        }else
        {
            result(NO,responseObject,nil);
        }
    } failed:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(NO,nil,error);
    }];
}

-(void)cleanUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_AUTHENTICATION];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_STYLE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ACCOUNT];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSWORLD];
}

@end
