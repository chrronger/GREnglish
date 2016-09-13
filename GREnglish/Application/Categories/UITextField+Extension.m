//
//  UITextField+Extension.m
//  SoundTranslate
//
//  Created by Li on 16/8/18.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension) 

+ (instancetype)textFieldWithText:(NSString *)text
                  clearButtonMode:(UITextFieldViewMode)clearMode
                      placeholder:(NSString *)placeholder
                             font:(CGFloat)font
                        textColor:(UIColor *)color
{
    UITextField *textField = [[UITextField alloc] init];
    textField.text = text;
    textField.clearButtonMode = clearMode;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:font];
    textField.textColor = color;
    return textField;
}

@end
