//
//  GRTweetListCell.m
//  GREnglish
//
//  Created by CarlXu on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetListCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIButton+WebCache.h"

@implementation GRTweetListCell
{
    UIButton *iconBtn;
    UILabel *nameLabel;
    UIImageView *genderImgView;
    UILabel *timeLabel;
    UILabel *contentLabel;
    SDWeiXinPhotoContainerView *picContainerView;//图片内容
    UILabel *deviceLabel;
    UIButton *likeBtn;
    UIButton *commonBtn;
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
    
    picContainerView = [SDWeiXinPhotoContainerView new];

    deviceLabel = [UILabel labelWithText:nil fontSize:13 textColor:UIColorFromRGB(0x505050) alignment:NSTextAlignmentLeft];
    
    likeBtn = [UIButton buttonWithNormalImage:@"star_icon_normal" selectImage:@"dongtai_yizan" imageType:btnImgTypeSmall target:self action:@selector(clickLike:)];
    
    commonBtn = [UIButton buttonWithNormalImage:@"comment_icon" selectImage:nil imageType:btnImgTypeSmall target:self action:@selector(clickCommont:)];
    
    NSArray *views = @[iconBtn,nameLabel,genderImgView,timeLabel,contentLabel,picContainerView,deviceLabel,likeBtn,commonBtn];
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
    
    picContainerView.sd_layout.leftEqualToView(iconBtn);

    deviceLabel.sd_layout.leftEqualToView(iconBtn).topSpaceToView(picContainerView, 5).heightIs(15);
    [deviceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    commonBtn.sd_layout.rightSpaceToView(self.contentView, 10).topEqualToView(deviceLabel).widthIs(60).heightIs(15);
    likeBtn.sd_layout.topEqualToView(commonBtn).rightSpaceToView(commonBtn,10).widthIs(60).heightIs(15);

}

- (void)setModel:(GRTweetListModel *)model
{
    if (![model isKindOfClass:[GRTweetListModel class]]) {
        return;
    }
    _model = model;
    [iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.author.avatar] forState:UIControlStateNormal];
    nameLabel.text = model.author.nickname;
    genderImgView.image = (model.author.sex > 0) ? [UIImage imageNamed:@"boy_dongtai"] : [UIImage imageNamed:@"girl_dongtai"];
    timeLabel.text = model.publishTime;
    contentLabel.text = model.content;
    deviceLabel.text = @"ios客户端";
    likeBtn.selected = (model.licked == 0) ? NO : YES;
    commonBtn.tag = 100 + self.row;
    likeBtn.tag = 100 + self.row;
    [likeBtn configButtonTitle:[NSString stringWithFormat:@"%ld",model.likeCount] fontSize:11 titleColor:UIColorFromRGB(0x505050)];
    likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    [commonBtn configButtonTitle:[NSString stringWithFormat:@"%ld",model.commentCount] fontSize:11 titleColor:UIColorFromRGB(0x505050)];
    commonBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    picContainerView.picUrlStringArr = model.images;
    picContainerView.sd_layout.topSpaceToView(contentLabel,5);
    
    [self setupAutoHeightWithBottomView:deviceLabel bottomMargin:15];
}

- (void)clickLike:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tweetListCellDidClickLikeAtIndex:)]) {
        [self.delegate tweetListCellDidClickLikeAtIndex:btn.tag - 100];
    }
}

- (void)clickCommont:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tweetListCellDidClickCommontAtIndex:)]) {
        [self.delegate tweetListCellDidClickCommontAtIndex:btn.tag - 100];
    }
}

@end
