//
//  Hub.m
//  SoundTranslate
//
//  Created by CarlXu on 16/8/29.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "Hud.h"

#define kHudTag 10000
#define kBezelViewWidth 300
#define kBezelViewHeigh 200
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@implementation Hud

+ (void)showActivityIndicator
{
    [Hud showHubWithModel:MBProgressHUDModeIndeterminate text:nil customView:nil during:0 userInteractionEnabled:NO];
}

+ (void)showTipsText:(NSString *)text
{
    [Hud showHubWithModel:MBProgressHUDModeText text:text customView:nil during:0.5 userInteractionEnabled:YES];
}

+ (void)showProgress:(MBProgressHUDMode)progressStyle
{
    [Hud showHubWithModel:progressStyle text:@"加载中..." customView:nil during:0 userInteractionEnabled:YES];
}

+ (void)showCustomView:(UIView *)view
{
    [Hud showHubWithModel:MBProgressHUDModeCustomView text:nil customView:view during:0 userInteractionEnabled:YES];
}

+ (void)showHubWithModel:(MBProgressHUDMode)hubModel text:(NSString *)text customView:(UIView *)view during:(CGFloat)second userInteractionEnabled:(BOOL)enabled;
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.tag = kHudTag;
    hud.defaultMotionEffectsEnabled = YES;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = hubModel;
//    hud.bezelView.backgroundColor = UIColorFromRGB(0x505050);改背景颜色属性
    if (enabled)
    {
        hud.frame = CGRectMake((screenWidth-kBezelViewWidth)/2, (screenHeight-kBezelViewHeigh)/2, kBezelViewWidth, kBezelViewHeigh);
    }
   
    switch (hud.mode)
    {
        case MBProgressHUDModeIndeterminate://菊花
            break;
        case MBProgressHUDModeDeterminate://实线圆形进度条
        {
//            for (UIView *subView in hud.bezelView.subviews) {
//                if ([subView isKindOfClass:[MBRoundProgressView class]]) {
//                    MBRoundProgressView *pgsView = (MBRoundProgressView *)subView;
//                    pgsView.progressTintColor = [UIColor redColor];
//                    break;
//                }
//            }
            hud.label.text = @"加载中...";
        }
            break;
        case MBProgressHUDModeDeterminateHorizontalBar://水平进度条
        {
            
            hud.label.text = @"加载中...";
        }
            break;
        case MBProgressHUDModeAnnularDeterminate://圆形进度条--进度由暗淡变实
        {
            hud.label.text = @"加载中...";
        }
            break;
        case MBProgressHUDModeCustomView://自定义
        {
            hud.customView = view;
        }
            break;
        case MBProgressHUDModeText://只显示文本
        {
             hud.label.text = text;
        }
            break;
        default:
            break;
    }
    if (second > 0) {
        [hud hideAnimated:NO afterDelay:second];
    }
}

+ (void)hideHubAfterTime:(CGFloat)second
{
   UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (second > 0) {
        sleep(second);
    }
   [MBProgressHUD hideHUDForView:window animated:NO];
}


+ (void)setHudProgress:(CGFloat)progress
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    MBProgressHUD *hud = [window viewWithTag:kHudTag];
    if (hud.mode == MBProgressHUDModeIndeterminate || hud.mode == MBProgressHUDModeText || hud.mode == MBProgressHUDModeCustomView) {
        return;
    }
    hud.progress = progress/100.0;
    if (hud.progress >= 1) {
        [hud hideAnimated:YES];
    }
}

@end
