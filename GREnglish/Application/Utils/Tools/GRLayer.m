//
//  GRLayer.m
//  GREnglish
//
//  Created by sen on 2016/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRLayer.h"

@implementation GRLayer

+ (void)setLayerOval:(CALayer *)layer
{
    layer.cornerRadius = 22;
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
