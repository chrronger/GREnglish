//
//  UIButton+Extension.m
//  SoundTranslate
//
//  Created by CarlXu on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIView+Frame.h"

@implementation UIButton (Extension)

+ (instancetype)buttonWithTitle:(NSString *)title titleFont:(CGFloat)size titleColor:(UIColor *)color target:(id)target action:(SEL)method
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    [btn addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)buttonWithNormalImage:(NSString *)image selectImage:(NSString *)selImage imageType:(ButtonImageType)imageType target:(id)target action:(SEL)method
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn configButtonNormalImage:image selectImage:selImage imageType:imageType];
    [btn addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)configButtonNormalImage:(NSString *)image selectImage:(NSString *)selImage imageType:(ButtonImageType)imageType
{
    if (imageType == btnImgTypeSmall)
    {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        if (selImage) {
            [self setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
        }
    } else
    {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        if (selImage) {
            [self setBackgroundImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
        }
    }
}
- (void)configButtonTitleColor:(UIColor *)color selectTitleColor:(UIColor *)selColor backgroundColor:(UIColor *)bgColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:selColor forState:UIControlStateSelected];
    [self setBackgroundColor:bgColor];
}

- (void)configButtonTitle:(NSString *)title fontSize:(CGFloat)size titleColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    [self setTitleColor:color forState:UIControlStateNormal];
}
@end
