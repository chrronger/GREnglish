//
//  UILabel+Extension.m
//  SoundTranslate
//
//  Created by CarlXu on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelWithText:(NSString *)text fontSize:(CGFloat)size textColor:(UIColor *)color alignment:(NSTextAlignment)alignment;
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = alignment;
    return label;
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title fontSize:(NSInteger)size
{
    self.frame = CGRectMake(0, 0, width, 0);
    self.text = title;
    self.font = [UIFont systemFontOfSize:size];
    self.numberOfLines = 0;
    [self sizeToFit];
    CGFloat height = self.frame.size.height;
    return height;
}

@end
