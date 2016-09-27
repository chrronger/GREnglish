//
//  GRAllCategoryModel.h
//  GREnglish
//
//  Created by Waki on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAllCategoryModel : NSObject

@property (assign, nonatomic) int categoryId;
@property (copy, nonatomic) NSString *logoStr;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) int view;
@property (strong, nonatomic) NSArray *videoInfoList;

@end
