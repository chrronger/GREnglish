//
//  UILabel+Extension.h
//  SoundTranslate
//
//  Created by CarlXu on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  创建一个带标题的label
 *
 *  @param text      文本内容
 *  @param size      字体尺寸
 *  @param color     文本颜色
 *  @param alignment 文本对齐方式
 *
 *  @return label对象
 */
+ (instancetype)labelWithText:(NSString *)text
                     fontSize:(CGFloat)size
                    textColor:(UIColor *)color
                    alignment:(NSTextAlignment)alignment;

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title fontSize:(NSInteger)size;
@end
