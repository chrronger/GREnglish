//
//  userDefault.m
//  MeiTuanDemo
//
//  Created by CarlXu on 16/8/12.
//  Copyright © 2016年 CarlXu. All rights reserved.
//

#import "UserDefault.h"



@implementation UserDefault

+ (id)readValueFromKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)writeDataWithDic:(NSDictionary *)dic
{
    [[NSUserDefaults standardUserDefaults] setObject:dic.allValues.firstObject forKey:dic.allKeys.firstObject];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteDataWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
