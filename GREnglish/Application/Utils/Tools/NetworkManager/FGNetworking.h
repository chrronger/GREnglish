//
//  NetworkClient.h
//  SoundTranslate
//
//  Created by Lucas on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} HttpMethod;


@interface FGNetworking : NSObject


//取消所有请求
+ (void)cancelAllRequest;
//取消某个请求
+ (void)cancelRequestWithURL:(NSString *)url;

+ (void)requsetWithPath:(NSString *)path
                 params:(NSDictionary *)params
                 method:(HttpMethod)mothod
            handleBlcok:(void (^)(id response, NSError *error))block;

@end
