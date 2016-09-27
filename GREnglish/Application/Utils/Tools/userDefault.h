//
//  userDefault.h
//  MeiTuanDemo
//
//  Created by CarlXu on 16/8/12.
//  Copyright © 2016年 CarlXu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define readFromPlist(key) [UserDefault readValueFromKey:key]
#define writeToPlist(dic)  [UserDefault writeDataWithDic:dic]
#define deleteInPlish(key) [UserDefault deleteDataWithKey:key]

@interface UserDefault : NSObject

+ (id)readValueFromKey:(NSString *)key;
+ (void)writeDataWithDic:(NSDictionary *)dic;
+ (void)deleteDataWithKey:(NSString *)key;
@end
