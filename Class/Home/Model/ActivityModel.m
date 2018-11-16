//
//  ActivityModel.m
//  SCLive
//
//  Created by SC on 2018/11/10.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"Description":@"description"};
}
@end
