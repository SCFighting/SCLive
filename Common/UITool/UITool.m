//
//  UITool.m
//  SCLive
//
//  Created by SC on 2018/11/9.
//  Copyright © 2018 rayclear. All rights reserved.
//

#import "UITool.h"
static UITool *_tool;
@implementation UITool

#pragma mark - privateFunction

/**
 创建一个UIImageView

 @param imageName 图片名称 nil 不设置图片
 @param cornerRadius 圆角半径 小于0不设置
 @return UIImageView
 */
-(UIImageView *)createImageView:(nullable NSString * )imageName cornerRadius:(CGFloat)cornerRadius
{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (![NSString isBlankString:imageName])
    {
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    if (cornerRadius > 0)
    {
        [imageView.layer setCornerRadius:cornerRadius];
        [imageView setClipsToBounds:YES];
    }
    return imageView;
}

/**
 创建一个UILabel

 @param text  label文字
 @param textColor 文字颜色
 @param font 字体
 @param textAlignment 对齐方式
 @param numberOfLine 行数
 @return  label
 */
-(UILabel *)createLabel:(nullable NSString *)text textColor:(nullable UIColor *)textColor font:(nullable UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLine:(NSInteger)numberOfLine
{
    UILabel *label = [[UILabel alloc] init];
    if (![NSString isBlankString:text])
    {
        [label setText:text];
    }
    if (textColor) {
        [label setTextColor:textColor];
    }
    if (font)
    {
        [label setFont:font];
    }
    if (textAlignment >= 0)
    {
        [label setTextAlignment:textAlignment];
    }
    if (numberOfLine >= 0) {
        [label setNumberOfLines:numberOfLine];
    }
    return label;
}

/**
 创建一个UIView

 @param backgroundColor 背景色
 @param cornerRadius 圆角半径
 @return  view
 */
-(UIView *)createView:(nullable UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius
{
    UIView *view = [[UIView alloc] init];
    if (backgroundColor)
    {
        [view setBackgroundColor:backgroundColor];
    }
    if (cornerRadius >= 0) {
        [view.layer setCornerRadius:cornerRadius];
        [view setClipsToBounds:YES];
    }
    return view;
}


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
-(UIButton *)createButton:(nullable NSString *)normalTitle highlightTitle:(nullable NSString *)highlightTitle disablTitle:(nullable NSString *)disablTitle selectTitle:(nullable NSString *)selectTitle normalColor:(nullable UIColor *)normalColor highlightColor:(nullable UIColor *)highlightColor disablColor:(nullable UIColor *)disablColor selectColor:(nullable UIColor *)selectColor font:(nullable UIFont *)font backgroundColor:(nullable UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius
{
    UIButton *button = [[UIButton alloc] init];
    if (![NSString isBlankString:normalTitle])
    {
        [button setTitle:normalTitle forState:UIControlStateNormal];
    }
    if (![NSString isBlankString:highlightTitle])
    {
        [button setTitle:highlightTitle forState:UIControlStateHighlighted];
    }
    if (![NSString isBlankString:disablTitle])
    {
        [button setTitle:disablTitle forState:UIControlStateDisabled];
    }
    if (![NSString isBlankString:selectTitle])
    {
        [button setTitle:selectTitle forState:UIControlStateSelected];
    }

    if (normalColor)
    {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (highlightColor)
    {
        [button setTitleColor:highlightColor forState:UIControlStateHighlighted];
    }
    if (disablColor)
    {
        [button setTitleColor:disablColor forState:UIControlStateDisabled];
    }
    if (selectColor)
    {
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }

    if (font) {
        [button.titleLabel setFont:font];
    }

    if (backgroundColor) {
        [button setBackgroundColor:backgroundColor];
    }

    if (cornerRadius >= 0) {
        [button.layer setCornerRadius:cornerRadius];
        [button setClipsToBounds:YES];
    }
    return button;
}

#pragma mark - 系统方法
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [super allocWithZone:zone];
    });
    return _tool;
}

+(instancetype)shareTool
{
    return [[self alloc] init];
}

-(id)copyWithZone:(NSZone *)zone
{
    return _tool;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _tool;
}

@end
