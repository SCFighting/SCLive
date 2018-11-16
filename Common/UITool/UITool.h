//
//  UITool.h
//  SCLive
//
//  Created by SC on 2018/11/9.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UITOOL_NEGATIVE_NUMBER -1
NS_ASSUME_NONNULL_BEGIN

@interface UITool : NSObject

/**
 创建一个UIImageView
 
 @param imageName 图片名称 nil 不设置图片
 @param cornerRadius 圆角半径 小于0不设置
 @return UIImageView
 */
-(UIImageView *)createImageView:(nullable NSString *)imageName cornerRadius:(CGFloat)cornerRadius;


/**
 创建一个UILabel

 @param text  label文字
 @param textColor 文字颜色
 @param font 字体
 @param textAlignment 对齐方式
 @param numberOfLine 行数
 @return  label
 */
-(UILabel *)createLabel:(nullable NSString *)text textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLine:(NSInteger)numberOfLine;

/**
 创建一个UIView

 @param backgroundColor 背景色
 @param cornerRadius 圆角半径
 @return  view
 */
-(UIView *)createView:(nullable UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

/**
 创建一个UIButton

 @param normalTitle normalTitle description
 @param highlightTitle highlightTitle description
 @param disablTitle disablTitle description
 @param selectTitle selectTitle description
 @param normalColor normalColor description
 @param highlightColor highlightColor description
 @param disablColor disablColor description
 @param selectColor selectColor description
 @param font font description
 @param backgroundColor backgroundColor description
 @param cornerRadius cornerRadius description
 @return return value description
 */
-(UIButton *)createButton:(nullable NSString *)normalTitle highlightTitle:(nullable NSString *)highlightTitle disablTitle:(nullable NSString *)disablTitle selectTitle:(nullable NSString *)selectTitle normalColor:(nullable UIColor *)normalColor highlightColor:(nullable UIColor *)highlightColor disablColor:(nullable UIColor *)disablColor selectColor:(nullable UIColor *)selectColor font:(nullable UIFont *)font backgroundColor:(nullable UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

/**
 单例
 */
+(instancetype)shareTool;
@end

NS_ASSUME_NONNULL_END
