//
//  GRVideoModel.h
//  GREnglish
//
//  Created by Waki on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRVideoModel : NSObject
@property (assign, nonatomic) int  videoCount;
@property (assign, nonatomic) int videoId;
@property (assign, nonatomic) int recommended;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) int view;
@property (copy, nonatomic) NSString *teacherName;
@property (copy, nonatomic) NSString *videoType;
@property (copy, nonatomic) NSString *cover;
@property (assign, nonatomic) int collected;
@property (assign, nonatomic) int  collectionCount;
@property (assign, nonatomic) int commentCount;

@end
