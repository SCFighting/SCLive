//
//  NSString+InflectionSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface NSString (InflectionSupport)

/**
 * Return the dashed form af this camelCase string:
 *
 *   [@"camelCase" dasherize] //> @"camel-case"
 */
- (NSString *)dasherize;

/**
 * Return the underscored form af this camelCase string:
 *
 *   [@"camelCase" underscore] //> @"camel_case"
 */
- (NSString *)underscore;

/**
 * Return the camelCase form af this dashed/underscored string:
 *
 *   [@"camel-case_string" camelize] //> @"camelCaseString"
 */
- (NSString *)camelize;

/**
 * Return a copy of the string suitable for displaying in a title. Each word is downcased, with the first letter upcased.
 */
- (NSString *)titleize;

/**
 * Return a copy of the string with the first letter capitalized.
 */
- (NSString *)toClassName;

+ (BOOL) isBlankString:(NSString *)string;
/**
 * 校验身份证号码
 
 @param idcardNumber 身份证号
 @return 是否是身份证号
 */
+ (BOOL)validateIDCard:(NSString *)idcardNumber;

/**
 * 手机号正则验证
 
 @param mobileNum 手机号
 
 @return 是否是手机号
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/**
 * 中文正则验证
 
 @param mobileNum
 
 @return 是否是中文
 */
+ (BOOL)validateChiness:(NSString *)str;

/**
 判断一个日期是否是今天

 @param date date description
 @return return value description
 */
+ (BOOL)isDateInToday:(NSDate *)date;


/**
 判断一个日期是否是昨天

 @param date date description
 @return return value description
 */
+ (BOOL)isDateInYesterday:(NSDate *)date;


/**
 判断一个日期是否是明天

 @param date date description
 @return return value description
 */
+ (BOOL)isDateInTomorrow:(NSDate *)date;

@end
