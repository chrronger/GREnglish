//
//  GRTweetModel.h
//  GREnglish
//
//  Created by CarlXu on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRAuthor.h"

//动弹模型
@interface GRTweetListModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger appClient;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger licked;
@property (nonatomic, copy)   NSString *publishTime;
@property (nonatomic, strong) GRAuthor *author;
@property (nonatomic, strong) NSArray *images;
@end

//动弹列表请求参数模型
@interface TweetListParm : NSObject

@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *user_id;
@end
