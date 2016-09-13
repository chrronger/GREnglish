//
//  UITextField+Extension.h
//  SoundTranslate
//
//  Created by Li on 16/8/18.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
/**
 创建一个textField
 text：文本内容
 clearMode：删除按钮样式
 placeholder：提示输入内容
 */
+ (instancetype)textFieldWithText:(NSString *)text
                  clearButtonMode:(UITextFieldViewMode)clearMode
                      placeholder:(NSString *)placeholder
                             font:(CGFloat)font
                        textColor:(UIColor *)color;


@end
