

//
//  GRHomeCell.m
//  GREnglish
//
//  Created by Waki on 16/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRHomeCell.h"
#import "GRVideoModel.h"
#import "UIImageView+WebCache.h"

@interface GRHomeCell ()
{
//    UIButton * _button1;
//    UIImageView * _imgView1;
//    UILabel * _contentLabel1;
//    
//    UIButton * _button2;
//    UIImageView * _imgView2;
//    UILabel * _contentLabel2;
}

@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIImageView *imgView1;
@property (strong, nonatomic) UILabel *contentLabel1;

@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIImageView *imgView2;
@property (strong, nonatomic) UILabel *contentLabel2;

@end
@implementation GRHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CGFloat buttonWidth = (SCREEN_WIDTH-30)/2;
    CGFloat buttonHeight = 375.0/750*buttonWidth +40;
    
    for (int index = 0; index < 2; index++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(10+(10+buttonWidth)*index, 0, buttonWidth, buttonHeight);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight-40)];
        UILabel *label = [UILabel labelWithText:nil fontSize:12 textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        label.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame), button.width, 40);
        label.numberOfLines = 2;
        [button addSubview:label];
        [button addSubview:imgView];
        
        if (index == 0) {
            _button1 = button;
            _imgView1 = imgView;
            _contentLabel1 = label;
        }else{
            _button2 = button;
            _imgView2 = imgView;
            _contentLabel2 = label;
        }
    }
    
    [self.contentView  addSubview:_button1];
    [self.contentView addSubview:_button2];
}

- (void)layoutCellWithVideoModelArray:(NSArray *)videoArray{
    for (int i = 0; i < videoArray.count; i++) {
        GRVideoModel *model = videoArray[i];
        if (i == 0) {
            [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model.cover]];
            _contentLabel1.text = model.title;
        }else{
            [_imgView2 sd_setImageWithURL:[NSURL URLWithString:model.cover]];
            _contentLabel2.text = model.title;
        }
    }
}

//- (UIButton *)getBgButtonWithIndex:(NSInteger)index model:(GRVideoModel *)model{
//    CGFloat buttonWidth = (SCREEN_WIDTH-30)/2;
//    CGFloat buttonHeight = 375.0/750*buttonWidth +30;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake((10+buttonWidth)*index, buttonHeight, buttonWidth, buttonHeight);
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth-30)];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
//    UILabel *label = [UILabel labelWithText:model.title fontSize:13 textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
//    label.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame), button.width, 30);
//    [button addSubview:label];
//    button.backgroundColor = [UIColor redColor];
//    return button;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
