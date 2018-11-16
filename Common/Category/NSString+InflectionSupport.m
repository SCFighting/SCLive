//
//  NSString+InflectionSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSString+InflectionSupport.h"

@implementation NSString (InflectionSupport)

- (NSCharacterSet *)capitals {
	return [NSCharacterSet uppercaseLetterCharacterSet];
}

- (NSString *)deCamelizeWith:(NSString *)delimiter {
	
	unichar *buffer = calloc([self length], sizeof(unichar));
	[self getCharacters:buffer ];
	NSMutableString *underscored = [NSMutableString string];
	
	NSString *currChar;
	for (int i = 0; i < [self length]; i++) {
		currChar = [NSString stringWithCharacters:buffer+i length:1];
		if([[self capitals] characterIsMember:buffer[i]]) {
			[underscored appendFormat:@"%@%@", delimiter, [currChar lowercaseString]];
		} else {
			[underscored appendString:currChar];
		}
	}
	
	free(buffer);
	return underscored;
}
	

- (NSString *)dasherize {
	return [self deCamelizeWith:@"-"];
}

- (NSString *)underscore {
	return [self deCamelizeWith:@"_"];
}

- (NSCharacterSet *)camelcaseDelimiters {
	return [NSCharacterSet characterSetWithCharactersInString:@"-_"];
}

- (NSString *)camelize {
	
	unichar *buffer = calloc([self length], sizeof(unichar));
	[self getCharacters:buffer ];
	NSMutableString *underscored = [NSMutableString string];
	
	BOOL capitalizeNext = NO;
	NSCharacterSet *delimiters = [self camelcaseDelimiters];
	for (int i = 0; i < [self length]; i++) {
		NSString *currChar = [NSString stringWithCharacters:buffer+i length:1];
		if([delimiters characterIsMember:buffer[i]]) {
			capitalizeNext = YES;
		} else {
			if(capitalizeNext) {
				[underscored appendString:[currChar uppercaseString]];
				capitalizeNext = NO;
			} else {
				[underscored appendString:currChar];
			}
		}
	}
	
	free(buffer);
	return underscored;
	
}

- (NSString *)titleize {
	NSArray *words = [self componentsSeparatedByString:@" "];
	NSMutableString *output = [NSMutableString string];
	for (NSString *word in words) {
		[output appendString:[[word substringToIndex:1] uppercaseString]];
		[output appendString:[[word substringFromIndex:1] lowercaseString]];
		[output appendString:@" "];
	}
	return [output substringToIndex:[self length]];
}

- (NSString *)toClassName {
	NSString *result = [self camelize];
	return [result stringByReplacingCharactersInRange:NSMakeRange(0,1) 
										 withString:[[result substringWithRange:NSMakeRange(0,1)] uppercaseString]];
}

/**
 *  判断字符串是否为空
 */
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


/**
 * 手机号正则验证
 
 @param mobileNum 手机号
 
 @return 是否是手机号
 */
+ (BOOL)validateMobile:(NSString *)mobileNum{
    NSString * MOBILE = @"^1[3|4|5|7|8|9]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 * 中文正则验证
 
 @param mobileNum
 
 @return 是否是中文
 */
+ (BOOL)validateChiness:(NSString *)str{
    NSString * MOBILE = @"^[\\u4E00-\\u9FFF]+$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 * 校验身份证号码
 
 @param idcardNumber 身份证号
 @return 是否是身份证号
 */
+ (BOOL)validateIDCard:(NSString *)idcardNumber
{
    if (idcardNumber.length == 15)//校验15位
    {
        NSString *isIDCard = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isIDCard];
        if ([regextestmobile evaluateWithObject:idcardNumber] == YES)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }else if (idcardNumber.length == 18)
    {
        NSString *isIDCard = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isIDCard];
        if ([regextestmobile evaluateWithObject:idcardNumber] == YES)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}


/**
 判断一个日期是否是今天
 
 @param date date description
 @return return value description
 */
+ (BOOL)isDateInToday:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}


/**
 判断一个日期是否是昨天
 
 @param date date description
 @return return value description
 */
+ (BOOL)isDateInYesterday:(NSDate *)date
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd"];
    NSTimeInterval dateStar = [[formater dateFromString:[formater stringFromDate:[NSDate date]]] timeIntervalSince1970]; //当前时间开始时间
    NSTimeInterval dateEnd = dateStar - 24 * 60 * 60; //当前时间前一天开始时间
    return ([date timeIntervalSince1970] >= dateEnd && [date timeIntervalSince1970] < dateStar);
}


/**
 判断一个日期是否是明天
 
 @param date date description
 @return return value description
 */
+ (BOOL)isDateInTomorrow:(NSDate *)date
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd"];
    NSTimeInterval dateStar = [[formater dateFromString:[formater stringFromDate:[NSDate date]]] timeIntervalSince1970];//当前时间开始时间
    NSTimeInterval dateEnd = dateStar + 24 * 60 * 60;//当前时间结束时间
    NSTimeInterval nextTimeEnd = dateEnd + 24 * 60 * 60;//当前时间下一天结束时间
    return ([date timeIntervalSince1970] >= dateEnd && [date timeIntervalSince1970] < nextTimeEnd);
}

@end
