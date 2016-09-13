//
//  UIButton+Extension.h
//  SoundTranslate
//
//  Created by CarlXu on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonImageType){
    btnImgTypeSmall,
    btnImgTypeFull
};

@interface UIButton (Extension)

/**
 *  创建一个只带标题的button
 *
 *  @param title  标题
 *  @param size   字号
 *  @param color  标题颜色
 *  @param target 目标对象
 *  @param method 点击方法
 *
 *  @return button
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleFont:(CGFloat)size titleColor:(UIColor *)color target:(id)target action:(SEL)method;

/**
 *  创建一个只带图片的button
 *
 *  @param image     正常状态下图片
 *  @param selImage  选中状态下图片
 *  @param imageType 图片类型:背景图/小图
 *  @param target    目标对象
 *  @param method    点击方法
 *
 *  @return button
 */
+ (instancetype)buttonWithNormalImage:(NSString *)image selectImage:(NSString *)selImage imageType:(ButtonImageType)imageType target:(id)target action:(SEL)method;

/**
 *  定制按钮的图片
 *
 *  @param image     图片名称
 *  @param selImage  选中状态下图片名
 *  @param imageType 图片类型:背景图/小图
 */
- (void)configButtonNormalImage:(NSString *)image selectImage:(NSString *)selImage imageType:(ButtonImageType)imageType;

/**
 *  定制按钮的标题颜色和背景颜色
 *
 *  @param color    正常状态下颜色
 *  @param selColor 选中状态下颜色
 *  @param bgColor  背景颜色
 */
- (void)configButtonTitleColor:(UIColor *)color selectTitleColor:(UIColor *)selColor backgroundColor:(UIColor *)bgColor;

/**
 *  设置按钮的标题,字体颜色,字体大小
 *
 *  @param title 标题
 *  @param size  字体大小
 *  @param color 字体颜色
 */
- (void)configButtonTitle:(NSString *)title fontSize:(CGFloat)size titleColor:(UIColor *)color;



@end
