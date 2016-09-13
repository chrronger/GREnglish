//
//  NSString+Extension.m
//  SoundTranslate
//
//  Created by CarlXu on 16/8/19.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


/**验证是不是QQ号码*/
//匹配QQ号码,匹配规则:全部是都是数字,第一个字符非0,长度为(6~11)
- (BOOL) isQQ {
    
    NSString *pattern = @"^[1-9]\\d{5,10}$";
    return [self matchWithPattern:pattern];
}


//  手机号码的匹配
//  匹配手机号码,匹配规则:以0或86或空开头,后面第一个数字为"1",当第二数字为 "3,5,8" 第三个数字为"0-9",当第二数字为"7" 第三个数字为"6或7或8",当第二个数字为"4"时,第三个数字为"5或7",手机号码位数为11位.
- (BOOL) isPhone {
    NSString *pattern = @"^(0|86)?1([358]\\d|7[678]|4[57])\\d{8}$";
    return [self matchWithPattern:pattern];
}

//  邮箱匹配：
- (BOOL) isEmail{
    NSString  *pattern = @"^[a-z0-9]+([\\._\\-]*[a-z0-9])*@([a-z0-9]+\\-*[a-z0-9]+\\.){1,63}[a-z0-9]+$";
    return [self matchWithPattern:pattern];
}

//匹配字符串

- (BOOL) matchWithPattern:(NSString *) pattern {
    NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        NSLog(@"创建正则表达式失败%@",error);
        return NO;
    }
    
    //  匹配
    NSTextCheckingResult *results  = [regularExpression firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (results) {
        return YES;
    }else {
        return NO;
    }
}

- (CGFloat)getHeightWithLimitWidth:(CGFloat)width fontSize:(CGFloat)size
{
    UIFont *font = [UIFont systemFontOfSize:size];
    NSDictionary *attrs = @{NSFontAttributeName :font};
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
}

- (CGFloat)getWidthWithLimitHeight:(CGFloat)Height fontSize:(CGFloat)size
{
    UIFont *font = [UIFont systemFontOfSize:size];
    NSDictionary *attrs = @{NSFontAttributeName :font};
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}

@end
