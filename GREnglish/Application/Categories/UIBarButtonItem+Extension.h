//
//  UIBarButtonItem+Extension.h
//  SoundTranslate
//
//  Created by CarlXu on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithImage:(NSString *)image
                         selectedImage:(NSString *)selImage
                                target:(id)target
                                action:(SEL)method;

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                        selectImage:(NSString *)selectImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image;





@end
