//
//  GRTabBar.h
//  GREnglish
//
//  Created by sen on 16/9/13.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRTabBarDelegate <UITabBarDelegate>

@optional
- (void)didAddButtonClick:(UIButton *)button;

@end

@interface GRTabBar : UITabBar

@property(nonatomic,assign)id <GRTabBarDelegate>tabdelegate;

@end
