//
//  GRTweetModel.h
//  GREnglish
//
//  Created by CarlXu on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@end

@interface GRTweetModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger appClient;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger licked;
@property (nonatomic, copy)   NSString *publishTime;
@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSArray *images;
@end


@interface TweetParm : NSObject

@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *user_id;
@end
