//
//  GRTextField.m
//  GREnglish
//
//  Created by sen on 2016/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTextField.h"

@implementation GRTextField
+ (void)setTextField:(UITextField *)textField placeholder:(NSString *)placeholder
{
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
@end
