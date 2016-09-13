//
//  Hub.h
//  SoundTranslate
//
//  Created by CarlXu on 16/8/29.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Hud : NSObject

/**
 *  菊花转圈
 */
+ (void)showActivityIndicator;

/**
 *  文本提示
 *
 *  @param text 文字内容
 */
+ (void)showTipsText:(NSString *)text;

/**
 *  显示进展进度
 *
 *  @param progressStyle 进度条样式:
 */
+ (void)showProgress:(MBProgressHUDMode)progressStyle;

/**
 *  自定义的View
 *
 *  @param view 
 */
+ (void)showCustomView:(UIView *)view;

/**
 *  设置进度,注意赋给hud的进度取值范围是0~1.
 *
 *  @param progress 进度
 */
+ (void)setHudProgress:(CGFloat)progress;

/**
 *  多少秒后隐藏
 *
 *  @param second 秒数
 */
+ (void)hideHubAfterTime:(CGFloat)second;

/**
 *  底层实现方法
 *
 *  @param hubModel 样式
 *  @param text     文字
 *  @param view     自定义视图
 *  @param second   秒数:传0表示不自动消失
 *  @param enabled  展示期间其他界面是否可以交互
 */
+ (void)showHubWithModel:(MBProgressHUDMode)hubModel text:(NSString *)text customView:(UIView *)view during:(CGFloat)second userInteractionEnabled:(BOOL)enabled;
@end
