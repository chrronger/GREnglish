//
//  GRTweetCommentModel.h
//  GREnglish
//
//  Created by CarlXu on 16/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRAuthor.h"

//回复评论人的信息
@interface GRExtendsAuthor : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) NSInteger sex;
@end

//评论信息列表模型
@interface GRTweetCommentModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) NSNumber *sourceId;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *publishTime;
@property (nonatomic, strong) GRAuthor *author;
@property (nonatomic, strong) GRExtendsAuthor *extendsAuthor;

@end


//发送评论参数模型
@interface GRCommentPostParm : NSObject

@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) NSNumber *sourceId;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, assign) NSNumber *user_id;
@property (nonatomic, assign) NSNumber *pid;
@end

//评论列表数据请求参数模型
@interface TweetCommonParm : NSObject

@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *source_id;
@end
