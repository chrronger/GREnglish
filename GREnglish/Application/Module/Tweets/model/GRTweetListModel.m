//
//  GRTweetModel.m
//  GREnglish
//
//  Created by CarlXu on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRTweetListModel.h"

@implementation GRTweetListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"author":@"Author"};
}
@end

@implementation TweetListParm


@end

