//
//  GRTextView.m
//  GREnglish
//
//  Created by sen on 2016/9/29.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTextView.h"

@interface GRTextView ()
@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation GRTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self setupUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)setupUI
{
    
}

- (void)textDidChange
{
    
}


@end
