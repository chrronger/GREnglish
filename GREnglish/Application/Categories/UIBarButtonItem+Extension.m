//
//  UIBarButtonItem+Extension.m
//  SoundTranslate
//
//  Created by CarlXu on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithImage:(NSString *)image selectedImage:(NSString *)selImage target:(id)target action:(SEL)method
{
    UIButton *btn = [UIButton buttonWithNormalImage:image selectImage:selImage imageType:btnImgTypeFull target:target action:method];
    btn.size = btn.currentImage.size;
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                     selectImage:(NSString *)selectImage
{
    UIButton *btn = ({
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (image) {
            [itemBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }
        if (selectImage) {
            [itemBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        }
        
        [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        itemBtn;
    });
    btn.size = btn.currentImage.size;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
{
    return [self itemWithTarget:target action:action image:image selectImage:nil];
}

@end
