//
//  GRTweetListCell.h
//  GREnglish
//
//  Created by CarlXu on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRTweetListModel.h"

@protocol TweetListDelegate <NSObject>

- (void)tweetListCellDidClickLikeAtIndex:(NSInteger)index;
- (void)tweetListCellDidClickCommontAtIndex:(NSInteger)index;

@end

@interface GRTweetListCell : UITableViewCell

@property (nonatomic, assign) id<TweetListDelegate> delegate;
@property (nonatomic, strong) GRTweetListModel *model;
@property (nonatomic, assign) NSInteger row;
@end
