//
//  UIView+Frame.h
//  Coding_iOS
//
//  Created by pan Shiyu on 15/7/16.
//  Copyright (c) 2015年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

/**
 *  定制视图的边框和圆角
 *
 *  @param width  边框宽度
 *  @param color  边框颜色
 *  @param radius 圆角弧度
 */
- (void)configBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius;
@end