//
//  GRTweetCommentModel.h
//  GREnglish
//
//  Created by CarlXu on 16/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRAuthor.h"

@interface GRTweetCommentModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) NSNumber *sourceId;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *publishTime;
@property (nonatomic, strong) GRAuthor *author;
@end

@interface GRCommentPostParm : NSObject

@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) NSNumber *sourceId;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, assign) NSNumber *user_id;
@property (nonatomic, assign) NSNumber *pid;
@end

@interface TweetCommonParm : NSObject

@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *source_id;
@end
