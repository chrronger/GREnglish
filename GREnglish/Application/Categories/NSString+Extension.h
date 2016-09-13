//
//  NSString+Verify.h


//  Copyright © 2016年 SmileForever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**验证是不是QQ号码*/
- (BOOL) isQQ;

/**验证是不是手机号码*/
- (BOOL) isPhone;

/**验证是不是邮箱*/
- (BOOL) isEmail;

/**
 *  根据字符串限定宽度和字体大小来返回高度
 *
 *  @param width 限定宽度
 *  @param size  字体大小
 *
 *  @return 高度
 */
- (CGFloat)getHeightWithLimitWidth:(CGFloat)width fontSize:(CGFloat)size;

/**
 *  根据字符串限定高度和字体大小来返回宽度
 *
 *  @param Height 限定高度
 *  @param size   字体大小
 *
 *  @return 宽度
 */
- (CGFloat)getWidthWithLimitHeight:(CGFloat)Height fontSize:(CGFloat)size;

@end
