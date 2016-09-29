//
//  InPutView.h
//  SoundTranslate
//
//  Created by CarlXu on 16/8/24.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InPutViewDelegate <NSObject>

- (void)inPutViewDidSendMsg:(NSString *)message;

@end

typedef void(^SendMsgBlock)(NSString *);

@interface InPutView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) SendMsgBlock sendMsgBlock;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSString *prompt;
@property (nonatomic, assign) id<InPutViewDelegate>delegate;

- (void)riseKeyBoard;
- (void)getDownKeyBoard;
@end
