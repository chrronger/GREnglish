//
//  NetworkClient.m
//  SoundTranslate
//
//  Created by Lucas on 16/8/15.
//  Copyright © 2016年 ZhongRuan. All rights reserved.
//

#import "FGNetworking.h"

/** 保存所有网络请求的task */
static NSMutableArray *kRequestTasks;

/** 基础URL */
static NSString *kNetworkBaseUrl = @"";

/** 请求的超时时间 */
static NSTimeInterval kTimeoutInterval = 60.f;

/** GET请求设置缓存，Post请求不缓存 */
//static BOOL FG_cacheGet  = YES;
//static BOOL FG_CachePost = NO;

/** 最大并行数 */
static NSInteger maxConcurrentCount = 3;

@implementation FGNetworking

+ (void)requsetWithPath:(NSString *)path
                 params:(NSDictionary *)params
                 method:(HttpMethod)mothod
            handleBlcok:(void (^)(id response, NSError *error))block
{
    if ([path length] <= 0 || nil == path) return;
    AFHTTPSessionManager *manager = [FGNetworking manager];
    [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionTask *sessionTask = nil;
    
    switch (mothod) {
        case Get:
        {
            sessionTask = [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(responseObject, nil)  ;
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        case Post:
        {
            sessionTask = [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        case Delete:
        {
            sessionTask = [manager DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        case Put:
        {
            sessionTask = [manager PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[self allTasks] removeObject:task];
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        default:
            break;
    }
    
    if (sessionTask) {
        [[FGNetworking allTasks] addObject:sessionTask];
    }
}

+ (void)uploadImage:(UIImage *)image
               path:(NSString *)path
           filename:(NSString *)filename
               name:(NSString *)name
             params:(NSDictionary *)params
           progress:(void (^)(CGFloat progressValue))progress
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))failure
{
    if (nil == image) return;
    NSURLSessionTask *sessionTask =
    [[FGNetworking manager] POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress((CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[FGNetworking allTasks] removeObject:task];
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allTasks] removeObject:task];
        if (failure) {
            failure(error);
        }
    }];
    [sessionTask resume];
    
    if (sessionTask) {
        [[FGNetworking allTasks] addObject:sessionTask];
    }
}

#pragma mark - Private
+ (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = nil;;
    if ([self baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes =
            [NSSet setWithArray:@[@"application/json",
                                  @"text/html",
                                  @"text/json",
                                  @"text/plain",
                                  @"text/javascript",
                                  @"text/xml",
                                  @"image/*"]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = kTimeoutInterval;
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = maxConcurrentCount;
    return manager;
}

+ (NSString *)baseUrl
{
    return kNetworkBaseUrl;
}

+ (void)updateBaseUrl:(NSString *)baseUrl {
    kNetworkBaseUrl = baseUrl;
}

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == kRequestTasks ) {
            kRequestTasks = @[].mutableCopy;
        }
    });
    
    return kRequestTasks;
}

+ (void)cancelAllRequest
{
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url
{
    if (nil == url) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]] &&
                [task.currentRequest.URL.absoluteString hasSuffix:url])
            {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}
@end
