//
//  InPutView.h
//  SoundTranslate
//
//  Created by CarlXu on 16/8/24.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendMsgBlock)(NSString *);

@interface InPutView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) SendMsgBlock sendMsgBlock;

- (void)hideKeyBoard;

@end
