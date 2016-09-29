//
//  GRTweetCommentModel.m
//  GREnglish
//
//  Created by CarlXu on 16/9/28.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetCommentModel.h"

@implementation GRTweetCommentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"author":@"Author",
             @"extendsAuthor":@"GRExtendsAuthor"};
}
@end

@implementation GRExtendsAuthor

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end

@implementation GRCommentPostParm



@end

@implementation TweetCommonParm


@end
