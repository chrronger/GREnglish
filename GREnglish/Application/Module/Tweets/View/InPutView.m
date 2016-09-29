//
//  InPutView.m
//  SoundTranslate
//
//  Created by CarlXu on 16/8/24.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "InPutView.h"

#define kTextViewHeight 30
#define bgViewHeight 40
#define kLeftMargin 15
#define kBtnWH 30

#define screenWidth SCREEN_BOUNDS.size.width
#define SCREEN_HEIGHT SCREEN_BOUNDS.size.height

@implementation InPutView
{
    NSInteger curRow;
    NSInteger realRow;
    CGRect orginalFrame;
    CGFloat oneRowHeight;
    CGFloat topSpace;
    CGFloat riseY;
    UIButton *emjiBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupInPutViewInfo];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return self;
}

- (void)setupInPutViewInfo
{
    curRow = 1;
    orginalFrame = self.frame;
    oneRowHeight = [self.prompt getHeightWithLimitWidth:screenWidth fontSize:17];//单行文本高度
    topSpace = (kTextViewHeight-oneRowHeight)/2;
    self.backgroundColor = RGBColor(230, 230, 230, 1);
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kLeftMargin,(bgViewHeight-kTextViewHeight)/2,screenWidth-2*kLeftMargin-kBtnWH*1.2, kTextViewHeight)];
    self.textView.delegate = self;
    self.textView.contentOffset = CGPointMake(0, topSpace);
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor blackColor];
    self.prompt = @"请输入评论内容";
    self.textView.text = self.prompt;
    self.textView.delegate = self;
    [self.textView configBorderWidth:1 borderColor:UIColorFromRGB(0xffffff) cornerRadius:5];
    [self addSubview:self.textView];
    
    emjiBtn = [UIButton buttonWithNormalImage:@"emotion_btn_icon" selectImage:@"keyboard_btn_icon" imageType:btnImgTypeFull target:self action:@selector(clickEmjiBtn:)];
    emjiBtn.frame = CGRectMake(SCREEN_WIDTH-kBtnWH-kLeftMargin, (bgViewHeight-kBtnWH)/2, kBtnWH, kBtnWH);
    [self addSubview:emjiBtn];
}

- (void)changeFrame:(NSNotification *)notify
{
    NSDictionary *userInfo = [notify userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;  // 得到键盘弹出后的键盘视图所在y坐标
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        riseY = keyBoardEndY - self.height -64;
        self.y = keyBoardEndY - self.height -64;//(60是键盘上文字高度)
        // keyBoardEndY的坐标包括了状态栏的高度，要减去
    }];
   
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.isOpen = YES;
    textView.text = nil;
    [textView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    float textWidth = [textView.text getWidthWithLimitHeight:self.textView.height fontSize:17];
    realRow = ceilf(textWidth/self.textView.width); //计算当前文字长度对应的行数
    if (realRow == 0 || realRow > 2) {//限制textView最多显示3行
        return;
    }
    if(realRow > curRow)
    {
        //如果发现当前文字长度对应的行数超过。 文本框高度，则先调整当前view的高度和位置，然后调整输入框的高度，最后修改currentLineNum的值
        self.frame = CGRectMake(0, self.y-oneRowHeight*(realRow-curRow), screenWidth, self.height+oneRowHeight*(realRow-curRow));
        textView.frame = CGRectMake(kLeftMargin, topSpace, textView.width, textView.height+oneRowHeight*(realRow-curRow));
        [textView scrollRectToVisible:CGRectMake(0, (realRow-curRow)*oneRowHeight + topSpace, textView.width, textView.height) animated:NO];
        curRow = realRow;
    }else if (realRow < curRow )
    {
        //次数为删除的时候检测文字行数减少的时候
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+oneRowHeight*(curRow-realRow), self.frame.size.width, self.frame.size.height-oneRowHeight*(curRow-realRow));
        textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, textView.frame.size.height-oneRowHeight*(curRow-realRow));
        curRow = realRow;
    }
}

- (BOOL)textView:(UITextView *) textView  shouldChangeTextInRange: (NSRange) range replacementText: (NSString *)text {
    if([@"\n" isEqualToString: text])
    {
        //你的响应方法
        if (self.sendMsgBlock) {
            self.sendMsgBlock(textView.text);
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(inPutViewDidSendMsg:)]) {
            [self.delegate inPutViewDidSendMsg:textView.text];
        }
        self.isOpen = NO;
        [self.textView resignFirstResponder];
        self.textView.text = self.prompt;
        self.textView.frame = CGRectMake(kLeftMargin,(bgViewHeight-kTextViewHeight)/2,screenWidth-2*kLeftMargin-kBtnWH*1.2, kTextViewHeight);
        self.frame = orginalFrame;
        curRow = 1;
        return NO;
    }
    return YES;
}

- (void)getDownKeyBoard
{
    [self.textView resignFirstResponder];
    self.isOpen = NO;
    self.textView.text = self.prompt;
    self.textView.frame = CGRectMake(kLeftMargin,(bgViewHeight-kTextViewHeight)/2,screenWidth-2*kLeftMargin-kBtnWH*1.2, kTextViewHeight);
    self.frame = orginalFrame;
    curRow = 1;
}

- (void)riseKeyBoard
{
    [self.textView becomeFirstResponder];
    self.isOpen = YES;
    self.textView.text = self.prompt;
}

- (void)clickEmjiBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
