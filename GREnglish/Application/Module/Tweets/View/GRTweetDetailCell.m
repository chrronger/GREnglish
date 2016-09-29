
//
//  GRTweetDetailCell.m
//  GREnglish
//
//  Created by CarlXu on 16/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetDetailCell.h"
#import "UIButton+WebCache.h"

@implementation GRTweetDetailCell
{
    UIButton *iconBtn;
    UILabel *nameLabel;
    UIImageView *genderImgView;
    UILabel *timeLabel;
    UILabel *contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconBtn configBorderWidth:0.1 borderColor:UIColorFromRGB(0x000000) cornerRadius:20];
    
    nameLabel = [UILabel labelWithText:nil fontSize:17 textColor:UIColorFromRGB(0x000000) alignment:NSTextAlignmentLeft];
    
    genderImgView = [[UIImageView alloc] init];
    
    timeLabel = [UILabel labelWithText:nil fontSize:13 textColor:UIColorFromRGB(0x505050) alignment:NSTextAlignmentLeft];
    
    contentLabel = [UILabel labelWithText:nil fontSize:13 textColor:UIColorFromRGB(0x505050) alignment:NSTextAlignmentLeft];
    contentLabel.numberOfLines = 0;

    NSArray *views = @[iconBtn,nameLabel,genderImgView,timeLabel,contentLabel];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    iconBtn.sd_layout.leftSpaceToView(contentView, margin).topSpaceToView(contentView,margin).widthIs(40).heightIs(40);
    nameLabel.sd_layout.leftSpaceToView(iconBtn, margin).topEqualToView(iconBtn).heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    genderImgView.sd_layout.leftSpaceToView(nameLabel,5).centerYEqualToView(nameLabel).heightIs(12).widthIs(12);
    
    timeLabel.sd_layout.leftEqualToView(nameLabel).topSpaceToView(nameLabel,5).heightIs(15);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    contentLabel.sd_layout.leftEqualToView(iconBtn).topSpaceToView(iconBtn, margin).rightSpaceToView(contentView, margin).autoHeightRatio(0);
}

- (void)setModel:(GRTweetCommentModel *)model
{
    _model = model;
    [iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.author.avatar] forState:UIControlStateNormal];
    nameLabel.text = model.author.nickname;
    genderImgView.image =  [UIImage imageNamed:@"girl_dongtai"];
    timeLabel.text = model.publishTime;
    contentLabel.text = model.content;
    [self setupAutoHeightWithBottomView:contentLabel bottomMargin:15];
}

@end
